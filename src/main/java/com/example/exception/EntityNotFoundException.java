package com.example.exception;

public class EntityNotFoundException extends BaseException {

	private static final long serialVersionUID = -1022026326788269270L;

	public EntityNotFoundException(String message) {
		super(message);
	}
}
