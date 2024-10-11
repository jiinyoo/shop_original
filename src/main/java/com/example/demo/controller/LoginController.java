package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.dto.MemberDto;
import com.example.demo.service.LoginService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
public class LoginController {
	
	@Autowired
	@Qualifier("ms3")
	LoginService service;
	
	@Autowired
	private ServletContext application;
	
	@RequestMapping("/login/login")
	public String login(HttpServletRequest request,Model model)
	{
		return service.login(request,model);
	}
	
	@RequestMapping("/login/loginOk")
	public String loginOk(MemberDto mdto,HttpSession session, HttpServletRequest request, HttpServletResponse response)
	{
		if(application.getAttribute("names")==null) {
			//로그인한 사용자의 아이디를 저장한다.
			application.setAttribute("names", "");
		}
		return service.loginOk(mdto,session,request, response,application);
	}
	

	@RequestMapping("/login/logout")
	public String logout(HttpSession session)
	{
		return service.logout(session);
	}
}
