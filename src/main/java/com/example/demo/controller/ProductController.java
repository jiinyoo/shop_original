package com.example.demo.controller;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.GumaeDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {
	
	@Autowired
	@Qualifier("ps")
	
	private ProductService service;
	
	@RequestMapping("/product/productList")
	public String productList(HttpServletRequest request, Model model)
	{
		return service.productList(request,model);
	}
	
	
	@RequestMapping("/product/productContent")
	public String productContent(HttpServletRequest request, Model model,HttpSession session)
	{
		return service.productContent(request, model,session);
	}
	
	
	@RequestMapping("/product/jjimOk")
	public @ResponseBody String jjimOk(HttpServletRequest request, HttpSession session,Model model)
	{
		return service.jjimOk(request,session,model);
	}
	
	

	@RequestMapping("/product/addCart")
	public @ResponseBody String addCart(HttpServletRequest request, HttpSession session,Model model, HttpServletResponse response)
	{
		return service.addCart(request,session,model,response);
	}
	
	@RequestMapping("/product/gumae")
	public String gumae(HttpSession session, HttpServletRequest request,Model model)
	{
		return service.gumae(session,request,model);
		
	}
	
	@RequestMapping("/product/jusoWrite")
	public String jusowrite(HttpServletRequest request,Model model)
	{
		return service.jusoWrite(request, model);
	}
	
	@RequestMapping("/product/jusoWriteOk")
	public String jusowriteOk(BaesongDto bdto, Model model,HttpSession session)
	{
		return service.jusoWriteOk(bdto,model,session);
	}
	
	@RequestMapping("/product/jusoList")
	public String jusoList(HttpServletRequest request, Model model,HttpSession session)
	{
		//System.out.println(request.getHeader("referer")); 이전페이지의 추소 출력
		return service.jusoList(model,session);
	}

	
	@RequestMapping("/product/chgPhone")
	public @ResponseBody String chgPhone(HttpServletRequest request,HttpSession session)
	{
		return service.chgPhone(request,session);
	}
	
	@RequestMapping("/product/jusoDel")
	public String jusoDel(HttpServletRequest request,HttpSession session)
	{
		//사용자들이 주소를 복사해서 접근하는 경우
		 //요청한 곳의 주소를 가져옴.
		//복사를 해서 접근하게 되면 null값을 가진다.
		
		return service.jusoDel(request,session);
	}
	@RequestMapping("/product/jusoUpdate")
	public String jusoUpdate(HttpServletRequest request,HttpSession session,Model model)
	{
		//사용자들이 주소를 복사해서 접근하는 경우
		 //요청한 곳의 주소를 가져옴.
		//복사를 해서 접근하게 되면 null값을 가진다.
		
		return service.jusoUpdate2(request,session,model);
	}
	
	
	@RequestMapping("/product/jusoUpdateOk")
	public String jusoUpdateOk2(BaesongDto bdto,HttpSession session)
	{
		//보안 관련으로 세션을 보낼 수도 있다.
		return service.jusoUpdateOk2(bdto,session);
		
	}
	
	
	@RequestMapping("/product/gumaeOk")
	public String gumaeOk(GumaeDto gdto,HttpSession session)
	{
		//System.out.println(gdto.getPcodes()[0]+....);
		//System.out.println(gdto.getSues()[0]+gdto.getSues()[1])+gdto.getSues()[2]+gdto.getSues()[3]));
		return service.gumaeOk(gdto,session); 
	}
	
	@RequestMapping("/product/gumaeView")
	public String gumaeView(HttpServletRequest request, Model model)
	{
		//System.out.println(gdto.getPcodes()[0]+....);
		//System.out.println(gdto.getSues()[0]+gdto.getSues()[1])+gdto.getSues()[2]+gdto.getSues()[3]));
		return service.gumaeView(request,model); 
	}
	
	
}
