package com.example.view.partial

import org.apache.commons.lang.StringUtils

class Flash {
    def static render(String flash) {
        '''
            «IF StringUtils.isNotBlank(flash)»
                <div class="ui positive message">
                  <div class="header">Success!</div>
                  «flash»
                </div>
            «ENDIF»
        '''
    }
}
