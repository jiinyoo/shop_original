package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.MemberDto;
import com.example.demo.mapper.LoginMapper;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms3")

public class LoginServiceImpl implements LoginService{

	@Autowired
	LoginMapper mapper;

	@Override
	public String login(HttpServletRequest request, Model model) {
		// TODO Auto-generated method stub
		String err=request.getParameter("err");
		String pcode=request.getParameter("pcode");
		model.addAttribute("err",err);
		model.addAttribute("pcode",pcode);
		return "/login/login";
	}

	@Override
	public String loginOk(MemberDto mdto,HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		// TODO Auto-generated method stub
		if(mapper.loginOk(mdto)!=null)
		{
			//pcode 쿠키 변수에 있는 상품과 수량을 cart테이블에 저장하기
			
			
			Cookie cookie = WebUtils.getCookie(request, "pcode");
	        
	        if (cookie!=null && !cookie.getValue().equals("")) {
	            // 쿠키에서 pcode 리스트를 파싱하여 가져옵니다.
	            String getPcode = cookie.getValue();
	            System.out.println("로그인 한 순간의 pcode의 쿠키값"+getPcode);
	            
	            
	            
	            
	            
	            
	            
	            String[] pcodessu = getPcode.split("/");
	            
	            String[] pcodes=new String[pcodessu.length];
	            int[] su=new int[pcodessu.length];
	            
	            for(int i=0; i<pcodessu.length; i++) {	
	            	pcodes[i]=pcodessu[i].split("-")[0];
	            	su[i]=Integer.parseInt(pcodessu[i].split("-")[1]);
	            	
	            	int check = mapper.isCartCheck(mdto.getUserid(), pcodes[i]); 
	            	
	            	if(check==1)
	            	{
	            		mapper.suinc(su[i], mdto.getUserid(),pcodes[i]);
	            	
	            	}
	            	else
	            	{
	            		mapper.addCart(pcodes[i], su[i], mdto.getUserid());
	            		
	            	}
	            	
	            	
	            	
	            }
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	            
	           /* String[] pcodes = getPcode.split("/");
	            
	 
	            for (String code : pcodes) {
	                // 쿠키의 pcode가 현재 장바구니에 있는지 확인
	            	System.out.println("로그인한 순간의 code.sugstring(0,12)"+code.substring(0,12));
	                int check = mapper.isCartCheck(mdto.getUserid(), code.substring(0, 12)); 
	                
	                if (check == 1) {
	                    // 장바구니에 존재하는 경우 수량 업데이트
	                    int count = Integer.parseInt(code.substring(13));
	                    //su량으로 하면 값이 바뀌는 것이므로 split이 편하다
	                    mapper.suinc(count, mdto.getUserid(),code.substring(0, 12));
	                } else {
	                    // 장바구니에 존재하지 않는 경우 새로 추가
	                    int count = Integer.parseInt(code.substring(13));
	                    mapper.addCart(code.substring(0, 12), count, mdto.getUserid());
	                }
	            }*/
	        }
			
	        Cookie newCookie=new Cookie("pcode","");
			newCookie.setMaxAge(0);
			newCookie.setPath("/");
			response.addCookie(newCookie);
			
			
			
			
			
			session.setAttribute("name", mapper.loginOk(mdto));
			session.setAttribute("userid", mdto.getUserid());
			//mdto를 활용해서 값을 가져올 수 있다는 사실을 명심
			if(mdto.getPcode().length()==0)
			{
				return "redirect:/main/index";
			}
			else
			{
				return "redirect:/product/productContent?pcode="+mdto.getPcode();
			}
			
			
		}else
		{
			
			return "redirect:/login/login?err=1";
		}
		
	}

	@Override
	public String logout(HttpSession session) {
		// TODO Auto-generated method stub
		session.invalidate();
		return "redirect:/main/index";
	}
	
	
	
	
}
