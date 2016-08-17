package com.example.util;

import org.apache.commons.lang.builder.ToStringBuilder;

public class WordSearchParams implements SearchParams {
	private String searchItem;

	
	@Override
	public String getUrlParams() {
		return ToStringBuilder.reflectionToString(this, new UrlParamsStyle());
	}


	public String getSearchItem() {
		return searchItem;
	}


	public void setSearchItem(String searchItem) {
		this.searchItem = searchItem;
	}	
}
