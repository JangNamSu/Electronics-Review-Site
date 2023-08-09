package com.human.electronics;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.human.service.EletronicsServiceImpl;

@Controller
public class LoginController {
	
	@Inject
	EletronicsServiceImpl elesrv;
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String input_s(Locale locale, Model model, HttpSession session,
			@RequestParam("user_id")String user_id,
			@RequestParam("user_pass")String user_pass) throws Exception {
//		select * from member where m_id = 'test33' and m_pass ='12345!';
		// 인증절차
		// 1. db조회 select * from member where id=? and pwd=?  <생략>
		
		
		if(elesrv.login(user_id, user_pass) == null) {
			model.addAttribute("msg","로그인 실패 아이디 비밀번호를 확인 해주세요");
			
		}else {
			System.out.println(elesrv.login(user_id, user_pass));
			session.setAttribute("nowUser", user_id);
		}
		
//		if(db조회리턴값 == null) {
//			// 아이디가 없거나 비번이 틀린경우
//		}else {
//			session.setAttribute("nowUser", user_id);
//			session.setAttribute("grade", "vvip");
//		}
		
		// 2. 회원이라고 가정하고 세션만 먼저 공부해 보자

		// 내가 원하는 정보를 설정합니다...
		// 눈에 보이지는 않지만 쿠키와 세션id는 이미 만들어진 상태입니다..
		
		return "home";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String input_s(Locale locale, Model model, HttpSession session) {
		
		session.invalidate(); // 세션을 무력화..
		
		return "home";
	}
	
}
