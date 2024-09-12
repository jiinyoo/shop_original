package com.example.demo.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.CartDto;
import com.example.demo.dto.GumaeDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.mapper.ProductMapper;
import com.example.demo.util.MyUtil;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	ProductMapper mapper;

	@Override
	public String productList(HttpServletRequest request, Model model) {
		
		
	
		String pcode=request.getParameter("pcode");

		
		int page=1;
		if(request.getParameter("page")!=null)
			page=Integer.parseInt(request.getParameter("page"));
		
		int index,pstart,pend,chong;
		
		index=(page-1)*10;
		
		pstart=page/10;
		if(page%10==0)
		{
			pstart=pstart-1;
		}
		
		pstart=pstart*10+1;
		pend=pstart+9;
		
		model.addAttribute("page",page);
		model.addAttribute("pstart",pstart);
		model.addAttribute("pend",pend);
		
		
		chong=mapper.getChong(pcode);
		if(pend>chong)
		{
			pend=chong;
		}
		
		
		
		
		model.addAttribute("chong",chong);
		
		
		//pcode를 이용하여 화면에 HOME-대분류-중분류-소분류 형태의 텍스트를 만들어서
		//사용자에게 알려준다.
		String pos="HOME-";
		String[] poses= {null, null, null};
		for(int i=0;i<poses.length;i++)
		{
			
			try
			{
				poses[i]=pcode.substring(i*2+1,i*2+3);
			    if(i==0)
			    {
				    pos=pos+" ▷ "+mapper.getDaeName(poses[0]);
			    }
			    else if(i==1)
			         {
				         pos=pos+" ▷ "+mapper.getJungName(poses[1], poses[0]);
			         }
			         else if(i==2)
			              {
			    	          pos=pos+" ▷ "+mapper.getSoName(poses[2],poses[0]+poses[1]);
			              }
				
			}
			catch(Exception e)
			{
				break;
			}
		}
		
		/*
		 * if(pcode.length()==3) { String code=pcode.substring(1);
		 * pos=pos+mapper.getDaeName(code); } else if(pcode.length()==5) { String
		 * daecode=pcode.substring(1,3); String code=pcode.substring(3);
		 * pos=pos+mapper.getDaeName(daecode); pos=pos+"-"+ mapper.getJungName(code,
		 * daecode);
		 * 
		 * }else { String daecode=pcode.substring(1,3);
		 * pos=pos+mapper.getDaeName(daecode); String jungcode=pcode.substring(3,5);
		 * pos=pos+"-"+mapper.getJungName(jungcode, daecode); String
		 * code=pcode.substring(5); String daejung=pcode.substring(1,5);
		 * pos=pos+"-"+mapper.getSoName(code, daejung);
		 * 
		 * }
		 */
		
		model.addAttribute("pos",pos);
		
		String order="1";
		if(request.getParameter("order")!=null)
			order=request.getParameter("order");
		//1=>order by pansu desc
		//2=>order by price desc
		//3=>order by price asc
		//4=>order by star desc
		//5=>order by writeday desc
		String str=" pansu desc";
		switch(order)
		{
			case "1": str=" pansu desc"; break;
			case "2": str=" price desc"; break;
			case "3": str=" price asc"; break;
			case "4": str=" star desc"; break;
			case "5": str=" writeday desc"; break;
		}
		
		
		ArrayList<ProductDto> plist=mapper.productList(pcode,str,index);
		//index값으로 정렬 되어 있다 => 배열처럼 정렬되어 있다.
		//할인금액, 적립금액, 배송일 관련 처리하여 dto에 저장
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
		
		model.addAttribute("plist",plist);
		model.addAttribute("pcode",pcode);
		return "product/productList";
	}

	@Override
	public String productContent(HttpServletRequest request, Model model,HttpSession session) {
		String pcode=request.getParameter("pcode");
		ProductDto pdto=mapper.productContent(pcode);
		
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
		pdto.setHalinPrice(halinPrice);
		pdto.setJukPrice(jukPrice);
		pdto.setBaeEx(beaEx);
		
		String userid=null;
		if(session.getAttribute("userid")!=null)
			userid=session.getAttribute("userid").toString();
		int ch=mapper.jjimCheck(userid, pcode);
		String jImg;
		if(ch==0) {
			jImg="jjim1.png";
		}
		else
			jImg="jjim2.png";
		model.addAttribute("jImg",jImg);
	    model.addAttribute("pdto",pdto);
	    model.addAttribute("userid",userid);	    
	    
	    
	    //product테이블의 star필드의 값을 이용하여
	    //노란별 ,반벌,.회색별의 개수를 뷰에 전달
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
	    model.addAttribute("ystar",ystar);
	    model.addAttribute("hstar", hstar);
	    model.addAttribute("gstar",gstar);	    //double sosu=
	    //만약 소수 노란별? 0.8이상
	    //star는 반올림한 값을 가져간다.

	    //만약 sosu가 0.3≤=값<0.8
	    //소수는 내림하고 //반별을 하나찍고 // 회색별-1을 출력한다.

	    //만약 소수가 0.3미만이라면 
	    //소수는 내림하고 회색별을 출력한다.
	    
	    
	    
	    //현재 상품에 대한 상품평 테이블의 내용을 읽어 온다.
	   ArrayList<ReviewDto> rlist= mapper.getReview(pcode);
	   
	   //content필드에 <br>태그 추가
	   for(int i=0; i<rlist.size();i++) {
		   String content=rlist.get(i).getContent().replace("\r\n", "<br>");
		   rlist.get(i).setContent(content);
	   }
	    model.addAttribute("rlist",rlist);
	    
	    
	    
	    
		return "/product/productContent";
	}

	@Override
	public String jjimOk(HttpServletRequest request, HttpSession session, Model model) {
	
		String pcode=request.getParameter("pcode");
		String fname=request.getParameter("fname");
		model.addAttribute("pcode",pcode);
		// TODO Auto-generated method stub
		//만약에 pcode가 찜테이블에 있다면 
		String userid=null;
		if(session.getAttribute("userid")!=null)
			userid=session.getAttribute("userid").toString();
     
    		if(session.getAttribute("userid")==null)
    		{
    			return "0";
    		}
    		else
    		{
    			userid=session.getAttribute("userid").toString();
    			if(fname.equals("jjim1.png"))
    				mapper.jjimOk(pcode,userid);
    			else
    				mapper.jjimDel(pcode,userid);
    			return "1";
    		}
        	
	
	}

	@Override
	public String addCart(HttpServletRequest request, HttpSession session, Model model,HttpServletResponse response) {
		
		String pcode=request.getParameter("pcode");
		int su=Integer.parseInt(request.getParameter("su"));
		System.out.println(su);
		try {
			if(session.getAttribute("userid")==null)
			{
				//로그인을 하지 않아도 장바구니 처리를 실행
				//이전의 쿠키변수 pcode를 읽어오기
				Cookie cookie=WebUtils.getCookie(request, "pcode");
				String newPro=pcode+"-"+su+"/";
				String newPcode=null;
				if(cookie==null)
				{
					System.out.println("null");
					newPcode=newPro;
				}else {
						String getPcode=cookie.getValue();
						//문자열로 처리가 복잡하니까 배열로 하자
						String[] pcodes=getPcode.split("/");
						int chk=-1;
						for(int i=0; i<pcodes.length; i++)
						{
							if(pcodes[i].indexOf(pcode)!=-1)
							{
								//어떤방에 중복된 값이 있는지를 알기 위해서 chk
								chk=i; //chk변수에는 존재하는 코드의 배열인덱스 값을 가진다.
							}
						}
						//한번씩 요청이 오니까. -1이 아닌거 하나만
						if(chk != -1)
						{
							int num=Integer.parseInt(pcodes[chk].substring(13)); //p01010103005-1
							num=num+su; //기존의 수량 + 추가되는 수량
							pcodes[chk]=pcodes[chk].substring(0,13)+num; //p01010103005
							//쿠키에는 /양식으로 저장하려고 이렇게 했음
							String imsi="";
							for(int i=0; i<pcodes.length; i++) {
								imsi=imsi+pcodes[i]+"/";
							}
							newPcode=imsi;
							System.out.println("중복");
						}else {
							newPcode=cookie.getValue()+newPro;
							System.out.println("중복아님");
						}
					}
					System.out.println(newPcode);
					//newPcode를 새로운 쿠키객체로 생성
					Cookie newCookie=new Cookie("pcode",newPcode);
					newCookie.setMaxAge(6000);
					newCookie.setPath("/");
					response.addCookie(newCookie);
					//userid가 없을 때 쿠키를 보내는 것 까지 했어.
					//그러면 아이디가 있다에서 시작해야해
			}else {
				
				String userid = session.getAttribute("userid").toString();

				// 로그인된 사용자라면 장바구니 처리를 진행
				// 1. 장바구니 테이블에서 해당 상품(pcode)이 이미 존재하는지 확인
				int ch = mapper.isCartCheck(userid, pcode);
				
				if (ch == 1) {
				    // 2. 해당 상품이 장바구니에 이미 존재하는 경우
				    //    - 장바구니에 있는 수량을 업데이트
				    mapper.suinc(pcode, su, userid);
				} else {
				    // 4. 해당 상품이 장바구니에 존재하지 않는 경우
				    //    - 장바구니 테이블에 새로 추가
					
				    mapper.addCart(pcode, su, userid);
				    // 쿠키를 가져온다.
				    //쿠키에 있는 리스트를 파싱하여 뽑아낸다.
				    //쿠키에 있는 pcode들 중에 이미 디비에 있으면isCartCheck(userid, pcode)
				    //mapper.suinc(pcode, su, userid);를 한다.
				    //pcode들 중 DB에 없으면
				   
				  
				}
			}
			return "0";
			
		}catch(Exception e) {
			
			return "1";
		}	
	
	}

	@Override
	public String gumae(HttpSession session, HttpServletRequest request,Model model) {
		
		
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			//구매자 정보(회원)
			String userid=session.getAttribute("userid").toString();
			model.addAttribute("mdto",mapper.getMember(userid));
			
			
			//배송지 정보
			BaesongDto bdto=mapper.getBaesong(userid);
			String breq=null;
			if(bdto!=null) {
				switch(bdto.getReq())
				{
					case 0: breq="문 앞"; break;
					case 1: breq="직접 받고 부재시 문 앞"; break;
					case 2: breq="경비실"; break;
					case 3: breq="택배함"; break;
					case 4: breq="공동 현관 앞"; break;
					default: breq="선택 안됨";
				}
		
			bdto.setBreq(breq);
			}
			model.addAttribute("bdto",bdto);
			
			//구매상품정보
			String pcode=request.getParameter("pcode");
			String su=request.getParameter("su");
			String[] pcodes=pcode.split("/");
			String[] imsi=su.split("/");
			int[] sues=new int[imsi.length];
			
			for(int i=0; i<imsi.length; i++)
			{
				sues[i]=Integer.parseInt(imsi[i]);
			}
			
			
			ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
			for(int i=0; i<pcodes.length;i++)
			{
				ProductDto pdto=mapper.productContent(pcodes[i]);
				pdto.setSu(sues[i]);
				LocalDate today=LocalDate.now(); // 오늘날짜 객체생성
        		// 오늘 기준 몇일 후의 날짜 객체
        		LocalDate xday=today.plusDays(pdto.getBaeday());
        		String yoil=MyUtil.getYoil(xday);
        	
        		String baeEx=null;
        		if(pdto.getBaeday()==1)
        		{
        			baeEx="내일("+yoil+") 도착예정";  // 내일(화) 도착예정
        		}
        		else if(pdto.getBaeday()==2)
        		     {
        			     baeEx="모레("+yoil+") 도착예정"; // 모레(수) 도착예정
        		     }
        		     else
        		     {
        		    	 int m=xday.getMonthValue();
        		    	 int d=xday.getDayOfMonth();
        		    	 baeEx=m+"/"+d+"("+yoil+") 도착예정";
        		     }
            	
        		pdto.setBaeEx(baeEx);
        		plist.add(pdto); 
				
			}
			
			model.addAttribute("plist",plist);
			//결제관련금액 => 총상품 금액, 배송비, 적립예정금액
			int halinPrice=0;
			int baePrice=0;
			int jukPrice=0;
			
			for(int i=0;i<plist.size(); i++)
			{
				ProductDto pdto=plist.get(i);
				int price=pdto.getPrice();
				int halin=pdto.getHalin();
				int su2=pdto.getSu();
				int bae=pdto.getBaeprice();
				halinPrice=halinPrice+(int)(price-(price*halin/100.0))*su2;
				baePrice=baePrice+bae;
				int juk=pdto.getJuk();
				jukPrice=jukPrice+(int)(price*juk/100.0)*su2;
				
		}
			
			model.addAttribute("baePrice",baePrice);
			model.addAttribute("jukPrice",jukPrice);
			model.addAttribute("halinPrice",halinPrice);
			
			//사용자의 적립금을 가져와서 뷰에 전달
			model.addAttribute("juk",mapper.getJuk(userid));
			return "/product/gumae";
		}
	
		
		
	}

	@Override
	public String jusoWriteOk(BaesongDto bdto, Model model, HttpSession session) {
		
		String userid=session.getAttribute("userid").toString();
		bdto.setUserid(userid);
		//주소가 존재하지만 새로 추가할 경우의 gibon은 나중에 처리
		
		if(bdto.getTt().equals("1"))
		{	
			if(bdto.getGibon()==1)
			{
				BaesongDto obdto=mapper.selectoriginal();
				mapper.gibonupdate(bdto);
				
				model.addAttribute("bname", bdto.getName());
				model.addAttribute("bjuso",bdto.getJuso());
				model.addAttribute("bphone",bdto.getPhone());
				String breq=null;
				switch(bdto.getReq())
				{
					case 0: breq="문 앞"; break;
					case 1: breq="직접 받고 부재시 문 앞"; break;
					case 2: breq="경비실"; break;
					case 3: breq="택배함"; break;
					case 4: breq="공동 현관 앞"; break;
					default: breq="선택 안됨";
				
				}
				model.addAttribute("breq",breq);
				if(obdto!=null) {
					obdto.setGibon(0);
					mapper.jusoWriteOk(obdto);
				}
				return "/product/jusoupdate";
			}else {
				mapper.jusoWriteOk(bdto);
				
				//방금 이력된 주소의 id필드의 값을 알 수 없다.
		
				return "redirect:/product/jusoList";
			}
		
		}else
		{
			
			mapper.jusoWriteOk(bdto);
			model.addAttribute("bname", bdto.getName());
			model.addAttribute("bjuso",bdto.getJuso());
			model.addAttribute("bphone",bdto.getPhone());
			String breq=null;
			switch(bdto.getReq())
			{
				case 0: breq="문 앞"; break;
				case 1: breq="직접 받고 부재시 문 앞"; break;
				case 2: breq="경비실"; break;
				case 3: breq="택배함"; break;
				case 4: breq="공동 현관 앞"; break;
				default: breq="선택 안됨";
			
			
			}
			model.addAttribute("breq",breq);
			
			int id=mapper.getBaeId(userid);
			model.addAttribute("id", id);
			
			return "/product/jusoWriteOk";
			
		}
		
	}

	@Override
	public String jusoList(Model model, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		ArrayList<BaesongDto> blist=mapper.jusoList(userid);
		//요청사항 req=> 문자열로 변환 처리
		for(int i=0; i<blist.size();i++) {
			String breq=null;
			switch(blist.get(i).getReq())
			{
				case 0: breq="문 앞"; break;
				case 1: breq="직접 받고 부재시 문 앞"; break;
				case 2: breq="경비실"; break;
				case 3: breq="택배함"; break;
				case 4: breq="공동 현관 앞"; break;
				default: breq="선택 안됨";
			}
			blist.get(i).setBreq(breq);
		}
		model.addAttribute("blist",blist);		
		return "/product/jusoList";
	}



	@Override
	public String jusoWrite(HttpServletRequest request, Model model) {
		// TODO Auto-generated method stub
		String id="n";
		model.addAttribute("tt",request.getParameter("tt"));
		return "/product/jusoWrite";
	}

	@Override
	public String chgPhone(HttpServletRequest request, HttpSession session) {
		try {
			String userid=session.getAttribute("userid").toString();
			String mPhone=request.getParameter("mPhone");
			mapper.chgPhone(userid, mPhone);
			return "0";
		} catch(Exception e) {
			return "1";
		}
		
	}

	@Override
	public String jusoDel(HttpServletRequest request, HttpSession session) {
		String id=request.getParameter("id");
		mapper.jusoDel(id);
		return "redirect:/product/jusoList";
	}

	@Override
	public String jusoUpdate2(HttpServletRequest request, HttpSession session,Model model) {
		String id=request.getParameter("id");
		model.addAttribute("bdto", mapper.jusoUpdate2(id));
		return "/product/jusoUpdate2";
	}

	@Override
	public String jusoUpdateOk2(BaesongDto bdto, HttpSession session) {
		if(bdto.getGibon()==1)
		{
			String userid=session.getAttribute("userid").toString();
			mapper.gibonInit(userid);
		}
		mapper.jusoUpdateOk2(bdto);
		return "redirect:/product/jusoList";
	}

	@Override
	public String gumaeOk(GumaeDto gdto, HttpSession session) {
		
		//userid에 세션 변수 저장, jumuncode를 생성
		String userid=session.getAttribute("userid").toString();
		
		//주문코드 => j20240905001
		LocalDate today=LocalDate.now();
		int y=today.getYear();
		int m=today.getMonthValue();
		int d=today.getDayOfMonth();
		
		String m2=String.format("%02d", m);
		String d2=String.format("%02d", d);
		
		String jumuncode="j"+y+m2+d2;
		int imsi=mapper.getJumuncode(jumuncode);
		System.out.println(imsi);
		jumuncode=jumuncode+String.format("%03d", imsi);
		gdto.setJumuncode(jumuncode);
		
		String[] pcodes=gdto.getPcodes();
		int[] sues=gdto.getSues();
		
		//장바구니에서 구매된 상품은 삭제
		
		
		//product 테이블에서 su 필드의 값을 -1, pansu의 값을 +1
		
		//member테이블의 juk필드의 값에 useJuk값을 뺀다. => 저장
		
		
		//사용한 적립금
		mapper.chgJuk(gdto.getUseJuk(),userid);
		
		for(int i=0; i<pcodes.length; i++) {
			gdto.setPcode(pcodes[i]);
			gdto.setSu(sues[i]);
			gdto.setUserid(userid);
			mapper.gumaeOk(gdto);
			//장바구니에 있는 구매된 상품은 삭제
			mapper.cartDel(userid,pcodes[i]);
			//product테이블에 su필드의 값을 -수량 ,pansu의 값을 +수량
			mapper.chgProduct(pcodes[i],sues[i]);
		}
		
		
		
		
		return "redirect:/product/gumaeView?jumuncode="+jumuncode;
	}

	
	
	//inner조인 없이 사용하기
