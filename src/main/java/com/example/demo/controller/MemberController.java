package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
public class MemberController {
	
	@Autowired
	@Qualifier("ms2")
	private MemberService service;
	
	@RequestMapping("/member/member")
	public String member()
	{
		return service.Memeber();
	}
	
	
	@RequestMapping("/member/useridCheck")
	//리턴을 스트링으로 해야함
	public @ResponseBody String useridCheck(HttpServletRequest request)
	{
		String userid=request.getParameter("userid");
		return service.useridCheck(userid);
		
	}
	
	
	@RequestMapping("/member/memberOk")
	//리턴을 스트링으로 해야함
	public String memberOk(MemberDto mdto)
	{
		
		return service.memberOk(mdto);
		
	}
	
	
	@RequestMapping("/member/cartView")
	public String cartView(HttpSession session, HttpServletRequest request,Model model) {
		return service.cartView(session,request,model);
		
	}
	
	@RequestMapping("/member/cartDel")
	public String cart(HttpSession session, HttpServletRequest request,Model model, HttpServletResponse response) {
		return service.cartDel(session,request,model,response);
		
	}
	
	
	@RequestMapping("/member/chgSu")
	public @ResponseBody int[] chgSu(HttpServletRequest request,HttpSession session, HttpServletResponse response)
	{
		return service.chgSu(request,session,response);
	}
	
	
	@RequestMapping("/member/jjimList")
	public String jjimList(HttpSession session, Model model) {
		return service.jjimList(session,model);
		
		
	}
	
	
	@RequestMapping("/member/addCart")
	public @ResponseBody void addCart(HttpServletRequest request,HttpSession session) {
		
		service.addCart(request,session);
		
	}
	
	@RequestMapping("/member/jjimDel")
	public String jjimDel(HttpServletRequest request,HttpSession session) {
		return service.jjimDel(request,session);
	}
	
	@RequestMapping("/member/jumunList")
	public String jumunList(HttpSession session,Model model,HttpServletRequest request) {
		return service.jumunList(session,model, request);
	}
	
	@GetMapping("/member/chgState")
	    public String chgState(HttpServletRequest request)
	    {
	    	return service.chgState(request);
	    }
	
	@GetMapping("/member/reviewWrite")
    public String reviewWrite(HttpServletRequest request,Model model)
    {
    	return service.reviewWrite(request,model);
    }
	
	@RequestMapping("/member/reviewWriteOk")
    public String reviewWrite(ReviewDto rdto,HttpSession session)
    {
    	return service.reviewWriteOk(rdto,session);
    }
	

}
