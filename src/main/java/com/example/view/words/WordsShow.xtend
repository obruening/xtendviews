package com.example.view.words

import com.example.Word
import com.example.view.partial.Flash
import com.example.view.tag.Html

class WordsShow extends WordsView {
        
	def String render(Word word) {
	    val view = '''
          <h3 class="ui dividing header">Show Word</h3>
          
          «Flash.render(model.get("flash") as String)»
    
          <table class="ui sortable celled table">
            <thead>
              <tr>
                <th style="width:170px">Key</th>
                <th>Value</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Id</td>
                <td>«word.id»</td>
              </tr>
              <tr>
                <td>Word</td>
                <td>«word.word»</td>
              </tr>      
            </tbody>
          </table>
          
          «Html::linkTag.content("Back").path("/words/last").build» | 
          «Html::linkTag.content("Edit").path("/words/{id}/edit").param(word.id).build»
		'''
		
		renderLayout(view)
	}
}
