<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>凤凰鸣矣，于彼高岗</title>
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
<!--顶部导航-->
	<div class="admin-navbar">
		<div class="admin-container-fluid clear">
			<!--logo名称-->
			<div class="admin-logo">一篇诗，一斗酒，一曲长歌，一剑天涯</div>
			
			<!--导航
			<ul class="admin-navbar-nav fl">
				<li class="active"><a href="/admin/index">总览</a></li>
				<li><a href="/admin/nav1">导航1</a></li>
				<li><a href="/admin/nav2">导航2</a></li>
			</ul>
			-->
			<!--右侧-->
			<ul class="admin-navbar-nav fr">
				<li>
					<a href="javascript:;">欢迎您，管理员</a>
					<ul class="dropdown-menu" style="right: 10px;">
						<li><a href="${pageContext.request.contextPath}/admin/login_out.action">退出当前账号</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!--主题内容-->
	<div class="admin-mian">
		<!--左侧菜单-->
		<div class="admin-aside admin-aside-fixed">
			<h1><span class="admin-nav-name">菜单</span></h1>
			<div id="admin-toc" class="admin-toc">
				<div class="menu-box">
					<div id="menu" class="menu">
						<ul>		
							<li class="menu-item">
								<a href="javascript:;">分类管理<i class="icon-keyboard_arrow_left"></i></a>
								<ul>
									<li><a href="javascript:page('${pageContext.request.contextPath}/type_info/list.action');">文章分类</a></li>
									
								</ul>
							</li>
							<li class="menu-item">
								<a href="javascript:;">文章管理<i class="icon-keyboard_arrow_left"></i></a>
								<ul>
									<li><a href="javascript:page('${pageContext.request.contextPath}/article_info/list_namal.action');">文章列表</a></li>
									<li><a href="javascript:page('${pageContext.request.contextPath}/article_info/recycle.action');">回收站</a></li>
								</ul>
							</li>
							<li class="menu-item">
								<a href="javascript:;">个人中心<i class="icon-keyboard_arrow_left"></i></a>
								<ul>
									<li><a href="javascript:page('/admin/user/avatar');">修改头像</a></li>
									<li><a href="javascript:page('/admin/user/password');">修改密码</a></li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--iframe载入内容-->
		<div class="admin-markdown">
			<iframe id="page" src=""></iframe>
		</div>
	</div>
</body>
<script>
	var hightUrl = "xxxx";
	javaex.menu({
		id : "menu",
		isAutoSelected : true,
		key : "",
		url : hightUrl
	});
	
	$(function() {
		// 设置左侧菜单高度
		setMenuHeight();
	});
	
	/**
	 * 设置左侧菜单高度
	 */
	function setMenuHeight() {
		var height = document.documentElement.clientHeight - $("#admin-toc").offset().top;
		height = height - 10;
		$("#admin-toc").css("height", height+"px");
	}
	
	// 控制页面载入
	function page(url) {
		$("#page").attr("src", url);
	}
</script>
</html>