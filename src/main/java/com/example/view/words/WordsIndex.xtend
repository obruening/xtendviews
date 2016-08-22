package com.example.view.words

import com.example.Word
import com.example.util.WordSearchParams
import com.example.view.partial.Paginate
import com.example.view.partial.SortedColumn
import com.example.view.tag.Html
import java.util.Map
import org.apache.commons.collections4.CollectionUtils
import org.springframework.data.domain.Page

class WordsIndex extends WordsView {

    def String render(Page<Word> wordsPage, Map<String, String> queryParams, String sortDir, String sortColumn,
        WordSearchParams wordSearchParams) {
        val view = '''
            <h3 class="ui dividing header">Words</h3>
            
            «Html::formTag.clazz("ui form").action("/words").queryParams(queryParams).method("get")
                    .buildWithBlock([
                '''
                  <div class="ui form">
                    <div class="fields">
                      <div class="inline field">
                        <label for="search">Search Word</label>
                        «Html::textFieldTag.id("searchItem").name("searchItem").value(wordSearchParams.searchItem as String).build»
                      </div>
                      <input type="submit" class="ui submit button" value="Search" />
                    </div>
                  </div>
                '''
            ])»
            
            
            <table class="ui sortable celled compact table">
              <thead>
                <tr>
                  «SortedColumn::render("Id", "id", sortDir, sortColumn, "/words", queryParams, "width:100px")»
                  «SortedColumn::render("Word", "word", sortDir, sortColumn, "/words", queryParams, null)»
                  <th style="width:150px">Action</th>
                </tr>
              </thead>
              <tbody>
                «FOR word : wordsPage.content»
                    <tr>
                      <td>«word.id»</td>
                      <td>«word.word»</td>
                      <td>
                        «Html::linkTag.content("Show").path("/words/{id}").param(word.id).build» |
                        «Html::linkTag.content("Edit").path("/words/{id}/edit").param(word.id).build»
                      </td>
                    </tr>
                «ENDFOR»
                «IF CollectionUtils.isEmpty(wordsPage.content)»
                    <tr>
                      <td colspan="3">
                        No words found.
                      </td>
                    </tr>      
                «ENDIF»
              </tbody>
            </table>
            
            
            «Paginate::render(wordsPage, "/words", queryParams, 1, 1, false)»
        '''

        renderLayout(view)
    }
}
