package com.human.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		// TODO Auto-generated method stub
//		System.out.println("pre handle");
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("nowUser");
		
		if(obj == null) { // 로그인이 아닌경우
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
//		System.out.println("Post handle");
		super.postHandle(request, response, handler, modelAndView);
	}
	
	

}
