package com.example.demo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.MemberDto;

@Mapper
public interface LoginMapper {

	public String loginOk(MemberDto mdto);

	public int isCartCheck(String userid, String pcode);

	public void suinc(int su,String userid, String pcode);

	public void addCart(String pcode, int su, String userid);
	

}
