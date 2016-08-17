package com.example.view.tag

class TextFieldTag<T extends TextFieldTag<?>> extends Tag<T> {
	
	new() {
		super()
		this.tagName("input")
		this.attr("type", "text")
	}
	
	def id(String id) {
		this.attr("id", id)
	}

	def name(String name) {
		this.attr("name", name)
	}
	
	def value(String value) {
		this.attr("value", value)
	}
}