package com.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class XtendviewsApplication {

    private static Logger logger = LoggerFactory.getLogger(XtendviewsApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(XtendviewsApplication.class, args);
    }
}
