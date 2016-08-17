package com.example.validator;

public class FieldErrorDTO extends GlobalErrorDTO {
	private String field;

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}
}
