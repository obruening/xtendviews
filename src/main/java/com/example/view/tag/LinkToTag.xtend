package com.example.view.tag

import java.util.ArrayList
import java.util.List
import java.util.Map
import java.util.TreeMap
import org.springframework.util.LinkedMultiValueMap
import org.springframework.web.util.UriComponentsBuilder

class LinkToTag<T extends LinkToTag<?>> extends Tag<T> {
	
	String path
	List<String> params = new ArrayList<String>
	Map<String, String> queryParams = new TreeMap<String, String>
	
	new() {
		super()
		this.tagName("a")
	}
	
	def path(String path) {
		this.path = path
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
    	
    	val url = UrlHelper::toUrl(path, params, queryParams)
    	if (l != null) {
		  '''
		    <«tagName» href="«url»" «attributesString(attributes)»>«l.f»</«tagName»>
		  '''
		} else {
		  '''
		    <«tagName» href="«url»" «attributesString(attributes)»>«content»</«tagName»>
		  '''
		}
	}
}