/*	@Override
	public String gumaeView(HttpServletRequest request, Model model) {
		
		String jumuncode=request.getParameter("jumuncode");
		ArrayList<GumaeDto> glist=mapper.gumaeView(jumuncode);
		
		//배송 정보, 상품 정보를 glist를 이용하여 가져오기
		ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
		ArrayList<BaesongDto> blist=new ArrayList<BaesongDto>();
		for(int i=0; i<glist.size();i++) {
			//상품정보를 읽어서 plist에 add()
			GumaeDto gdto=glist.get(i);
			ProductDto pdto=mapper.productContent(gdto.getPcode());
			plist.add(pdto);		
		
			//배송정보를 읽어서 blist에 add()
			BaesongDto bdto=mapper.jusoUpdate2(gdto.getBaeId()+"");
			blist.add(bdto);		
		}
		return "/product/gumaeView";
	}
	*/
	
	
	@Override
	public String gumaeView(HttpServletRequest request, Model model) {
		
		//product, baesong,gumae에서 gumae에 pcode를 기준으로 가져와야함
		String jumuncode=request.getParameter("jumuncode");
		System.out.println("주문코드"+ jumuncode);
		ArrayList<HashMap> mapAll=mapper.gumaeView2(jumuncode);

		//하나의 할인된 상품금액 => price =>map에 저장
		//총상품금액(halinPrice), 총배송비(cBaeprice),도착예정(baeEx)
		
		int halinPrice=0, cBaePrice=0;
		String baeEx=null;
		String breq=null;
		for(int i=0; i<mapAll.size(); i++) {
			HashMap map=mapAll.get(i);
			//price할인된 상품금액
			
			int price=Integer.parseInt(map.get("price").toString());
			int halin=Integer.parseInt(map.get("halin").toString());
			price=(int)(price-(price*halin/100.0)); //하나의 삼품 구매
			//map.put("price",price); 여기에 저장하면 뷰에 전달이 안된다.
			mapAll.get(i).put("price", price);
			//총상품금액
			int su=Integer.parseInt(map.get("su").toString());
			halinPrice=halinPrice+(price*su);
			//총배송비
			cBaePrice=cBaePrice+Integer.parseInt(map.get("baeprice").toString());
			//배송예정
			LocalDate today=LocalDate.now();
			int baeday=Integer.parseInt(map.get("baeday").toString());
			LocalDate xday=today.plusDays(Integer.parseInt(map.get("baeday").toString()));
			String yoil=MyUtil.getYoil(xday);
			baeEx=null;
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
			
				mapAll.get(i).put("baeEx",baeEx);
				breq=null;
				switch(Integer.parseInt(map.get("req").toString()))
				{
					case 0: breq="문 앞"; break;
					case 1: breq="직접 받고 부재시 문 앞"; break;
					case 2: breq="경비실"; break;
					case 3: breq="택배함"; break;
					case 4: breq="공동 현관 앞"; break;
					default: breq="선택 안됨";
				}
			
			}
		
		model.addAttribute("mapAll",mapAll);
		model.addAttribute("halinPrice",halinPrice);
		model.addAttribute("cBaePrice",cBaePrice);
		model.addAttribute("breq",breq);
		
		return "/product/gumaeView";
	}

	@Override
	public String reviewDel(HttpServletRequest request, Model model) {
		
		String id=request.getParameter("id");
		String pcode=request.getParameter("pcode");
		
		
		mapper.reviewDel(id);
		
		
		return "redirect:/product/productContent?pcode="+pcode;
	}
	
}
