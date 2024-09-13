package com.example.demo.service;

import java.time.LocalDate;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.SoDto;
import com.example.demo.mapper.MainMapper;
import com.example.demo.util.MyUtil;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService{

	
	@Autowired
	private MainMapper mapper;
	
	
	public ArrayList<ProductDto> calPro(ArrayList<ProductDto> plist) {
		
		
		for(int i=0; i<plist.size(); i++)
		{
			
			ProductDto pdto=plist.get(i);
			//할인 후 상품 금액 => 상품금액-(상품금액*(할인율/100))
			int halinPrice=(int)(pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100.0)));
			//적립금액 => 상품금액*(적립률/100)
			int jukPrice=(int)(pdto.getPrice()*(pdto.getJuk()/100.0));
			
			//배송예정일 => 내일(요일) 배송예정, 모레(요일) 배송예정, 월/일(요일) 배송예정
			//오늘기준으로 배송예정일의 날짜객체를 생성
			LocalDate today=LocalDate.now();
			LocalDate xday=today.plusDays(pdto.getBaeday());
			String yoil=MyUtil.getYoil(xday);
			
			String beaEx=null;
			if(pdto.getBaeday()==1)
			{
				beaEx="내일("+yoil+") 도착예정";
			}else if(pdto.getBaeday()==2)
				{
					beaEx="모레("+yoil+") 도착예정";
					
				}
				else 
				{
					int m=xday.getMonthValue();
					int d=xday.getDayOfMonth();
					beaEx=m+"/"+d+"("+yoil+") 도착예정";
					
				}
				
				plist.get(i).setHalinPrice(halinPrice);
				plist.get(i).setJukPrice(jukPrice);
				plist.get(i).setBaeEx(beaEx);
		
				   double star=pdto.getStar();
				    //star에서 소수점만 추출해낸다.
				    
				    int ystar=0,hstar=0,gstar=0;
				    
				    ystar=(int)star;
				    
				    //소수부분을 가지고
				    star=star-ystar;
				    if(star >=0.8) {
				    	ystar=ystar+1;
				    }else if (0.3<=star && star<0.8) {
				    	hstar=1;
				    }
				    
				    gstar=5-(ystar+hstar);
				   
				    
				    plist.get(i).setYstar(ystar);
				    plist.get(i).setGstar(gstar);
				    plist.get(i).setHstar(hstar);
		}
		
		
		return plist;
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	@Override
	public String index(Model model) {
		
		//특가상품, 최신상품,타임세일, 최다 판매 => 4개씩 가져오기
		
		
		ArrayList<ProductDto> plist1=mapper.getProduct1();
		ArrayList<ProductDto> plist2=mapper.getProduct2();
		ArrayList<ProductDto> plist3=mapper.getProduct3();
		ArrayList<ProductDto> plist4=mapper.getProduct4();
		
		
		
		System.out.println(plist1.get(1).getHalinPrice());
		plist1=this.calPro(plist1);
		System.out.println(plist1.get(1).getHalinPrice());
		plist2=this.calPro(plist2);
		plist3=this.calPro(plist3);
		plist4=this.calPro(plist4);
		
		
		model.addAttribute("plist1",plist1);
		model.addAttribute("plist2",plist2);
		model.addAttribute("plist3",plist3);
		model.addAttribute("plist4",plist4);
		
		
		return "/main/index";
	}

	@Override
	public ArrayList<DaeDto> getDae() {
		
		return mapper.getDae();
		
	}

	@Override
	public ArrayList<JungDto> getJung(HttpServletRequest request) {
		// TODO Auto-generated method stub
		int imsi=Integer.parseInt(request.getParameter("daecode"));
		String daecode=String.format("%02d", imsi);
		
		return mapper.getJung(daecode);
	}

	@Override
	public ArrayList<SoDto> getSo(HttpServletRequest request) {
		int imsi=Integer.parseInt(request.getParameter("daejung"));
		String daejung=String.format("%04d", imsi);
		return mapper.getSo(daejung);
	}

	@Override
	public String cartNum(HttpServletRequest request, HttpSession session) {
		
		String cnum=null;
		if(session.getAttribute("userid")==null)
		{
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			if(cookie!=null && !cookie.getValue().equals("")) {
				String[] pcodes=cookie.getValue().split("/");
				cnum=pcodes.length+"";
			}else {
				
				//0으로 처리
				cnum="0";
			}
			
		}else{
			
			String userid=session.getAttribute("userid").toString();
			cnum=mapper.getCartNum(userid);
			
		}
		return cnum;
	}



}
