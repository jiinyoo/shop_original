package com.example.demo.service;


import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.MemberDto;
import com.example.demo.mapper.MemberMapper;
import com.example.demo.util.MyUtil;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.example.demo.dto.ProductDto;
@Service
@Qualifier("ms2")
public class MemberServiceImpl  implements MemberService{
	
	@Autowired
	private MemberMapper mapper;

	@Override
	public String Memeber() {
		// TODO Auto-generated method stub
		return "/member/member";
	}

	@Override
	public String useridCheck(String userid) {
		return mapper.useridCheck(userid);
	}

	@Override
	public String memberOk(MemberDto mdto) 
	{
		mapper.memberOk(mdto);
		return "../login/login";
	}

	@Override
	public String cartView(HttpSession session, HttpServletRequest request, Model model) {
		// 로그인의 유무에 따라 테이블, 쿠키변수
	ArrayList<HashMap> pMapAll=null;		
	if(session.getAttribute("userid")==null)
		{
		   //쿠키변수에서 읽을 후 상품코드를 분리하여 가져온다.
		   //상품코드1-수량/상품코드2-수량/상품코드3-수량;
		   Cookie cookie=WebUtils.getCookie(request, "pcode");
		   if(cookie!=null && !cookie.getValue().equals(""))
			 {
				 String[] pcodes=cookie.getValue().split("/");
				 //pcodes들을 뽑아서 나눈다.
				 pMapAll=new ArrayList<HashMap>();
				 //for(int i=0;i<pcodes.length;i++)// 모든 요소를 다 실행해야 된다.
				 for(int i=pcodes.length-1;i>=0;i--)
				 {
					 String pcode=pcodes[i].substring(0,12);
					 int su=Integer.parseInt(pcodes[i].substring(13));
					 
					 HashMap map=mapper.getProduct(pcode);
					 
					 
					 //구매 상품의 총금액
					 
					 //구매상품의 총 배송비
					 
					 //구매상품의 
					 
					 
					 //ArrayList에 출력하기 전 장바구니의 수량을 전달
					 //로그인한 경우 csu변수에 저장되어있음 =>여기도 벼녁ㅇ
					 map.put("csu", su);
					 map.put("days", "0");
					 pMapAll.add(map);
					 
				 }
			 }
			
		}else {
			String userid=session.getAttribute("userid").toString();
			pMapAll=mapper.getProductAll(userid);
			if(pMapAll.size()!=0) {
				//int a=Integer.parseInt(String.valueOf(pMapAll.get(0).get("csu")));
				//csu필드의 값을 변경 => plist.get(0).put("csu",100);
				//System.out.println(plist.get(0).get("csu"));	
			}
		}
		//else문 밖에다가 붙여야 한다.
	
			//pMapAll에서 필요한 내용 변경하여 저장하기
			//1.배송예정
			//2.상품금액
			//3.적립금
			//4.배송비
			if(pMapAll!=null) {
				
				//1.모든 상품의 구매금액, 모든 상품의 적립금, 모든 상품의 배송비
				int halinpriceTot=0, jukpriceTot=0,baepriceTot=0;
				
				
				
				
				
				for(int i=0;i<pMapAll.size();i++)
				{
					HashMap map=pMapAll.get(i);
					// pMapAll에서 필요한 내용 변경하여 저장하기
					// 1. 배송예정
					LocalDate today=LocalDate.now();
					int baeday=Integer.parseInt(map.get("baeday").toString());
					LocalDate xday=today.plusDays(Integer.parseInt(map.get("baeday").toString()));
					String yoil=MyUtil.getYoil(xday);
					String baeEx=null;
					if(baeday==1)
					{
						baeEx="내일("+yoil+") 도착예정";
					}
					else if(baeday==2)
					     {
						     baeEx="모레("+yoil+") 도착예정";
					     }
					     else
					     {
					    	 int m=xday.getMonthValue();
					    	 int d=xday.getDayOfMonth();
					    	 baeEx=m+"/"+d+"("+yoil+") 도착예정";
					     }
					pMapAll.get(i).put("baeEx", baeEx);
					
					// 2. 상품금액
					int price=Integer.parseInt(map.get("price").toString());
					int halin=Integer.parseInt(map.get("halin").toString());
					int su=Integer.parseInt(map.get("csu").toString());
					int halinprice=(int)(price-(price*halin/100.0))*su; //하나의 삼품 구매
					pMapAll.get(i).put("halinprice", halinprice);
					
					
					//2-1모든 상품의 구매금액을 넣어주기
					
					// 3. 적립금
					int juk=Integer.parseInt(map.get("juk").toString());
					int jukprice=(int)(price*juk/100.0)*su; //하나의 상품 구매 적립금
					pMapAll.get(i).put("jukprice", jukprice);
					
					
					// 4. 배송비
				
					
					int days=Integer.parseInt(map.get("days").toString());
					if(days<=1)
					{
						
						halinpriceTot=halinpriceTot+halinprice;
						jukpriceTot=jukpriceTot+jukprice;
						int baeprice=Integer.parseInt(map.get("baeprice").toString());
						baepriceTot=baepriceTot+baeprice;
					}
					
				}//for 의 끝
				
				//	뷰에 모든 상품의 구매금액 , 적립금, 배송비를 전달하낟.
				model.addAttribute("halinpriceTot", halinpriceTot);
				model.addAttribute("jukpriceTot", jukpriceTot);
				model.addAttribute("baepriceTot", baepriceTot);
			}//장바구니에 상품이 있다면 if 끝
			
			
			
			
			model.addAttribute("pMapAll",pMapAll);
			return "/member/cartView";
	
	}

