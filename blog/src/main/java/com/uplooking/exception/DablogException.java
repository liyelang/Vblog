package com.uplooking.exception;

public class DablogException extends Exception{

	private String message;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public DablogException(String message) {
		super();
		this.message = message;
	}
	
	
}
