package com.example.view

import java.util.Map

interface Layout {
    def String render(Map<String, Object> model, String body)
}
