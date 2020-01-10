package com.uplooking.pojo;

public class TypeInfo {

	private Integer id;
	private String name;
	private String sort;
	
	/*
	 * 大类
	 */
	private String num;
	
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public TypeInfo() {
	
	}
	public TypeInfo(Integer id, String name, String sort) {
		
		this.id = id;
		this.name = name;
		this.sort = sort;
	}
	
	

}