	@Override
	public String cartDel(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) {
		
		String[] pcodes=request.getParameter("pcode").split("/");
		
	
			if(session.getAttribute("userid")==null)
			{
				
				
				// 쿠키변수에 삭제할 pcode를 삭제
				Cookie cookie=WebUtils.getCookie(request, "pcode");
				if(cookie!=null )
				{
					String newPcode=cookie.getValue();
					System.out.println(newPcode);
					for(int i=0;i<pcodes.length;i++)
					{					
						newPcode=newPcode.replace(pcodes[i]+"/", ""); //모두 삭제하면 ""
					}
				    System.out.println(newPcode);
					
					Cookie newCookie=new Cookie("pcode",newPcode);
					newCookie.setMaxAge(3600);
					newCookie.setPath("/");
					response.addCookie(newCookie);
					
					
				}
				
				//쿠키변수에서 삭제할 pcode를 삭제
				
				
//				  Cookie cookie=WebUtils.getCookie(request, "pcode");
//				  if(cookie!=null&& !cookie.getValue().equals(""))
//					 {
//					  
//					  	String[] ckPcodes=cookie.getValue().split("/");
//					  	for(int j=0; j<ckPcodes.length; j++) //
//					  	{
//					  		for(int k=0; k<pcodes.length; k++) {
//					  			if(ckPcodes[j].indexOf(pcodes[k])!=-1)
//					  			{
//					  				ckPcodes[j]="";
//					  				break;
//					  			}
//					  			
//					  			
//					  		} 
//					  		
//					  	}
//					  	
//					  	
//					  	//ckPcodes에는 삭제하는 상품 코드는 ""이다.
//					  	//ckPcodes를 문자열로 합쳐서 쿠키에 다시 저장
//					  	String newPcode="";
//					  	for(int i=0; i<ckPcodes.length; i++) {
//					  		if(ckPcodes[i]!="") {
//					  			newPcode=newPcode+ckPcodes[i]+"/";
//					  		}
//					  		
//					  	}
//					  	Cookie newCookie=new Cookie("pcode",newPcode);
//					  	newCookie.setMaxAge(600);
//					  	newCookie.setPath("/");
//					  	response.addCookie(newCookie);
//						   
//					  }
//						
						 
				
			}else {
				//cart테이블에서 pcode에 해당하는 레코드를 삭제
				String userid=session.getAttribute("userid").toString();
				for(int i=0; i<pcodes.length; i++) {
					mapper.cartDel(pcodes[i],userid);
					
				}
			}
			
	
		return "redirect:/member/cartView";
	}

	@Override
	public int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		String pcode=request.getParameter("pcode");
		int su=Integer.parseInt(request.getParameter("su"));
		System.out.println("chgSu");
		if(session.getAttribute("userid")==null)
		{
			
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			//수량이 무조건 한 자리 라면 replace도 가능하지만 
			String[] pcodes=cookie.getValue().split("/");
			for(int i=0; i<pcodes.length; i++)
			{
				if(pcodes[i].indexOf(pcode) != -1)
				{
					pcodes[i]=pcode+"-"+su;
				}
			}
			
			//배열의 값을 다시 문자로 변경
			String newPcode="";
			for(int i=0; i<pcodes.length; i++)
			{
				newPcode=newPcode+pcodes[i]+"/";
			}
			
			Cookie newCookie=new Cookie("pcode", newPcode);
			newCookie.setMaxAge(3600);
			newCookie.setPath("/");
			response.addCookie(newCookie);
			
		
		}else //로그인한 회원
		{
			String userid=session.getAttribute("userid").toString();
			mapper.chgSu(su,pcode,userid);
			System.out.println(pcode+" "+su+" "+userid);
		}
		
		HashMap map=mapper.getProduct(pcode);
		
		int price=Integer.parseInt(map.get("price").toString());
		int halin=Integer.parseInt(map.get("halin").toString());
		int juk=Integer.parseInt(map.get("juk").toString());
		
		
		int[] tot=new int[3];
		tot[0]=(int)(price-(price*halin/100.0))*su;
		tot[1]=(int)(price*(juk/100.0))*su;
		tot[2]=Integer.parseInt(map.get("baeprice").toString());
		return tot;
		
	}

	@Override
	public String jjimList(HttpSession session, Model model) {
		// TODO Auto-generated method stub
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}else
		{
			String userid=session.getAttribute("userid").toString();
			ArrayList<ProductDto> plist=mapper.jjimList(userid);
			
			//할인금액
			for(int i=0;i<plist.size(); i++)
			{
				int price=plist.get(i).getPrice();
				int halin=plist.get(i).getHalin();
				int halinprice=(int)(price-(price*halin/100.0));
				plist.get(i).setHalinPrice(halinprice);
			}
			
			model.addAttribute("plist",plist);
			return "/member/jjimList";
		}
		
		
		
		
	}

	@Override
	public void addCart(HttpServletRequest request, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		String pcode=request.getParameter("pcode");
		if(mapper.isCart(userid)==false) {
			mapper.addCart(userid,pcode);
		}
	}

	@Override
	public String jjimDel(HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		String userid=session.getAttribute("userid").toString();
		//선택삭제는 1개 이상, 상품에서 삭제는 1개만
		String[] pcodes=request.getParameter("pcode").split("/");
		for(int i=0; i<pcodes.length; i++)
		{
			mapper.jjimDel(userid, pcodes[i]);
		}
		
		return "redirect:/member/jjimList";
		
	}

	
}
