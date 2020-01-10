<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>有朋友自远方来，不亦乐乎</title>
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
	<span>文章管理</span>
	<span class="divider">/</span>
	<span class="active">文章列表</span>
</div>
	<div class="list-content">
	<!--块元素-->
	<div class="block">
		<!--页面有多个表格时，可以用于标识表格-->
		<h2>文章列表</h2>
		<!--正文内容-->
		<div class="main-20">
		<div style="text-align: right;wargin-botton:10px">
		  <!-- 文章类型 -->
		   <select id="type_id" class="select" style="width: 140px;">
		          <option value="">请选择</option>
					<c:forEach items="${typelist }" var="type_item" varStatus="status">
							<option value="${type_item.id }" 
							<c:if test="${typeId==type_item.id }">  selected="selected" </c:if>>${type_item.name}</option>
					</c:forEach>
		</select>
						<!-- 日期查询 -->
						<input type="text" id="date2" class="ex-date" style="width: 600px;" value="" readonly/>
						<!-- 标题搜索 -->
						<input id="keyword" type="text" class="text" placeholder="搜索文章标题" value="${keyword }" />
					    <!-- 点击事件 -->
					    <button class="button blue" style="margin-top: -3px" onclick="search()"><span class="icon-search"></span></button>				
					</div>
			<table id="table" class="table color2">
				<thead>
					<tr>
						<th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
						<th>序号</th>
						<th>文章类型</th>
						<th>文章标题</th>
						<th>发表日期</th>
						<th>阅读量</th>
						<th>置顶0默认/1右侧/2右上/3轮播</th>
						
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${fn:length(pageInfo.list)==0}">
						<tr>
						  <td colspan="7" style="text-align: center">暂无记录</td>
						</tr>			
				    </c:when>
				    <c:otherwise>
				    
				<c:forEach items="${pageInfo.list}" var="item" varStatus="status">
					<tr>
						<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="${item.id }"/> </td>
				     	<td>${status.index+1}</td>
						<td>${item.name }</td>
						<td>${item.title }</td>
						<td>${item.updateTime }</td>
						<td>${item.viewCount }</td>
						<td>${item.placement }</td>
						
					</tr>
				</c:forEach>			    		
	     	</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			
			<!-- 分页 -->
			<div class="page">
	          <ul id="page" class="pagination"></ul>
            </div>
            
          
				<!--块元素-->
			 <div class="block">
					<!--banner用来修饰块元素的名称-->
					<div class="banner">
						<p class="tab fixed">批量操作</p>
					</div>
					<!--正文内容-->
					<div class="main" style="margin-bottom: 150px">
						<input type="radio" class="fill" name="radio" value="dele" />彻底删除
						
						<br/>
						<br/>
						<input type="radio" class="fill" name="radio" value="upstatus"/>批量还原
						<br/>
						<br/>
						<button id="submit" class="button green"><span class="icon-check">提交</span></button>
					</div>
				</div>
		
            
            
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	    var pageCount= "${pageInfo.pages}";
		var currentPage= "${pageInfo.pageNum}";
	    var totalNum= "${pageInfo.total}";
	    
	    //时间查询
	    var startDate="";
	    var endDate="";
     javaex.date({
		id : "date2",		// 承载日期组件的id
		monthNum : 2,		// 2代表选择范围日期
		startDate : "${startDate}",	// 开始日期
		endDate : "${endDate}",		// 结束日期
		// 重新选择日期之后返回一个时间对象
		callback : function(rtn) {
			startDate=rtn.startDate;
			endDate=rtn.endDate;
		}
	});
		//类型查询
		    javaex.select({
				id : "type_id",
				isSearch : false,   //搜索框输入 
				// 回调函数
				callback: function (rtn) {
					console.log("selectValue:" + rtn.selectValue);
					console.log("selectName:" + rtn.selectName);
				}
			});
	    
		//移动类型
		javaex.select({
		id : "type_id2",
		isSearch : false,
		// 回调函数
		callback: function (rtn) {
			console.log("selectValue:" + rtn.selectValue);
			console.log("selectName:" + rtn.selectName);
		}
	});
	    
	    javaex.page({
			id : "page",
			pageCount : pageCount,	// 总页数
			currentPage : currentPage,// 默认选中第几页
			totalNum : totalNum,		// 总条数，不填时，不显示
			position : "right",
			callback : function(rtn) {
				search(rtn.pageNum);
			}
		});
	
		function search(pageNum){
			if(pageNum == undefined){
				pageNum=1;
			}
			//文章分类
	     var typeId=$("#type_id").val();
	        //文章标题
		 var keyword=$("#keyword").val();
			window.location.href = "recycle.action"
			+"?pageNum="+pageNum
		 	+"&typeId="+typeId
		 	+"&startDate="+startDate
		 	+"&endDate="+endDate
		 	+"&keyword="+keyword
		 	;
		}
	
		//批量提交
		$("#submit").click(function(){
			//先判断文章是否有勾选
			var idArr=new Array();
			$(":checkbox[name='id']:checked").each(function(){
				idArr.push($(this).val());
			});
			
			//判断选择的行数
			if(idArr.length==0){
				javaex.optTip({
					content : "最少选择一条记录",
					type : "error"
				});
				return;
			}
			
			//判断选择的那个单选框
			var opt=$(':radio[name="radio"]:checked').val();
			if(opt=="dele"){
				//获取目标分类的id 彻底删除
				var typeId=$("#type_id2").val();
				$.ajax({
					url:"dele.json",
					type:"post",
					datatype:"json",
					traditional: true,
					data:{
						"idArr":idArr				
					},
					success:function(rtn){
						if(rtn.code=='1'){
							javaex.optTip({
								content : rtn.message,
							});
							// 建议延迟加载
							setTimeout(function() {
								// 刷新页面
						      	window.location.reload();
							}, 2000);
						}else{
							javaex.optTip({
								content : rtn.message,
								type : "error"
							});
						}
					}
					
				});
			}else if(opt=="upstatus"){
				$.ajax({
					url:"updateStatus.json",
					type:"post",
					datatype:"json",
					traditional: true,
					data:{
						"idArr":idArr,
						"status":"1"
					},
					success:function(rtn){
						if(rtn.code=='1'){
							javaex.optTip({
								content : rtn.message,
							});
							// 建议延迟加载
							setTimeout(function() {
								// 刷新页面
						      	window.location.reload();
							}, 2000);
						}else{
							javaex.optTip({
								content : rtn.message,
								type : "error"
							});
						}
					}
					
				});
				
			}
		});
</script>
</html>