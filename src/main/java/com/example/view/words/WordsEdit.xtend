package com.example.view.words

import com.example.Word
import com.example.validator.FieldErrorDTO
import com.example.view.partial.Errors
import com.example.view.partial.TextField
import com.example.view.tag.Html
import java.util.List

class WordsEdit extends WordsView {

	def String render(Word word, 
		              List<FieldErrorDTO> fieldErrorDTOList) {
		val view = '''
			<h3 class="ui dividing header">Edit Word</h3>
			
			«Errors::render(fieldErrorDTOList)»
			
			«Html::formTag.clazz("ui form").action("/words/{id}").param(word.id).method("put").buildWithBlock([
			   '''
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
                       <td>
                         «TextField::render("word", "word", word.word, fieldErrorDTOList)»
                       </td>
                     </tr>      
                   </tbody>
                 </table>
                 «Html::linkTag().content("Cancel").path("/words/{id}").param(word.id).build»
                 <input type="submit" name="submit" value="Submit" class="ui button" />
               '''
           ])»
		'''
		
		renderLayout(view)
	}
}
