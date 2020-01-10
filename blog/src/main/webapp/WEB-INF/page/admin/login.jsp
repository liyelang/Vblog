<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>嘘……好奇心会害死猫</title>
<!--字体图标-->
<link
	href="${pageContext.request.contextPath}/static/javaex/pc/css/icomoon.css"
	rel="stylesheet" />
<!--动画-->
<link
	href="${pageContext.request.contextPath}/static/javaex/pc/css/animate.css"
	rel="stylesheet" />
<!--骨架样式-->
<link
	href="${pageContext.request.contextPath}/static/javaex/pc/css/common.css"
	rel="stylesheet" />
<!--皮肤（缇娜）-->
<link
	href="${pageContext.request.contextPath}/static/javaex/pc/css/skin/tina.css"
	rel="stylesheet" />
<!--jquery，不可修改版本-->
<script
	src="${pageContext.request.contextPath}/static/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--全局动态修改-->
<script
	src="${pageContext.request.contextPath}/static/javaex/pc/js/common.js"></script>
<!--核心组件-->
<script
	src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex.min.js"></script>
<!--表单验证-->
<script
	src="${pageContext.request.contextPath}/static/javaex/pc/js/javaex-formVerify.js"></script>
<!-- 引用自定义样式 -->
<link href="${pageContext.request.contextPath}/static/javaex/pc/css/lz/login.css"
	rel="stylesheet" />

</head>
<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
	<div class="bg-wrap">
		<div class="main-cont-wrap login-model">
			<form id=login>
				<div class="form-title">
					<span>后台登录</span>
				</div>
				<div class="form-item">
					<span class="form-txt">账号：</span> <input type="text"
						class="form-input original" id="login_name" name="loginName"
						placeholder="请输入账号" data-type="必填" error-pos="32" value=""/>
				</div>
				<div class="form-item">
					<span class="form-txt">密码：</span> <input type="password"
						class="form-input original" name="password" placeholder="请输入密码"
						data-type="必填" error-pos="32" value="" />
				</div>
				<div class="form-btn">
					<input type="button" class="ui-button" id="save" value="登录" />
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	$("#save").click(function() {				
	//表单验证函数
var path=$("#path").val();	
	if (javaexVerify()) {		
		$.ajax({
		url : path+"/admin/login.json",
		type : "post",
		dataType : "json",
		data : $("#login").serialize(),
		success : function(rtn) {
			if (rtn.code== '1') {
				//跳转后台首页
				window.location.href = "${pageContext.request.contextPath}/admin/home.action";
			} else {
			
				addErrorMsg("login_name", rtn.message);
			}
		},	
		error:function(rtn){
			console.log(rtn);
		}
	});
	}
});
</script>
</html>