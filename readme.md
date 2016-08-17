# Spring Boot project that uses [Xtend](http://www.xtend-lang.org/) classes as views

Getting started
---------------
- Install the Xtend plugin: http://www.eclipse.org/xtend/download.html
- Import the project to your IDE
- Start XtendviewsApplication.java as a Spring Boot application or 
- Start from the command line with `mvn spring-boot:run`
- Open die URL [http://localhost:8080/words](http://localhost:8080/words)

Benefits
--------
- Get full code completion in views
- HTML Helpers with fluent API to generate tags
- Create nested HTML with Xtend lambdas
- Create reusable partials, e. g. for pagination
- Create layouts
- Pass typed parameters to views and/or
- Pass Spring MVC's "model" to views for commonly used parameters

Code examples
-------------

Link tag

`«Html::linkTag.content("Edit").path("/words/{id}/edit").param(word.id).build»`

Input Tag nested in div tag

    «Html::tag
          .tagName("div")
          .clazz("field")
          .clazzIf("error", Errors.hasErrorOnField(name, fieldErrorDTOList))
          .buildWithBlock(['''
              «Html.textFieldTag.id(id).name(name).value(value).build»
          '''])»

Render Partial

`«Paginate::render(wordsPage, "/words", queryParams, 1, 1, false)»`


