package com.uplooking.controller.portal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.uplooking.dao.portal.PortalUserInfoMapper;
import com.uplooking.pojo.PortalUserInfo;
import com.uplooking.service.portal.PortalUserInfoService;
import com.uplooking.view.Result;

@Controller
@RequestMapping("register")
public class LoginController {

	@Autowired
	private PortalUserInfoService portalUserInfoService;

	/*
	 * 注册跳转
	 */
	@RequestMapping("reg.action")
	public String register() {

		return "portal/login/user";

	}

	/*
	 * 登陆跳转
	 */
	@RequestMapping("login.action")
	public String login() {

		return "portal/login/login";

	}

	/*
	 * 通过注册前端表单提交 后端通过http获取
	 */
	@RequestMapping("registerlogin.json")
	@ResponseBody
	public Result register(HttpServletRequest request, PortalUserInfo portalUserInfo) {
		String portalName = request.getParameter("portalName");
		String portalPwd = request.getParameter("portalPwd");
		String portalSex = request.getParameter("portalSex");
		String shengfen = request.getParameter("shengfen");
		String chengshi = request.getParameter("chengshi");
		String portalIntroduce = request.getParameter("portalIntroduce");
		portalUserInfo.setPortalName(portalName);
		portalUserInfo.setPortalPwd(portalPwd);
		portalUserInfo.setPortalSex(portalSex);
		portalUserInfo.setPortalIntroduce(portalIntroduce);
		portalUserInfo.setPortalAddr(shengfen + chengshi);
		if (portalUserInfoService.save(portalUserInfo).getCode()==0) {
			return Result.error("用户已存在");
		}
		
		return Result.success();

	}

	/*
	 * 用户登陆
	 */
	@RequestMapping("login.json")
	@ResponseBody
	public Result loginaction(HttpServletRequest request) {
		String portalName = request.getParameter("loginName");
		String portalPwd = request.getParameter("password");
		portalUserInfoService.findByNameAndByPwd(portalName, portalPwd);

		return Result.success();

	}
}
