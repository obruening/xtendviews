package com.example.view.partial

import com.example.validator.FieldErrorDTO
import com.example.view.tag.Html
import java.util.List

class TextField {

    def static String render(String id, String name, String value, List<FieldErrorDTO> fieldErrorDTOList) {
        '''
            «Html::tag
                  .tagName("div")
                  .clazz("field")
                  .clazzIf("error", Errors.hasErrorOnField(name, fieldErrorDTOList))
                  .buildWithBlock(['''
                       «Html.textFieldTag.id(id).name(name).value(value).build»
                   '''])»
        '''
    }
}
