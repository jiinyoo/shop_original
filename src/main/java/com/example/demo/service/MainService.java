package com.example.demo.service;

import java.util.ArrayList;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface MainService {
	public String index();

	public ArrayList<DaeDto> getDae();

	public ArrayList<JungDto> getJung(HttpServletRequest request);

	public ArrayList<SoDto> getSo(HttpServletRequest request);

	public String cartNum(HttpServletRequest request, HttpSession session);

}
