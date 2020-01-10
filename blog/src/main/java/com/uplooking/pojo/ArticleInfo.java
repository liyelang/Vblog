package com.uplooking.pojo;



public class ArticleInfo {

	private String id;
	private String title;
	private String content;
	private String contentText;
	private String converimg;
	private Integer viewCount;
	private String updateTime;
	private int status;
	private String typeId;
	   //置顶控制
    private Integer placement;
    private Integer typenum;
    
    // 替补大类
    private String numName;
	
	// 替补字段 文章分类名称
	private String name;

	public Integer getPlacement() {
		return placement;
	}

	public void setPlacement(Integer placement) {
		this.placement = placement;
	}

	public Integer getTypenum() {
		return typenum;
	}

	public void setTypenum(Integer typenum) {
		this.typenum = typenum;
	}

	public String getNumName() {
		return numName;
	}

	public void setNumName(String numName) {
		this.numName = numName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getContentText() {
		return contentText;
	}

	public void setContentText(String contentText) {
		this.contentText = contentText;
	}

	public String getConverimg() {
		return converimg;
	}

	public void setConverimg(String converimg) {
		this.converimg = converimg;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
