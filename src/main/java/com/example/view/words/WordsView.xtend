package com.example.view.words

import com.example.view.BaseView
import com.example.view.layout.AppLayout

class WordsView extends BaseView {

    protected val appLayout = new AppLayout

    protected def renderLayout(String view) {
        appLayout.init(model)
        appLayout.render(view)
    }
}
