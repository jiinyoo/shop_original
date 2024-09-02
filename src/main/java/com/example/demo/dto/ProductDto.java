package com.example.demo.dto;

import lombok.Data;

@Data
public class ProductDto {
	
	private int id;
	public int price;
	private int halin;
	private int su;
	private int baeprice;
	private int baeday;
	private int juk;
	private int pansu;
	private double star;
	private String pcode, pimg, dimg, title, writeday,review;
	
	
	private int halinPrice, jukPrice;
	private String baeEx;
	
	
	

}
