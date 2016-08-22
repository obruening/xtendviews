package com.example.view

import java.util.Map

class BaseLayout {

    protected Map<String, Object> model

    def init(Map<String, Object> model) {
        this.model = model
    }
}
