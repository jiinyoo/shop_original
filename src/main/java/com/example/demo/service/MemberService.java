package com.example.demo.service;

import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface MemberService {
	public String Memeber();

	public String useridCheck(String userid);

	public String memberOk(MemberDto mdto);

	public String cartView(HttpSession session, HttpServletRequest request, Model model);

	public String cartDel(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response);

	public int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response);

	public String jjimList(HttpSession session, Model model);

	public void addCart(HttpServletRequest request, HttpSession session);

	public String jjimDel(HttpServletRequest request, HttpSession session);

	public String jumunList(HttpSession session, Model model, HttpServletRequest request);

	public String chgState(HttpServletRequest request);

	public String reviewWrite(HttpServletRequest request,Model model);

	public String reviewWriteOk(ReviewDto rdto, HttpSession session);

	

}
