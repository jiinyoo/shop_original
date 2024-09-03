<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- jQuery UI 라이브러리 포함 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- jQuery UI CSS 포함 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
    main {
      width:1100px;
      height:600px;
      margin:auto;
      overflow:auto;
    }
    main table {
      margin-top:50px;     
      margin-bottom:50px;
      border-spacing:0px;
    }
    main table td {
      border-bottom:1px solid purple;
      padding-top:5px;
      padding-bottom:5px;
    }
    main table tr:first-child td {
      border-top:2px solid purple;
    }

	main #mainChk{
		width:20px;
		height:18px;
	}
	
	main .subChk{
	
	}
</style>
<script>
$(function()
	    {
	    	 
	    	// 숫자입력칸을 jquery에서 지원하는 spinner를 사용
	    	$(".csu").spinner(
	    			{
	    				min:1,
	    				max:10,
	    				spin:function(e,ui) // 버튼이 클리되었을때 실행되는 함수
	    				{
	    					var index=$(".csu").index(this);
	    				    chgSu(ui.value,index); // 수량과 인덱스를 가지고 함수호출
	                      
	    				}
	    			});
	    
	    	$(".csu").css("width", "30px");	
	    	
	    });
	    
	    
		function comma(value)
		{
			return new Intl.NumberFormat().format(value);
		}
			    
	    
	    
	    
	    function chgSu(su,index) // ajax를 통해 서버에서 hp,jp,bp금액을 계산해서 받기
	    {
	    	var pcode=document.getElementsByClassName("subChk")[index].value
	    	var chk=new XMLHttpRequest();
	    	chk.onload=function()
	    	{
	    		//alert(chk.responseText);
	    		var data=JSON.parse(chk.responseText);
	   
	    		document.getElementsByClassName("hp")[index].innerText=comma(data[0]);
	    		document.getElementsByClassName("jp")[index].innerText=comma(data[1]);
	    		
	    		var imsi;
	    		if(data[2]==0)
	    			imsi="무료배송";
	    		else
	    			imsi=comma(data[2]);
	    		document.getElementsByClassName("bp")[index].innerText=imsi;

	    		totaladd();
	    	}
	    	chk.open("get","chgSu?su="+su+"&pcode="+pcode);
	    	chk.send();
	    }


function selDel()
{
	//class="subChk"의 요소를 검사.
	var subChk=document.getElementsByClassName("subChk");
	var su=document.getElementsByClassName("csu");
	//모든 subChk를 다 검사한다.
	var pcode="";
	for(i=0;i<subChk.length;i++)
	{
		if(subChk[i].checked)
		{
		  <c:if test="${userid!=null}">
			pcode=pcode+subChk[i].value+"/";
	      </c:if>
	      <c:if test="${userid==null}">
			    pcode=pcode+subChk[i].value+"-"+su[i].value+"/";
	      </c:if>
		}
	}	
	
	if(pcode!="")
	 location="cartDel?pcode="+pcode;
	 
}



var chk=0;
function whole()
{
	var len=document.getElementsByClassName("subChk").length;
	
	
	if(document.getElementById("mainChk").checked){
				
		for(var i=0; i<len; i++){
			document.getElementsByClassName("subChk")[i].checked=true;
			chk=len;
		}
		
	}else{
		for(var i=0; i<len; i++){
			document.getElementsByClassName("subChk")[i].checked=false;	
			chk=0;
		}
		
		
	}

	console.log("chk: ", chk);  // 선택된 항목 수
	console.log("len: ", len);  // 총 항목 수
	document.getElementById("suntaek").innerText=chk+"/"+len+"개 선택";
	
	
}







/*function subChkcheck()
{
	var len=document.getElementsByClassName("subChk").length;
	
	var arr = [];
	arr.length=len;
	
	for(var i=0; i<len; i++){
		arr.push(document.getElementsByClassName("subChk")[i].checked);	
	}
		
	if(arr.includes(false))
		document.getElementById("mainChk").checked=false;
	
	else
		document.getElementById("mainChk").checked=true;
	
}*/


function subChkcheck()
{
	chk=0;
	var len=document.getElementsByClassName("subChk").length;
	for(var i=0; i<len; i++){
			if(document.getElementsByClassName("subChk")[i].checked==true)
				chk++;
	}
	
	if(chk==len)
		document.getElementById("mainChk").checked=true;
	else
		document.getElementById("mainChk").checked=false;
	
	document.getElementById("suntaek").innerText=chk+"/"+len+"개 선택"
	
	
	totaladd();
	
	
	
}


//체크박스가 클릭되면
function totaladd(){
	
	var len=document.getElementsByClassName("subChk").length;
	var totalhp=0;
	var totaljp=0;
	var totalbp=0;
	for(var i=0; i<len; i++){
		if(document.getElementsByClassName("subChk")[i].checked==true)
			{
				var hpimsi=document.getElementsByClassName("hp")[i].innerText
				var jpimsi=document.getElementsByClassName("jp")[i].innerText
				var bpimsi=document.getElementsByClassName("bp")[i].innerText.trim();
				hpimsi = parseInt(hpimsi.replace(/,/g, ''));
				jpimsi= parseInt(jpimsi.replace(/,/g, ''));
				totalhp=totalhp+hpimsi;
				totaljp=totaljp+jpimsi;
				if(bpimsi==="무료배송")
					{
						totalbp+=0;
					}
				else{
						bpimsi= parseInt(bpimsi.replace(/,/g, ''));
						totalbp=totalbp+bpimsi;
					
				
				    }
				
			}
			
	}
	
	document.getElementById("halinTot").innerText=totalhp.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	document.getElementById("baeTot").innerText=totalbp.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	document.getElementById("jukTot").innerText=totaljp .toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	document.getElementById("habeTot").innerText=(totalhp+totalbp).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}













