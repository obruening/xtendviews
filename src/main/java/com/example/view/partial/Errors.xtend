package com.example.view.partial

import com.example.validator.FieldErrorDTO
import java.util.List

class Errors {
    def static boolean hasErrorOnField(String name, List<FieldErrorDTO> fieldErrorDTOList) {
        if (fieldErrorDTOList == null) {
            return false
        }
        fieldErrorDTOList.map[fieldErrorDTO|fieldErrorDTO.field].exists[field|field == name]
    }

    def static boolean hasErrors(List<FieldErrorDTO> fieldErrorDTOList) {
        (fieldErrorDTOList != null) && (fieldErrorDTOList.size > 0)
    }

    def static render(List<FieldErrorDTO> fieldErrorDTOList) {
        '''
            «IF hasErrors(fieldErrorDTOList)»
                <div class="ui negative message">
                  <div class="header">Fix these errors:</div>
                  «fieldErrorDTOList.map[element | '''<p>«element.message»</p>'''].join»
                </div>
            «ENDIF»
        '''
    }

}
