package com.example.demo.service;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface ProductService {

	String productList(HttpServletRequest request, Model model);

	String productContent(HttpServletRequest request, Model model, HttpSession session);

	String jjimOk(HttpServletRequest request, HttpSession session, Model model);

	String addCart(HttpServletRequest request, HttpSession session, Model model, HttpServletResponse response);


}
