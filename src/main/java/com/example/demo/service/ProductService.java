package com.example.demo.service;

import org.springframework.ui.Model;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.GumaeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface ProductService {

	String productList(HttpServletRequest request, Model model);

	String productContent(HttpServletRequest request, Model model, HttpSession session);

	String jjimOk(HttpServletRequest request, HttpSession session, Model model);

	String addCart(HttpServletRequest request, HttpSession session, Model model, HttpServletResponse response);

	String gumae(HttpSession session, HttpServletRequest request,Model model);

	String jusoWriteOk(BaesongDto bdto, Model model,HttpSession session);

	String jusoList(Model model, HttpSession session);

	String jusoWrite(HttpServletRequest request, Model model);

	String chgPhone(HttpServletRequest request,HttpSession session);

	String jusoDel(HttpServletRequest request, HttpSession session);

	String jusoUpdate2(HttpServletRequest request, HttpSession session,Model model);

	String jusoUpdateOk2(BaesongDto bdto,HttpSession session);

	String gumaeOk(GumaeDto gdto, HttpSession session);

	String gumaeView(HttpServletRequest request, Model model);

	String reviewDel(HttpServletRequest request, Model model);

	String questWriteOk(HttpServletRequest request, HttpSession session, Model model);


}
