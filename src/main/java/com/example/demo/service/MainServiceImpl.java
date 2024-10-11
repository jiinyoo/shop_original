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

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
	public String index(Model model,ServletContext application,HttpServletRequest request
			,HttpServletResponse response) {
		
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
		Cookie cookie=WebUtils.getCookie(request, "users");
		if(application.getAttribute("names")==null) {
			//로그인한 사용자의 아이디를 저장한다.
			application.setAttribute("names", "");
		}
		 if(cookie==null) {
		
			
			
			if(application.getAttribute("users")==null)
			{
					//쿠키변수를 활용하면 한 번만 로그인 한걸로 할 수 있다.
					application.setAttribute("users", "1");
			}
			else {
				System.out.println("전 : "+application.getAttribute("users").toString());
					int n=Integer.parseInt(application.getAttribute("users").toString());
					application.setAttribute("users", n+1);
					System.out.println(" 후 : "+application.getAttribute("users").toString());
			}
			 Cookie cookie2=new Cookie("users","1");
			 //쿠키는 아무 수로 해도 된다. 증가하는 거는 
			cookie2.setMaxAge(3600);
			cookie2.setPath("/");
			//cookie는 다른 model로 넘겨줘야 한다.
			//application은 서버의 메모리다.
			response.addCookie(cookie2);
	 }
		
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
		Cookie cookie=WebUtils.getCookie(request, "top");
		if(cookie==null) // 쿠키변수가 없다는것은 1층을 숨기지 않았거나
		{                // 1층을 숨긴지 60초가 지난경우이다
			cnum=cnum+"/0";  
		}
		else
		{
			cnum=cnum+"/1";
		} 
		// 60초가 지나면 top변수가 null이된다
		// 그래서 기존의 장바구니 갯수뒤에 구분자"/" 뒤에 0 or 1을 전달한다.
		return cnum;
	}










	@Override
	public String topClose(HttpServletRequest request,HttpServletResponse response) 
	{
		// 1층을 숨겼으면 top이라는 쿠키변수가 생성된다 (일단 60초만 존재)
		// 60초 전에는 1층을 숨긴다.
		// 60초 뒤에는 1층을 보여준다
		// 위의 작업은 문서를 읽을때 진행한다 => default.jsp로 
		try 
		{
			Cookie cookie=new Cookie("top","0"); // 쿠키생성
			cookie.setMaxAge(60);  // 쿠키 존재시간 => 실제 사이트에서는 적절한 시간을 부여하면 됩니다.
			cookie.setPath("/");   // 쿠키저장경로
			response.addCookie(cookie); // 쿠키를 클라이언트에 저장
			return "0"; // 오류가 없다면
		}
		catch(Exception e)
		{
			return "1"; // 오류가 있다면
		}
		
	}



}
