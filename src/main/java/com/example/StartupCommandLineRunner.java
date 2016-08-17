package com.example;

import java.io.InputStream;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;


@Component
public class StartupCommandLineRunner implements CommandLineRunner {
	
	@Autowired
	WordsRepository wordsRepository;
	
	private static Logger logger = LoggerFactory.getLogger(StartupCommandLineRunner.class);

	@Override
	@Transactional
	public void run(String... arguments) throws Exception {
		wordsRepository.deleteAll();
		Resource resource = new ClassPathResource("words.txt");
		InputStream inputStream = resource.getInputStream();
	    List<String> wordList = IOUtils.readLines(inputStream);
	    for (String word : wordList) {
	    	Word wordInstance = new Word();
	    	wordInstance.setWord(word);
	    	
		    wordsRepository.save(wordInstance);
		}
	}
}
