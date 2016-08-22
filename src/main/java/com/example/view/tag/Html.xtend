package com.example.view.tag

class Html {
    def static Tag<Tag<?>> tag() {
        new Tag<Tag<?>>
    }

    def static LinkToTag<LinkToTag<?>> linkTag() {
        new LinkToTag<LinkToTag<?>>
    }

    def static TextFieldTag<TextFieldTag<?>> textFieldTag() {
        new TextFieldTag<TextFieldTag<?>>
    }

    def static FormTag<FormTag<?>> formTag() {
        new FormTag<FormTag<?>>
    }
}
