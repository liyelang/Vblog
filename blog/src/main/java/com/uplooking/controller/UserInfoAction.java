package com.uplooking.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

import com.uplooking.exception.DablogException;
import com.uplooking.pojo.UserInfo;
import com.uplooking.service.UserInfoService;
import com.uplooking.view.Result;

@Controller
@RequestMapping("admin")
public class UserInfoAction {

	@Autowired
	private UserInfoService userInfoService;

  @RequestMapping("home.action")
	public String index() {
		return "admin/index";
	}

	@RequestMapping("index.action")
	public String login() {
		return "admin/login";
	}

	/**
	 * 前端发送的是json请求,序列化
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws DablogException 
	 */
	@RequestMapping("login.json")
	@ResponseBody
	public Result login(HttpServletRequest request, ModelMap map) throws DablogException {
	
		// 1.获取参数
		String login_name = request.getParameter("loginName");
		String password = request.getParameter("password");

		// 2.验证参数
		if (StringUtils.isEmpty(login_name) || StringUtils.isEmpty(password)) {
			throw new DablogException("用户名和密码为空");
		}
		UserInfo userInfo = userInfoService.getOne(login_name, password);
		if (userInfo == null) {
			throw new DablogException("用户或密码不正确");
		
		}

		// 3.设置session
		request.getSession().setAttribute("userInfo", userInfo);

		return Result.success();
	}

	@RequestMapping("login_out.action")
	public String login(HttpSession session) {
		// 销毁session
		session.invalidate();
		return "admin/login";

	}
}
