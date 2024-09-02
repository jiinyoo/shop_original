<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
<style>
	main {
		width:1100px;
		margin:auto;
	}

	main section{
		width:1100px;
		margin:auto;
	}
	
	main #first {
    display: flex;
    width: 1100px;
    height: 500px;
    margin: auto;
    align-items: center; /* 수직 중앙 정렬 */
    display: flex;
	}

	main #first #left {
	    width: 500px;
	    height: 500px;
	    margin: auto;
	    display: flex; /* 플렉스 박스 사용 */
	    align-items: center; /* 수직 중앙 정렬 */
	    justify-content: center; /* 수평 중앙 정렬 */
	}
	
	main #first #right{
		width:600px;
		height:500px;
		
	   /* 수직 중앙 정렬 */
	 
	}
	
	
	main #first #ptitle
	{
		width:600px;
		height:80px;
		border-bottom: 1px solid black;
		font-size:20px;
		line-height:80px;
	
		
	}
	
	
	main #first #star
	{
		width:600px;
		height:60px;
		border-bottom: 1px solid grey;
		line-height:60px;
		
	}
	
	
	main #first #prices {
    width: 600px;
    height: 90px;
    border-bottom: 1px solid grey;
    line-height: 90px;
    display: flex; /* Flexbox로 한 줄에 표시 */
    align-items: center; /* 수직 중앙 정렬 */
    gap: 10px; /* 요소들 사이의 간격 */
	}
	
	main #first #baesong
	{
		width:600px;
		height:90px;
		border-bottom: 1px solid grey;
		line-height:90px;
	}
	
	main #first #baesong
	{
		width:600px;
		height:90px;
		border-bottom: 1px solid grey;
		line-height:90px;
		
	}
	
	
	
	main #first #juk
	{
		width:600px;
		height:50px;
		border-bottom: 1px solid grey;
		line-height:50px;
		
	}
	
	main #first #buttons {
		    width: 600px;
		    height: 90px; /* 기존 height 유지 */
		    line-height: normal; /* line-height 기본값으로 설정 */
		    display: flex; /* Flexbox 사용 */
		    align-items: center; /* Flexbox로 수직 중앙 정렬 */
		    gap: 10px; /* 버튼 사이의 간격 설정 */
		}
	
	#su {
		    width: 30px;
		    height: 30px; /* 원하는 높이로 설정 */
		    text-align: center;
		    line-height: 30px; /* line-height를 height와 동일하게 설정 */
		    outline: none; /* 기본 outline 제거 */
		}
	
	
	#btn{
		width:200px;
		height:33px;
		barckground:white;
		border:1px solid purple;
		align-items: center; /* 수직 중앙 정렬 */
	
	}
	
	
	#submit{
		width:200px;
		height:33px;
		background:purple;
		color:white;
		border:1px solid purple;
		align-items: center; /* 수직 중앙 정렬 */
	}
	
	

   main #first #right #buttons { /* 장바구니 버튼이 있는 div태그 */
    position:relative;
  }
   main #first #right #buttons #confirm { /* 레이어 창 */
     position:absolute;
     left:70px;
     top:-100px;
     width:260px;
     height:70px;
     border:1px solid purple;
     background:white;
     visibility:hidden;
   }
   main #first #right #buttons #confirm div { /* 레이어 안의 2개의 div */
     text-align:center;
     width:260px;
     height:35px;
     line-height:35px;
     font-family:'GmarketSansMedium';     
   }
   main #first #right #buttons #confirm div input{ /* 레이어 안의 button */
     width:100px;
     height:30px;
     border:1px solid purple;
     background:purple;
     color:white
   }
	
