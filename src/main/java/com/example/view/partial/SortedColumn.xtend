package com.example.view.partial

import com.example.view.tag.Html
import java.util.Map

class SortedColumn {
		
	def static render(String label, 
	                  String column, 
	                  String sortDir, 
	                  String sortColumn, 
	                  String path,
                      Map<String, String> queryParams, 
                      String style) {
		'''
		
		«Html::tag
		      .tagName("th")
		      .attrIf("style", style, style != null)
		      .clazzIf("sorted descending", sortColumn.equals(column) && "DESC".equals(sortDir))
		      .clazzIf("sorted ascending", sortColumn.equals(column) && "ASC".equals(sortDir))
		      .block([
		          '''
		       	    «Html::linkTag
		                  .content(label)
		                  .path(path)
		                  .queryParams(queryParams)
		                  .queryParam("sort", column + ",DESC")
		                  .removeQueryParam("page")
		                  .renderIf("ASC".equals(sortDir) && column.equals(sortColumn))
		                  .build»

		            «Html::linkTag
		                  .content(label)
		                  .path(path)
		                  .queryParams(queryParams)
		                  .queryParam("sort", column + ",ASC")
		                  .removeQueryParam("page")
		                  .renderIf(!("ASC".equals(sortDir) && column.equals(sortColumn)))
		                  .build»
		          '''
		       ])
		       .build»

		'''
	}
}