package com.example.demo.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.ProductDto;
import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.MemberDto;

@Mapper
public interface ProductMapper {
    public ArrayList<ProductDto> productList(String pcode, String str, int index);
    //대,중,소분류의 NAME을 가져오는 메소드
    public String getDaeName(String code);
    public String getJungName(String code, String daecode);
    public String getSoName(String code,String daejung);
	public int getChong(String pcode);
	public ProductDto productContent(String pcode);
	public void jjimOk(String pcode, String userid);
	public int jjimCheck(String userid, String pcode);
	public void jjimDel(String pcode, String userid);
	public void addCart(String pcode, int su, String userid);
	public  ArrayList<CartDto> cartView();
	public int isCartCheck(String userid, String pcode);
	public void suinc(String pcode, int su, String userid);
	public void getCartNum(String userid);
	public MemberDto getMember(String userid);
	public BaesongDto getBaesong(String userid);
	public void jusoWriteOk(BaesongDto bdto);
	public ArrayList<BaesongDto> jusoList(String userid);
	public void gibonupdate(BaesongDto bdto);
	public BaesongDto selectoriginal();
	public int getJuk(String userid);
	public void chgPhone(String userid, String mPhone);
	public void jusoDel(String id);
	public BaesongDto jusoUpdate2(String id);
	public void jusoUpdateOk(BaesongDto bdto);
	public void jusoUpdateOk2(BaesongDto bdto);
	public void gibonInit(String userid);
}

