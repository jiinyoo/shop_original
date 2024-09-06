package com.example.demo.dto;

import lombok.Data;

@Data
public class GumaeDto {
	private int id,su,useJuk,chongPrice,sudan,baeId;
	private int card, halbu,bank,lcard,tong,nbank;
	private int state, isReview;
	private String userid,pcode,jumuncode,writeday;
	
	//여러상품의 수량을 배열로
	private int[] sues;
	private String[] pcodes;
	
	

}
