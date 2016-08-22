package com.example.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.Word;
import com.example.WordsRepository;
import com.example.exception.EntityNotFoundException;
import com.example.util.WordSearchParams;
import com.example.validator.WordValidator;
import com.example.view.words.WordsEdit;
import com.example.view.words.WordsIndex;
import com.example.view.words.WordsShow;

@Controller
@RequestMapping(value = "/words")
@SessionAttributes("wordSearchParams")
public class WordsController extends BaseController {

    @Autowired
    WordsRepository wordsRepository;

    private static Logger logger = LoggerFactory.getLogger(WordsController.class);

    @ModelAttribute("wordSearchParams")
    public WordSearchParams createWordSearchParams() {
        return new WordSearchParams();
    }

    @RequestMapping(value = "/last", method = RequestMethod.GET)
    public String indexLast(Model model, HttpSession session) {

        Map<String, String> queryParams = new TreeMap<String, String>();

        Pageable pageable = (Pageable) session.getAttribute("pageable");
        if (pageable != null) {
            addPageableQueryParams(pageable, queryParams);
        }
        WordSearchParams wordSearchParams = (WordSearchParams) session.getAttribute("wordSearchParams");
        if (wordSearchParams != null) {
            addWordSearchQueryParams(wordSearchParams, queryParams);
        }

        List<String> paramList = new ArrayList<String>();
        for (Map.Entry<String, String> entry : queryParams.entrySet()) {
            paramList.add(entry.getKey() + "=" + entry.getValue());
        }
        String queryString = StringUtils.join(paramList, "&");

        if (StringUtils.isNotBlank(queryString)) {
            return "redirect:/words?" + queryString;
        } else {
            return "redirect:/words";
        }

    }

    private void addPageableQueryParams(Pageable pageable, Map<String, String> queryParams) {
        queryParams.put("page", String.valueOf(pageable.getPageNumber()));
        Order order = getFirstOrder(pageable);
        queryParams.put("sort", order.getProperty() + "," + order.getDirection().toString());
    }

    private void addWordSearchQueryParams(WordSearchParams wordSearchParams, Map<String, String> queryParams) {
        if (StringUtils.isNotBlank(wordSearchParams.getSearchItem())) {
            queryParams.put("searchItem", wordSearchParams.getSearchItem());
        }
    }

    // http://localhost:8080/basement/words?page=0&sort=id,desc
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(Model model, @ModelAttribute("wordSearchParams") WordSearchParams wordSearchParams,
            @PageableDefault(page = 0, value = 10, direction = Sort.Direction.ASC, sort = { "word" }) Pageable pageable,
            @RequestParam Map<String, String> queryParams, HttpServletResponse response, HttpSession session)
            throws Exception {
        session.setAttribute("pageable", pageable);
        Page<Word> wordsPage = null;
        if (StringUtils.isNotBlank(wordSearchParams.getSearchItem())) {
            wordsPage = wordsRepository.findByWordContaining(wordSearchParams.getSearchItem(), pageable);
            queryParams.put("searchItem", wordSearchParams.getSearchItem());
        } else {
            wordsPage = wordsRepository.findAll(pageable);
        }
        model.addAttribute("title", "Index");
        Order order = getFirstOrder(pageable);
        WordsIndex view = new WordsIndex();
        view.init(model.asMap());
        response.getWriter().write(view.render(wordsPage, queryParams, order.getDirection().toString(),
                order.getProperty(), wordSearchParams));
        return null;
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String show(Model model, @PathVariable("id") long id, HttpServletResponse response) throws Exception {
        Word word = wordsRepository.findOne(id);
        model.addAttribute("title", "Show");
        WordsShow view = new WordsShow();
        view.init(model.asMap());
        response.getWriter().write(view.render(word));
        return null;
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable("id") long id, HttpServletResponse response) throws Exception {
        Word word = wordsRepository.findOne(id);
        model.addAttribute("title", "Edit");
        WordsEdit view = new WordsEdit();
        view.init(model.asMap());
        response.getWriter().write(view.render(word, null));
        return null;
    }

    @ModelAttribute("word")
    public Word getInitializedWord() {
        return new Word();
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public String update(@PathVariable("id") long id, @ModelAttribute("word") Word word, BindingResult result,
            Model model, RedirectAttributes redirectAttributes, HttpServletResponse response) throws Exception {
        WordValidator wordValidator = new WordValidator();
        wordValidator.validate(word, result);
        if (result.hasErrors()) {
            logger.info(result.toString());
            model.addAttribute("title", "Edit");
            WordsEdit view = new WordsEdit();
            view.init(model.asMap());
            response.getWriter().write(view.render(word, getFieldErrorDTOList(result)));
            return null;
        }

        Word savedWord = wordsRepository.findOne(id);
        if (savedWord != null) {
            savedWord.setWord(word.getWord());
            wordsRepository.save(savedWord);
        } else {
            throw new EntityNotFoundException(String.format("Entity Word %d not found.", id));
        }
        redirectAttributes.addFlashAttribute("flash", "Successfully saved.");
        return String.format("redirect:/words/%s", id);
    }

    private Order getFirstOrder(Pageable pageable) {
        Iterator<Order> iterator = pageable.getSort().iterator();
        if (iterator.hasNext()) {
            return iterator.next();
        }
        throw new IllegalArgumentException("Pageable must provide a sort order.");
    }

}
