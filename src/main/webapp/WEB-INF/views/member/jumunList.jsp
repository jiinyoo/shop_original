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
    <c:if test="${mapAll.size()<6}">
     height:600px;
    </c:if>
    <c:if test="${mapAll.size()>=6}">
     margin-bottom:100px;
    </c:if>
     
     font-family: 'GmarketSansMedium';
   }
   .onePro {
     border:1px solid purple;
     width:1100px;
     padding:20px;
     margin-top:10px;
   }
 
   .onePro #pro1 {
     display:inline-block;
     width:600px;
     margin-top:6px;
   }
   .onePro #pro2 {
     display:inline-block;
     width:200px;
   }
   .onePro #pro3 {
     display:inline-block;
     width:80px;
   }
   .onePro #pro4 {
     display:inline-block;
     width:200px;
     vertical-align:middle;
   }
   
    .onePro #pro4 input[type=button]{
     font-size:11px;
   }
   
   
   main .gigan {
   	width:70px;
   	outline:none;
   	border:1px solid purple;
   }
   
   main #pkc {
   	position:relative;
   }
   
   main #cal {
   	position:absolute;
   	left:400px;
   	background:white;
   	border:1px solid purple;
   	visibility:hidden;
   	padding:5px;
   	
   }
   
   
   main #table td {
   	width:10px;
   	height:10px;
   	font-size:12px;
   	cursor:pointer;
   	padding:2px;
   
   }
   
   
 </style>
 <script>
 function calView(y,m,n)
 {

	  // 달력 생성시 필요한 값 : 1일의요일, 총일수, 몇주
	  // 1일의 요일 => ?년 ?월 1일의 날짜 객체가 필요
	  if(y==-2) // 값이 없다면
	  {

	     var today=new Date();		  
	     var y=today.getFullYear();
	     var m=today.getMonth(); // 0~11
	  }
	  
	  // 월이 -1이 오면
	  if(m==-1)
	  {
		  y=y-1;
		  m=11;
	  }	  
	  
	  // 월이 12가 오면
	  if(m==12)
	  {
		  y=y+1;
		  m=0;
	  }	  
	  
	  var xday=new Date(y,m,1);
	  var yoil=xday.getDay(); //0~6(일~토)
	  
	  var month=[31,28,31,30,31,30,31,31,30,31,30,31];
	  var chong=month[m];
	  
	  if( (y%4==0 && y%100!=0) || y%400==0 )  // 4의 배수 100의 배수는 아니다   단 400의 배수는 윤년
	  {
		  if(m==1)
		    chong=chong+1;
	  }	  
	  
	  var ju=Math.ceil( (chong+yoil)/7 );
	  

	  
	  var calData="<table align='center' width='200' height='180' border='0' id='table'>";
	  calData=calData+"<caption>";
	  calData=calData+" <span onclick='calView("+y+","+(m-1)+","+n+")'> << </span>";  
	  calData=calData+y+"년 "+(m+1)+"월";                                                
	  calData=calData+" <span onclick='calView("+y+","+(m+1)+","+n+")'> >> </span>";  
	  calData=calData+"</caption>";
	  calData=calData+"<tr>";
	  calData=calData+"<td> 일 </td>";
	  calData=calData+"<td> 월 </td>";
	  calData=calData+"<td> 화 </td>";
	  calData=calData+"<td> 수 </td>";
	  calData=calData+"<td> 목 </td>";
	  calData=calData+"<td> 금 </td>";
	  calData=calData+"<td> 토 </td>";
	  calData=calData+"</tr>";
	  var day=1;
	  for(i=1;i<=ju;i++)
	  {
		  calData=calData+"<tr>";
		  
		  for(j=0;j<7;j++)
		  {
			  if( (i==1 && j<yoil)  || chong<day  )  // 첫주에 1일의 요일보다 적은 j , 총일수보다 많은 day값일때
			  {	  
			      calData=calData+"<td> &nbsp; </td>";
			  }
			  else
			  {	  				//년 월 일을 전달한다.
				  calData=calData+"<td onclick='moveNalja("+y+","+m+","+day+","+n+")'>"+day+"</td>";
			      day++;
			  }
  	      }	  
		  
		  calData=calData+"</tr>";
	  }
	  calData=calData+"</table>";

	  document.getElementById("cal").innerHTML=calData;
	  document.getElementById("cal").style.visibility="visible";
	  
	  
	  if (n == 0) {
	        document.getElementById("cal").style.left = "400px";
	    } else if (n == 1) {
	        document.getElementById("cal").style.left = "600px";
	  }
 }
 
 
 
 
 function moveNalja(y,m,d,n) { //클릭된 날짜의 YYYY-MM-DD형식을 폼태그에 전달
	 
	 m=(m+1)+"";
 	 m=m.padStart(2,"0");
 	 d=d+"";
 	 d=d.padStart(2,"0");
	 
 	 
 	 
 	 
 	 
	 var gigan=document.getElementsByClassName("gigan");
 	 var nalja=y+"-"+m+"-"+d;
 	 
 	 if(n==0) {
 	 	gigan[n].value=nalja;
 	 }
 	 
 	 if(n==1) {
 		 //시작 날짜는 => gigan[n].value
 		 var s1=new Date(gigan[0].value);
 		 //끝 날자는 => nalja
 		 var s2=new Date(nalja);
 		 //alert(s2-s1);
 		 if((s2-s1)<0) {
 			 alert("두번째 날짜가 첫번째 날짜 보다 이전입니다.")
 			 gigan[n].value="";
 		 } else {
 			gigan[n].value=nalja;
 		 }
 	 }
 	 
 	 document.getElementById("cal").style.visibility="hidden";
	 
 }
 
 
 
 
 </script>
 
 
