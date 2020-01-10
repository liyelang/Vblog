package com.uplooking.view;

import java.util.HashMap;
import java.util.Map;

import org.springframework.util.StringUtils;

public class Result {

	// code 状态码 成功 1 失败0

	private Integer code;
	private String message;
	private Map<String, Object> data = new HashMap<String, Object>();

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	// 成功
	public static Result success() {
		Result result = new Result();
		result.setCode(1);
		result.setMessage("操作成功");
		return result;
	}

	// 失败
	public static Result error(String str) {
		Result result = new Result();
		result.setCode(0);
		if (StringUtils.isEmpty(str)) {
			result.setMessage("操作失败");
		} else {
			result.setMessage(str);
		}
		return result;
	}

	// data参数
	public Result add(String key, Object value) {
		this.getData().put(key, value);
		return this;
	}

	@Override
	public String toString() {
		return "Result [code=" + code + ", message=" + message + ", data=" + data + "]";
	}
	
	
}
