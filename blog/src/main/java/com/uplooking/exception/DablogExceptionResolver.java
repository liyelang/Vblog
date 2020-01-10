package com.uplooking.exception;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

public class DablogExceptionResolver implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {

		// 打印到控制台
		ex.printStackTrace();

		// 友情提示
		String message = "系统繁忙,请稍后重试!";

		// 判断此错误是否预知
		if (ex instanceof DablogException) {
			message = ((DablogException) ex).getMessage();
		}

		// 判断请求类型
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		ResponseBody responseBody = handlerMethod.getMethod().getAnnotation(ResponseBody.class);
		if (responseBody != null) {
			// 如果是json请求  .则返回json格式
			Map<String, Object> responseMap = new HashMap<String, Object>();
			responseMap.put("code", 0);
			responseMap.put("message", message);
			String json = new Gson().toJson(responseMap);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;Charset=utf-8");

			try {
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (Exception el) {
				el.printStackTrace();
			}
			return new ModelAndView();
		}
		
		ModelAndView modelAndView=new ModelAndView();
		
		modelAndView.addObject("message", message);
		modelAndView.setViewName("error");
		return modelAndView;
	}

}