/*function numberchange(index)
{
		//우선 onesu의 값을 받고 그 친구에 수량을 곱한 값을 넣는다.
		
		
		/*
		var onesu=parseInt(document.getElementsByClassName("csu")[index].value);
		alert(onesu);
		
		
		
		var onehp=parseInt(수량이 하나일 때의 가격)*onesu;
		document.getElementsByClassName("hp")[index].innerText=onehp;
		
	    var onejp=parseInt(수량이 하나일 때의 가격)*onesu;
	    document.getElementsByClassName("jp")[index].innerText=onejp;
	    
	    if(document.getElementsByClassName("bp")[index].innerText.trim=="무료배송")
	    	{
	    		document.getElementsByClassName("bp")[index].innerText="무료배송";
	    	}else{
	    		var onebp=parseInt(document.getElementsByClassName("bp")[index].innerText.replace(/,/g, ''))
	    		document.getElementsByClassName("bp")[index].innerText=onebp;
	    		
	    	}
	    
	    
	    
	    totaladd(); 
	 
	    
	   
}
*/


function gumaeAll()
{
	var subChk=document.getElementsByClassName("subChk");
	var su=document.getElementsByClassName("csu");
	
	var pcodes="";
	var sues="";
	for(var i=0; i<subChk.length; i++)
	{
		if(subChk[i].checked) //체크가 된 상품이라면 => 상품코드, 수량을 특정 변수에 누적(구분자)
			{
				
				pcodes=pcodes+subChk[i].value+"/";			
				sues=sues+su[i].value+"/";			
			}
		
		
	}
	
	alert(pcodes+"\n"+sues);
	location="../product/gumae?pcode="+pcodes+"&su="+sues;
	
}



</script>
</head>
<body>
<main>
	<table width="1000" align="center">
	<c:set var="chk" value="0" />
	<caption><h2>장바구니 현황</h2>
	<c:forEach items="${pMapAll}" var="map" varStatus="status">
	<c:set var="str" value=""/>
	<c:set var="str2" value=""/>
	<c:if test="${map.days<=1}">
		<c:set var="str" value="checked"/>
		<c:set var="chk" value="${chk+1}" />
	</c:if>
	<c:if test="${chk==pMapAll.size()}">
		<c:set var="str2" value="checked"/>
	</c:if>
		 <tr height="80">
		 	<td width="30"><input type="checkbox" value="${map.pcode}" ${str} class="subChk" onclick="subChkcheck()" ></td>
			<td width="100" align="center"><img src="../static/product/${map.pimg}" width="80"></td>
			<td align="left">${map.title}</td>
			<td width="140">${map.baeEx}</td>
			<td width="110" align="right"> <span class="hp"><fmt:formatNumber value="${map.halinprice}" type="number"/></span>원 </td>
       		<td width="110" align="right"> <span class="jp"> <fmt:formatNumber value="${map.jukprice}" type="number"/></span> 원</td>
			<td width="60" align="right"><input type="text" width="10" value="${map.csu}" readonly class="csu"  data-index="${status.index}"> </td>
			<td width="110" align="right"> 
				<c:if test="${map.baeprice==0}">
					<span class="bp">무료배송</span>
				</c:if>
				<c:if test="${map.baeprice!=0}">
					<span class="bp"><fmt:formatNumber value="${map.baeprice}" type="number"/></span>원
				</c:if>
				<!-- 쿠키변수에서 replace로 상품을 지우려고 하면 상품코드-수량/ 이 형태로 보내진다. -->
				<c:if test="${userid==null}">
					<br><input type="button" value="삭제" onclick="location='cartDel?pcode=${map.pcode}-${map.csu}'">
				</c:if>
				<c:if test="${userid!=null}">
					<br><input type="button" value="삭제" onclick="location='cartDel?pcode=${map.pcode}'">
				</c:if>
			</td>
		<tr>
	</c:forEach>
	<tr>
		<td colspan="6" height="30" valign="middle"><input type="checkbox" ${str2} id="mainChk" onclick="whole()">
		전체선택 <input type="button" value="선택상품 삭제" onclick="selDel()">
		<span id="suntaek"></span>		
		</td>
		<td colspan="2">
			<input type="button" value="선택 상품 구매" onclick="gumaeAll()">
		</td>
		
		
		
		
		
	</tr>
		<td colspan="8" align="center">
			총 상품 금액
			<span id="halinTot"><fmt:formatNumber value="${halinpriceTot}" type="number"/></span>  원+배송비 
			<span id="baeTot"><fmt:formatNumber value="${baepriceTot}" type="number"/></span> 원 = 총 결제금액 
			<span id="habeTot"><fmt:formatNumber value="${halinpriceTot+baepriceTot}" type="number"/></span> 원(적립예정: 
			<span id="jukTot"><fmt:formatNumber value="${jukpriceTot}" type="number"/></span> 원)
		</td>
	
	
	</table>
</main>
</body>
</html>