</style>
 <script src="https://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
  
  <script>
  	$(function(){
  		
  	//상품의 원래 가격
			var price=${pdto.price}
			//아이디 su가 있으므로 자바스크립트 변수에 su만들면 안됨
			//상품의 할인율
			var halin=${pdto.halin}
			//상품의 적립율
			var juk=${pdto.juk}
  		$("#su").spinner(
  			{
  				
  				min:1,
  				max:10,
  				spin:function(e,ui) //버튼이 클릭되었을 때 실행되는 함수
  				{
  					var su2=ui.value;
  					
  					//alert(ui.value);
  					//ui.value를 이용하여 상품의 원래 가격, 할인 후 가격, 적립금
  					//원래가격 * 수량
  					var jsprice=price*su2;
  					//(원래가격-(원래가격*할인율/100))*수량
  					var jshalinPrice=(price-(price*halin/100))*su2;
  					//(원래가격-(원래가격*할인율/100))*(적립율/100)*수량
  					var jsjukprice=(price*(juk/100))*su2;
  					
  					document.getElementById("input1").innerText=comma(jsprice);
  					document.getElementById("input2").innerText=comma(jshalinPrice);
  					document.getElementById("input3").innerText=comma(jsjukprice);
  				}
  			
  			});
  	});
  		
  	
  	function comma(value)
  	{
  		return new Intl.NumberFormat().format(value)
  	}
  	
  	
	function jjimOk(pcode) {
		var imgName=document.getElementById("img").src; // http://.../../jjim1.png
		var fname=imgName.substring( imgName.lastIndexOf("/")+1 );
		var chk = new XMLHttpRequest();
		chk.onload = function() {
			// chk.responseText에 따라 이미지 업데이트
			if (chk.responseText == 0) {
				location = "../login/login?pcode=" + pcode;
			} else {
				
				//jjim1.png => jjim2.png로 변경(찜선택)
				//alert(document.getElementById("img").src)
				
				if(fname=="jjim1.png")
				{
					document.getElementById("img").src="../static/main/jjim2.png";
				}
				//jjim2.png=> jjim1.png로 변경해야 한다.
				else
				{
					document.getElementById("img").src="../static/main/jjim1.png";
				}
				
			}
		}
		
		chk.open("GET", "jjimOk?pcode="+pcode+"&fname="+fname);
		chk.send();
	}
	
	
	
	function addCart()
    {
    	var pcode="${pdto.pcode}";
    	var su=document.gform.su.value;
    	
    	var chk=new XMLHttpRequest();
    	chk.onload=function()
    	{
    		//alert(chk.responseText);
    		if(chk.responseText=="0")
    		{
    			/*
    			if(confirm("장바구니로 이동하시겠습니다"))
    			{
    				location="../product/cartView";
    			}
    			*/
    			// 요즘은 레이어를 보여주고 몇 초뒤에 숨긴다.
    			
    				var chk2=new XMLHttpRequest();
					chk2.onload=function()
					{
						
						document.getElementById("cartNum").innerText=chk2.responseText;
					}
					chk2.open("get","../main/cartNum"); //상대경로로 가져오면 안되고 
					chk2.send();
		
    			
    			
    			
    			
    			document.getElementById("confirm").style.visibility="visible";
    			// setTimeout(함수,시간); 함수는 호출도 가능, 익명함수도 가능 function(){}
    			setTimeout(function()
    			{
    				document.getElementById("confirm").style.visibility="hidden";
    			},3000);
    		}	
    		else
    		{
    			alert("잠시 오류가 발생하였습니다");
    		}	
    	}
    	chk.open("get","addCart?pcode="+pcode+"&su="+su);
    	chk.send();
    	
    	
    	var chk2=new XMLHttpRequest();
		chk2.onload=function()
		{
			
			document.getElementById("cartNum").innerText=chk2.responseText;
		}
		chk2.open("get","../main/cartNum"); //상대경로로 가져오면 안되고 
		chk2.send();
		
    	
    }
	

	
	
	

  </script>
  
  
  
</head>
<body>
	<main>
		<form name="gform" method="post" action="gumae">
		<section id="first">
			<div id="left">
				<img src="../static/product/${pdto.pimg}" style="width:100%; margin:auto;">
			</div>
				<div id="right">
				<div id="ptitle">${pdto.title}
				<a href="javascript:jjimOk('${pdto.pcode}')">
				
				<img id="img" src="../static/main/${jImg}" valign="middle" style="margin-left:100px;">
				
				</a>	
					</div>
				<div>
				<div id="star">
					<c:forEach begin="1" end="5">
						<img src="../static/pro/star1.png" width="10">
					</c:forEach>
				 	<span style="letter-spacing:0px"> ${pdto.review}개 상품평 </span>
				</div>
		      	</div>
		      	<div id="prices">
		      	
					<c:if test="${pdto.halin!=0}">
						${pdto.halin}%
					</c:if>
					<c:if test="${pdto.halin==0}">
						 0%
					</c:if>
						<s><span id="input1"><fmt:formatNumber value="${pdto.price}" type="number"/></span>원
						</s>
						</span>
					
					<p>
						<span id="input2"><fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원</span>
					
				</div>
				
				<div id="baesong">
						<c:if test="${pdto.baeprice==0}">
							무료배송
						</c:if>	
						<c:if test="${pdto.baeprice!=0}">
							배송료 <fmt:formatNumber value="${pdto.baeprice}" type="number"/>원
						</c:if>	
				</div>
					<div>${pdto.baeEx}</div>
				
				<div id="juk">
					적립예정 :<span id="input3"> <fmt:formatNumber value="${pdto.jukPrice}" type="number"/></span>원
				</div>
				
				<div id="buttons">
					수량
					<!-- 장바구니는 폼태그가 있어야 한다.오로지 버튼으로만 바꾸기 위해서 readonly 로 한다.-->
					 <input type="text" name="su" value="1" id="su"> 
			         <input type="button" onclick="addCart(),showview()" value="장바구니" id="btn" valign="middle"> 
			         <input type="submit" value="바로구매" id="submit">
			         <div id="confirm">
			          <div> 장바구니로 이동하시겠습니까? </div> 
			          <div> <input type="button" value="장바구니 이동" onclick="location='../member/cartView'"> </div>
			         </div>			
				</div>
			</div>
		</section>
		<section id="second"></section>
		<section id="third"></section>
		<section id="fourth"></section>
		<section id="fourth"></section>
		</form>
	</main>
</body>
</html>