package com.example.view.tag

import java.util.ArrayList
import java.util.List
import java.util.Map
import java.util.TreeMap
import org.springframework.util.LinkedMultiValueMap
import org.springframework.web.util.UriComponentsBuilder

class FormTag<T extends FormTag<?>> extends Tag<T> {
	
	String action
	List<String> params = new ArrayList<String>
	Map<String, String> queryParams = new TreeMap<String, String>
	String method
	
	new() {
		super()
		this.tagName("form")
	}
	
	def action(String action) {
		this.action = action
		this as T
	}
	
	def method(String method) {
		this.method = method
		this as T
	}
	
	def param(String param) {
		params.add(param);
		this as T
	}

	def param(Long param) {
		param(String.valueOf(param))
		this as T
	}
	
	def queryParam(String key, String value) {
		queryParams.put(key, value)
		this as T
	}

	def queryParam(String key, Long value) {
		queryParam(key, String.valueOf(value))
		this as T
	}
	
	def queryParams(Map<String, String> queryParams) {
		this.queryParams = new TreeMap<String, String>(queryParams)
		this as T
	}
	
	def removeQueryParam(String key) {
		this.queryParams.remove(key);
		this as T
	}
	
    override String build() {
    	if (!condition) {
			return ""
		}
    	
    	val url = UrlHelper::toUrl(action, params, queryParams)
    	
    	val isPut = "put".equalsIgnoreCase(method)
    	if (isPut) {
    		this.method("post");
    	}
    	
    	if (l != null) {
		  '''
		    <«tagName» action="«url»" «attributesString(attributes)» method="«method»">
		      «IF isPut»
		        <input type="hidden" name="_method" value="PUT" />
		      «ENDIF»
		      «l.f»
		    </«tagName»>
		  '''
		} else {
		  '''
		  '''
		}
	}
}