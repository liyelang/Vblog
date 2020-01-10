package com.uplooking.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.uplooking.pojo.UserInfo;

public class DabolgInterceptor implements HandlerInterceptor {
	// 在DispatcherServlet完全处理完请求后被调用
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	// 在业务处理器处理请求执行完成后
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object object, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub

	}

	// 在业务处理器处理请求之前被调用
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
		// 1.获取请求的地址
		String url = request.getRequestURI();

		// 2.对特殊的地址放行
		if (url.indexOf("login") >= 0 || url.indexOf("portal") > 0 || url.indexOf("register") > 0) {
			return true;
		}
		// 3.判断session
		HttpSession session = request.getSession();
		UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
		if (userInfo != null) {
			return true;
		}
		request.getRequestDispatcher("/WEB-INF/page/admin/login.jsp").forward(request, response);
		return false;
	}

}
