package com.example.view.tag

import com.example.util.AttributeStyle
import org.apache.commons.lang.StringUtils
import org.apache.commons.lang.builder.ToStringBuilder
import org.springframework.util.LinkedMultiValueMap
import org.springframework.util.MultiValueMap

class Tag<T extends Tag<?>> {

	protected String tagName
	protected MultiValueMap<String, String> attributes = new LinkedMultiValueMap<String, String>
	protected boolean condition = true
	protected String content
	protected LambdaInterface l;
	
	def tagName(String tagName) {
	    this.tagName = tagName
	    this as T
	}
	
    def content(String content) {
	    this.content = content
	    this as T
	}
	
	def attr(String key, String value) {
		attributes.add(key, value)
	    this as T
	}

	def attr(String key, Long value) {
		attr(key, String.valueOf(value))
		this as T
	}

	def attrIf(String key, String value, boolean condition) {
		if (condition) {
		    attributes.add(key, value)
		}
	    this as T
	}

	def attrIf(String key, Long value, boolean condition) {
		attrIf(key, String.valueOf(value), condition)
		this as T
	}
	
	def clazz(String value) {
	    attr("class", value)
	    this as T
	}
	
	def clazzIf(String value, boolean condition) {
        attrIf("class", value, condition)
        this as T
    }
    
	
	def renderIf(boolean condition) {
		this.condition = condition
		this as T
	}
	
    def block(LambdaInterface l) {
		this.l = l;
		this as T
	}
	
	def String build() {
		if (!condition) {
			return ""
		}

		if (l != null) {
		'''
		  <«tagName» «attributesString(attributes)»>«l.f»</«tagName»>
		'''
	    } else {
		'''
		  <«tagName» «attributesString(attributes)»>«content»</«tagName»>
		'''
	    }
	}
	
    def String buildWithBlock(LambdaInterface l) {
        this.l = l;
        build
    }	
	
	def protected attributesString(MultiValueMap<String, String> atttributes) {
		if (atttributes == null) {
			return ""
		}
		
		val toStringBuilder = new ToStringBuilder(attributes, new AttributeStyle())
		
		for (entry : atttributes.entrySet) {
          val key = entry.key
          val value = StringUtils.join(entry.value, " ");
          toStringBuilder.append(key, "\"" + value + "\"")
        }
        
		toStringBuilder.toString
	}
	
}