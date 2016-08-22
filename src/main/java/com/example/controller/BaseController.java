package com.example.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import com.example.validator.FieldErrorDTO;

@Controller
public class BaseController {

    @Autowired
    protected ResourceBundleMessageSource messageSource;

    protected List<FieldErrorDTO> getFieldErrorDTOList(BindingResult result) {

        List<FieldErrorDTO> fieldErrorDTOList = new ArrayList<FieldErrorDTO>();
        Locale currentLocale = LocaleContextHolder.getLocale();
        for (FieldError fieldError : result.getFieldErrors()) {
            FieldErrorDTO fieldErrorDTO = new FieldErrorDTO();
            fieldErrorDTO.setObjectName(fieldError.getObjectName());
            fieldErrorDTO.setField(fieldError.getField());
            fieldErrorDTO.setMessage(messageSource.getMessage(fieldError, currentLocale));

            fieldErrorDTOList.add(fieldErrorDTO);
        }
        return fieldErrorDTOList;
    }
}
