<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一个人可以被毁灭，但绝不可以被打败</title>
<!--字体图标-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/icomoon.css" rel="stylesheet" />
<!--动画-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/animate.css" rel="stylesheet" />
<!--骨架样式-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/common.css" rel="stylesheet" />
<!--皮肤（缇娜）-->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/skin/tina.css" rel="stylesheet" />
<!--jquery，不可修改版本-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--全局动态修改-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/js/common.js"></script>
<!--核心组件-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex.min.js"></script>
<!--表单验证-->
<script src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex-formVerify.js"></script>
<link href="${pageContext.request.contextPath}/static/javaex/pc/lib/highlight/highlight.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/static/javaex/pc/lib/highlight/highlight.min.js"></script>
</head>
<body>
<div class="breadcrumb">
	<span>文章管理</span>
	<span class="divider">/</span>
	<span class="active">文章编辑</span>
</div>

	<div class="list-content">
	<!--块元素-->
	<div class="block">
		<!--修饰块元素名称-->
		<div class="banner">
			<p class="tab fixed">文章编辑</p>
		</div>
	
		<!--正文内容-->
		<div class="main">
			<form id="form" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="id" value="${articleInfo.id }">
				<!--文本框-->
				<div class="unit clear">
					<div class="left"><span class="required">*</span><p class="subtitle">标题</p></div>
					<div class="right">
						<input type="text" class="text" data-type="必填"  error-pos="42" placeholder="请输入文章标题" name="title" value="${articleInfo.title }"/>
					</div>
				</div>
				
				<!--置顶0默认/1右侧/2左上/3轮播-->
				<div class="unit clear">
					<div class="left"><span class="required">*</span><p class="subtitle">置顶</p></div>
					<div class="right">
						<input type="text" class="text" data-type="必填"  error-pos="42" placeholder="请输入置顶0默认/1右侧/2右上/3轮播" name="placement" value="${articleInfo.placement }"/>
					</div>
				</div>
				
				<!--下拉选择框-->
				<div class="unit clear">
					<div class="left"><span class="required">*</span><p class="subtitle">所属分类</p></div>
					<div class="right">
					       <select id="type_id" name="typeId">
					<c:forEach items="${typelist }" var="type_item" varStatus="status">
							<option value="${type_item.id }" 
							<c:if test="${articleInfo.typeId == type_item.id }">  selected="selected" </c:if>>${type_item.name}</option>
					</c:forEach>
							</select>
											
					</div>
				</div>
				
				<!-- 文章封面 -->
				<div class="unit clear">
                <div class="left"><p class="subtitle">文章封面</p></div>			
					<div class="right">
				<div id="container" class="file-container">
					<div class="cover" >
						<!--如果不需要回显图片，src留空即可-->
						<c:choose>
						  <c:when test="${empty articleInfo.converimg }">
						      <input type="hidden" id="sun" value="1"/>
						     <img class="image" src="${pageContext.request.contextPath}/static/javaex/pc/images/preview.jpg">
						  </c:when>
						  <c:otherwise>
                              	<img class="upload-img-cover image" src="${articleInfo.converimg }"/>
						  </c:otherwise>
						  </c:choose> 
						   <input type="file" name="converimg" class="file" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
					</div>
				  
				</div>
				    </div>
				</div>				
				
				<!--简介-->
				<div class="unit clear">
					<div class="left"><span class="required">*</span><p class="subtitle">标题</p></div>
					<div class="right">
						<input type="text" class="text" data-type="必填"  error-pos="42" placeholder="请输入文章标题" id="contentText" name="contentText" value="${articleInfo.contentText }"/>
					</div>
				</div>		
		
				<!--文本域-->
				<div class="unit clear">
			   <div class="left"><span class="required">*</span><p class="subtitle">内容</p></div>			
					<div class="right">
						<div id="edit" class="javaex-edit-content">
					       <c:out value="${articleInfo.content}" escapeXml="false"/>
						</div>
						<input type="hidden"  id="content" name="content" value=""/>                       
						<!-- <input type="hidden"  id="contentText" name="contentText" value=""/> -->                       
					</div>
				</div>
				
				<!--提交按钮-->
				<div class="unit clear" style="width: 800px;">
					<div style="text-align: center;">
						<!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
						<input type="button" id="return" class="button no" value="返回" />
						<input type="button" id="save" class="button yes" value="保存" />
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
<style>
.edit-editor-body .edit-body-container {
	height: 200px;
}
</style>
<script>
javaex.upload({
	type : "image",
	url : "upload.json",	// 请求路径
	id : "upload",			// <input type="file" />的id
	containerId : "container",	// 容器id
	param : "file",			// 参数名称，Spring中与MultipartFile的参数名保持一致
	dataType : "url",		// 返回的数据类型：base64 或 url
	callback : function (rtn) {
			if (rtn.code=='1') {
			$("#container img").attr("src", "/upload/"+rtn.data.imgUrl);
			} else {
				javaex.optTip({
					content : rtn.message,
						type : "error"
				});
				}
			}
});
	javaex.select({
		id : "type_id",
		isSearch : false,    //设置是否可以搜索
		// 回调函数
		callback: function (rtn) {
			console.log("selectValue:" + rtn.selectValue);
			console.log("selectName:" + rtn.selectName);
		}
	});

	var content='${articleInfo.content}'
	javaex.edit({
		id : "edit",
		image : {
			url : "upload.json",	// 请求路径
			param : "file",		// 参数名称，Spring中与MultipartFile的参数名保持一致
			dataType : "url",	// 返回的数据类型：base64 或 url
			isShowOptTip : true,	// 是否显示上传提示
			rtn : "rtnData",	// 后台返回的数据对象，在前台页面用该名字存储
			imgUrl : "data.imgUrl",	// 根据返回的数据对象，获取图片地址。  例如后台返回的数据为：{code: "000000", message: "操作成功！", data: {imgUrl: "/1.jpg"}}
		    prefix:"http://lizblog.top:8080/upload/",
		    
		},
		content:content,
		isInit : true,
		callback : function(rtn) {
			$("#content").val(rtn.html);
			
			
		}
	});
	
	
//返回事件
$("#return").click(function(){
	history.back();
});

//提交事件
$("#save").click(function(){
	if (javaexVerify()) {	
	var sum=$("#sun").val();
	if(sum==1){	
		var src=$(".image").attr("src");		
	}else{	
		var src=$(".image").attr("src");		
	}

	//alert("当前图片的地址"+src);
	$.ajax({
		type:"post",
		datatype:"json",
		url:"saveImg.json",
		data:$("#form").serialize()+"&converimg="+src,
		success:function(rtn){
			if(rtn.code=='1'){
				javaex.optTip({
					content : rtn.message,
				});
				// 建议延迟加载
				setTimeout(function() {
					// 跳转页面
					window.location.href = "${pageContext.request.contextPath}/article_info/list_namal.action";
				}, 2000);
			}else{
				javaex.optTip({
					content : "操作失败",
					type : "error"
				});
			}
		}
	});
	}
});
	
</script>
</html>