</head>
<body>
  <main>
  <h2>주문 목록</h2>
  <div align="center" id="pkc">
  <form method="post" action="jumunList">
  	<input type="hidden" name="num" value="1"><!-- 기간 검색이라는 걸 알리려고 -->
  	<input type="button" onclick="location='jumunList?num=3'" value="3개월">
  	<input type="button" onclick="location='jumunList?num=6'" value="6개월">
  	<input type="button" onclick="location='jumunList?num=9'" value="12개월">
  	<input type="text" name="start" readonly class="gigan" onfocus="calView(-2,-2,0)">
  	<!-- 발생하지 않을 값을 만들어 줌 -2 -->
  	<input type="text" name="end" readonly class="gigan" onfocus="calView(-2,-2,1)">
  	<!-- 두번째 값이 들어갈 때 -->
  	<input type="submit" value="기간검색"> 
  </form>
  	<div id="cal"></div>
  </div>
  
  
    <c:set var="i" value="0"/>
    <c:forEach begin="1" end="${mapAll.size()}">
       <c:if test="${i<mapAll.size()}">
       <c:set var="chk" value="0"/>
         <c:forEach begin="0" end="${mapAll.get(i).cnt-1}" varStatus="sts">
           <c:if test="${chk==0}">
            <div class="onePro" id="left">
              <h3>  ${mapAll.get(i).writeday}  </h3> 
           </c:if>  
              <div id="pro1">
                 <img src="../static/product/${mapAll.get(i).pimg}" width="40" height="40" valign="middle">
                 ${mapAll.get(i).title}
              </div>
              <div id="pro2">
                <fmt:formatNumber value="${mapAll.get(i).chongPrice}" type="number"/>원 
                <span style="font-size:12px;"><br> 
                (사용적립금:<fmt:formatNumber value="${mapAll.get(i).useJuk}" type="number"/>원) 
                </span> 
              </div>
              <div id="pro3">
                ${mapAll.get(i).su}개 
                <br><span style="font-size:15px">${mapAll.get(i).stateMsg} </span>
                
              </div>
              <div id="pro4">
                  <c:if test="${mapAll.get(i).state==0 || mapAll.get(i).state==1 || mapAll.get(i).state==2}">
			        <input type="button" value="취소신청" id="btn" onclick="location='chgState?state=4&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==3}">
			        <input type="button" value="반품신청" id="btn" onclick="location='chgState?state=5&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==3}">
			        <input type="button" value="교환신청" id="btn" onclick="location='chgState?state=7&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==3 && mapAll.get(i).isReview==0}">
			        <input type="button" value="리뷰쓰기" id="btn" onclick="location='reviewWrite?pcode=${mapAll.get(i).pcode}&id=${mapAll.get(i).id}'">
			       </c:if>
			        <c:if test="${mapAll.get(i).state==3 && mapAll.get(i).isReview==1}">
			        <input type="button" value="리뷰보기" id="btn">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==5}"> 
			        <input type="button" value="반품취소" id="btn" onclick="location='chgState?state=3&id=${mapAll.get(i).id}'">
			       </c:if>
			       <c:if test="${mapAll.get(i).state==7}"> 
			        <input type="button" value="교환취소" id="btn" onclick="location='chgState?state=3&id=${mapAll.get(i).id}'">
			       </c:if> 
              </div>
           <c:if test="${mapAll.get(i).cnt-1 != sts.index }"> 
            <c:set var="i" value="${i+1}"/>
           </c:if>
           <c:set var="chk" value="1"/>
         </c:forEach>
          </div>  <!--  onePro -->
          <div id="right">
          </div>
        </c:if>
      <c:set var="i" value="${i+1}"/>
    </c:forEach>
  </main>
</body>
</html>






