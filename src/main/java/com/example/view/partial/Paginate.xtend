package com.example.view.partial

import com.example.util.paging.Pager
import com.example.view.tag.Html
import java.util.Map
import org.apache.commons.collections4.CollectionUtils
import org.springframework.data.domain.Page

class Paginate {
    def static render(Page<?> list, String path, Map<String, String> queryParams, int inner, int outer,
        boolean showFirstLast) {
        val pager = new Pager
        pager.setCurrentPage(list.number)
        pager.setPageCount(list.totalPages)
        pager.setInnerItemsCount(inner)
        pager.setOuterItemsCount(outer)
        val pagerItems = pager.items

        '''
            «IF !CollectionUtils.isEmpty(pagerItems)»
                <div class="ui pagination menu">
                  «FOR pagerItem : pagerItems»
                      «Html::linkTag
                      .content(pagerItem.label)
                      .path(path)
                      .queryParams(queryParams)
                      .queryParam("page", pagerItem.pageNumber)
                      .clazz("item")
                      .clazzIf("active", pagerItem.currentPage)
                      .renderIf(pagerItem.enabled)
                      .build»
                      «Html::tag
                      .tagName("div")
                      .content(pagerItem.label)
                      .clazz("disabled item")
                      .renderIf(!pagerItem.enabled)
                      .build»
                  «ENDFOR»
                </div>
                <div style="clear:both"></div>
            «ENDIF»
        '''
    }
}
