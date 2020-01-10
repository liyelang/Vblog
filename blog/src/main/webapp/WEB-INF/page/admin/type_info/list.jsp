<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
</head>
<body>
<div class="breadcrumb">
	<span>分类管理</span>
	<span class="divider">/</span>
	<span class="active">文章分类</span>
</div>
	<div class="list-content">
	<!--块元素-->
	<div class="block">
		<!--页面有多个表格时，可以用于标识表格-->
		<h2>文章分类列表</h2>
		<!--正文内容-->
		<div class="main-20">
			<!--表格上方的搜索操作-->
			<div class="admin-search">
				<div class="input-group">
					<input id="typetxt" type="text" class="text" placeholder="提示信息" />
					<button id="btn" class="button blue">搜索</button>
				</div>
			</div>
			
			<!--表格上方的操作元素，添加、删除等-->
			<div class="operation-wrap">
				<div class="buttons-wrap">
					<button id="add" class="button blue radius-3"><span class="icon-plus"></span> 添加</button>
					<button id="insert" class="button green radius-3"><span class="icon-check2"></span> 保存</button>
					<button id="del" class="button red radius-3"><span class="icon-close2"></span> 删除</button>
				</div>
			</div>
			<table id="table" class="table color2">
				<thead>
					<tr>
						<th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
						<th>显示顺序</th>
						<th>类型</th>
						<th>1学无止境/2慢生活</th>
					</tr>
				</thead>
				<tbody>
				<!-- 显示文章列表 -->
				<c:forEach items="${lists}" var="item" varStatus="status">
					<tr>
						<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="${item.id }"/> </td>
					
						<td><input type="text" class="text" name="sort" data-type="正整数" error-msg="必须输入正整数" style="width:100px" value="${item.sort }"/></td>
						<td><input type="text" class="text" name="name" data-type="必填" error-msg="请输入分类名称" style="width:100px" value="${item.name }"/></td>
						<td><input type="text" class="text" name="num" data-type="必填" error-msg="请输入大类名称" style="width:100px" value="${item.num }"/></td>
						
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

</body>
<script type="text/javascript">

var idArr=new Array();
var sortArr=new Array();
var nameArr=new Array();
var numArr=new Array();

//添加文本框
$("#add").click(function(){
	  var html='';
	  html+='<tr>';
	  html+='<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="${item.id }"/> </td>';
	  html+='<td><input type="text" class="text" name="sort" data-type="正整数" error-msg="必须输入正整数" style="width:100px" value="${item.sort }"/></td>';
	  html+='<td><input type="text" class="text" name="name" data-type="必填" error-msg="请输入分类名称" style="width:100px" value=""/></td>';
	  html+='<td><input type="text" class="text" name="num" data-type="必填" error-msg="请输入大类名称" style="width:100px" value=""/></td>';	 
	  html+='</tr>';
	
	  $("#table tbody").append(html);
	  javaex.render();
});

//添加事件
$("#insert").click(function(){
	if (javaexVerify()) {	
	idArr=[];
	sortArr=[];
	nameArr=[];	
	numArr=[];
	$(":checkbox[name='id']").each(function(){
		idArr.push($(this).val());
	});
	
	$("input[name='sort']").each(function(){
		sortArr.push($(this).val());
	});
	
	$("input[name='num']").each(function(){
		numArr.push($(this).val());
	});
	
	$("input[name='name']").each(function(){
		nameArr.push($(this).val());
	});
		
	$.ajax({
		type:"post",
		datatype:"json",
		url: "save.json",
	    traditional: true,
		data:{
			"idArr":idArr,
			"sortArr":sortArr,
			"nameArr":nameArr,
			"numArr":numArr
		},
		success:function(rtn){
			
			if(rtn.code=='1'){
				javaex.optTip({
					content : rtn.message,
					type : "success"
				});
				// 建议延迟加载
				setTimeout(function() {
					// 刷新页面
		      	window.location.reload();
					// 跳转页面
					// window.location.href = "${pageContext.request.contextPath}/zone_info/list.action";
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

//删除事件
$("#del").click(function(){
	idArr=[];
	$(":checkbox[name='id']:checked").each(function(){
		var id= $(this).val();
		if(id!=''){
			idArr.push(id);
		}
	});
	
	if(idArr.length==0){
		$(":checkbox[name='id']:checked").each(function(){
			$(this).parent().parent().parent().remove();			
		});
	}else{
		$.ajax({
			type:"post",
			datatype:"json",
			url: "delete.json",
		    traditional: true,
			data:{
				"idArr":idArr
			},
			success:function(rtn){
				
				if(rtn.code=='1'){
					javaex.optTip({
						content : rtn.message,
						type : "success"
					});
					// 建议延迟加载
					setTimeout(function() {
						// 刷新页面
			      	window.location.reload();
						// 跳转页面
						// window.location.href = "${pageContext.request.contextPath}/zone_info/list.action";
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