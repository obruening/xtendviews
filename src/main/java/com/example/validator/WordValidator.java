package com.example.validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.example.Word;

public class WordValidator implements Validator {
	
	private static Logger logger = LoggerFactory.getLogger(WordValidator.class);
	
	@Override
	public boolean supports(Class<?> clazz) {
		return Word.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object object, Errors errors) {
		ValidationUtils.rejectIfEmpty(errors, "word", "word.empty");
	}
	
}
