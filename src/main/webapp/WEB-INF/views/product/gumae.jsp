<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
 main {
     width:1100px;
     margin:auto;
    font-family: 'GmarketSansMedium';
   }
   
   main #sudan .sub {
     display:none;
   }
   main #sudan #fsub {
     display:block;
   }
   main #sudan #sudanFirst {
     width:1100px;
     height:180px;
     border:1px solid purple;
     padding:10px;
   }
   main #sudan #sudanSecond {
     width:1100px;
     height:40px;
     border:1px solid purple;
     border-top:none;
     padding:10px;
   }
   main #sudan .subMain {
     display:none;
   }
   main #sudan #up {
     display:none;
   }
   main #sudan #down {
   
   }
   main #sudan select {
     width:120px;
     height:28px;
     margin-left:10px;
   }
   
   main table {
      border-spacing:0px;
      margin-top:30px;
   }
 
   main table tr:first-child td {
      border-top:2px solid purple;
   }
   main table tr:last-child td {
      border-bottom:1px solid purple;
   }
   main table td {
      font-size:14px;
      height:40px;
      padding-left:10px;
      border-bottom:1px solid purple;
   }
   main table tr td:first-child {
      background:#efefef;
      
   }
   main table  #useJuk {  /* 적립금 input태그 */
      width:50px;
      outline:none;
      text-align:right;
   }



</style>
<script>
function jusoChuga()
{
	open("jusoWrite","","width=400,height=500");	
	
}

function jusoChange()
{
	
	open("jusoList","","width=450,height=500");	
	
}

function viewSub(n) {
	var sub=document.getElementsByClassName("sub");
	for(i=0; i<sub.length; i++)
		sub[i].style.display="none";
	sub[n].style.display="block";
}

function down() { //다른 결제 수단을 보이게 하기 =>#sudanSecond의 높이 :180, subMain을 block
	document.getElementById("sudanSecond").style.height="180px";
	var subMain=document.getElementsByClassName("subMain");
	for(i=0;i<subMain.length;i++) {
		subMain[i].style.display="block";
	}
	document.getElementById("up").style.display="inline";
	document.getElementById("down").style.display="none";
}

function up(){
	document.getElementById("sudanSecond").style.height="40px";
	var subMain=document.getElementsByClassName("subMain");
	for(i=0;i<subMain.length;i++) {
		subMain[i].style.display="none";
	}
	document.getElementById("up").style.display="none";
	document.getElementById("down").style.display="inline";
	
}
function numCheck(my)
{   
	   my.value=my.value.replace(/[^0-9]/g,"");
}
function init(my)
{
	   if(my.value=="0")
	   {
       my.value="";		   
	   }
}
var jukImsi=${juk}; // 사용자의 적립금을 변수에 저장
var chongPrice=${halinPrice+baePrice};
function jukCal(my)
{
	   if(my.value=="")
	   {
		   my.value="0";
		   document.getElementById("chong").innerText=comma(chongPrice);
	   }	   
	   else
	   {
		   if(my.value>jukImsi)
		   {
			   alert("보유적립금을 초과합니다");
			   my.value="0";
			   document.getElementById("myJuk").innerText=comma(jukImsi);
			   document.getElementById("chong").innerText=comma(chongPrice);
		   }	
		   else
		   {	   
		       document.getElementById("myJuk").innerText=comma(jukImsi-my.value);
		       // 총상품금액계산         // 384,500
		       //var imsi=document.getElementById("chong").innerText.replace(/[,]/g,""); // 잘못동작한다.
		       document.getElementById("chong").innerText=comma(chongPrice-my.value);
		   }
		       
	   }	   
}
function comma(value)
{
	return new Intl.NumberFormat().format(value);
}


function chgPhone() {
	var mPhone=document.getElementById("memberPhone").value;
	if(mPhone.trim().length==0) {
		alert("전화번호가 없습니다.")
	} else {
		var chk=new XMLHttpRequest();
		chk.onload=function() {
			if(chk.responseText=="1"){
				alert("오류가 발생하였습니다.");
			}
		}
		chk.open("get","chgPhone?mPhone="+mPhone);
		chk.send();
	}
	
}



function viewSrc()
{
	   document.getElementById("src").innerText=document.getElementById("baesong").innerHTML;
}



</script>
<style>
main #sudan .sub
{
	display:none;
	
}
main #sudan #fsub{
	display:block;
}

main{
	width:1100px;
	margin:auto;
}

main #sudan #sudanFirst {
 	width:1100px;
    height:180px;
    border:1px solid purple;
}
main #sudan #sudanSecond {
    width:1100px;
    height:40px;
    border:1px solid purple;
    border-top:none;
}


main #sudan .subMain{
	display:none;
}

main #sudan #up {
	display:none;
}
</style>

<!-- <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function juso_search()  // 우편번호 버튼 클릭시 호출 함수명
{
  new daum.Postcode({
      oncomplete: function(data) {
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
        } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        //document.pkc.zip.value = data.zonecode; // 우편번호
        //document.pkc.juso.value = addr;  // 주소
        // 커서를 상세주소 필드로 이동한다.
       // document.pkc.jusoEtc.focus();
        data.zoncode;
        addr;
        
        location="newJuso?zip="+data.zonecode+"&addr="+addr;
        
        
    }
  }).open();
}
</script> 
 -->




</head>
<body>
<input type="button" value="소스보기" onclick="viewSrc()">
 <div id="src"></div>  
	<main>
	<form name="gform" action="gumaeOk" method="post">
		<section id="member">
			<table width="1100" align="center">
				<caption><h3>구매자 정보</h3></caption>
				<tr>
					<td>이름</td>
					<td>${mdto.name}</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>${mdto.email}</td>				
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="phone" value="${mdto.phone}" id="memberPhone">
					<input type="button" value="수정" onclick="chgPhone()"></td>
				</tr>
			</table>
		
		</section>
		
		
		<section id="baesong">
		<input type="hidden" name="baeId" value="${bdto.id}">
			<table width="1100" align="center">
				<caption><h3 align="left">
					배송지 정보
					<c:if test="${bdto!=null}">
					<input type="button" value="배송지변경" onclick="jusoChange()">
					</c:if>
					
					<c:if test="${bdto==null}">
					<input type="button" id="fbtn" value="첫 배송지 추가" onclick="jusoChuga()">
					</c:if>
					
					</h3></caption>			
				<tr>
					<td>이름</td>
					<td id="bname">${bdto.name}</td>
				</tr>
				<tr>
					<td>배송주소</td>
					<td id="bjuso">${bdto.juso} ${bdto.jusoEtc}</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td id="bphone">${bdto.phone}</td>
				</tr>
				<tr>
					<td>배송 요청 사항</td>
					<td id="breq">${bdto.breq}</td>
				</tr>
				
			</table>
		</section>
		
		
	
		<section id="product">
		<table width="1100" align="center">
		<%-- <input type="hidden" name="userid" value="${userid}"> --%>
		<caption><h3 align="left">구매상품정보</h3>
			<c:forEach items="${plist}" var="pdto">
			<input type="hidden" name="pcodes" value="${pdto.pcode}" class="pcode">
			<input type="hidden" name="sues" value="${pdto.su}" class="su">
				<tr>
					<td colspan="2" bgcolor="#eeeeee">${pdto.baeEx}</td>
				</tr>
				<tr>
					<td width="600">${pdto.title}</td>
					<td>${pdto.su}개
						<c:if test="${pdto.baeprice==0}">
							무료배송
						</c:if>
						<c:if test="${pdto.baeprice!=0}">
							<fmt:formatNumber value="${pdto.baeprice}" type="number"/>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		</section>
		<section id="price">
			<table width="1100" align="center">
				<caption><h3 align="left">결제정보</h3></caption>
				<tr>
					<td>총상품가격</td>
					<td><fmt:formatNumber value="${halinPrice}" type="number"/>
				</tr>
				<tr>
					<td>배송비</td>
					<td>
						<c:if test="${baePrice==0}">
							무료배송
						</c:if>
						<c:if test="${baePrice!=0}">
							<fmt:formatNumber value="${baePrice}" type="number"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>적립예정금액</td>
					<td><fmt:formatNumber value="${jukPrice}" type="number"/></td>
				</tr>
				<tr>
					<td>적립금</td>
					<td>
						<input type="text" name="useJuk" value="0" onfocus="init(this)" onblur="jukCal(this)" onkeyup="numCheck(this)">
						보유 : <span id="myJuk"><fmt:formatNumber value="${juk}" type="number"/></span>
					</td>
				</tr>
				<tr>
				<input type="hidden" name="chongPrice" value="${halinPrice+baePrice}" >
					<td>총결제금액</td>
					<td><span id="chong"><fmt:formatNumber value="${halinPrice+baePrice}" type="number"/></span></td>
				</tr>			
			</table>
		</section>
		
		<section id="sudan">
			<h3 align="left">결제 수단</h3>
			<div id="sudanFirst">
				<div>
					<input type="radio" name="sudan" class="sudan" value="0" checked onclick="viewSub(0)">신용/체크카드
					<div class="sub" id="fsub">
						<select name="card">
							<option value="0">선택</option>	
							<option value="1">신한카드</option>	
							<option value="2">농협카드</option>	
							<option value="3">우리카드</option>	
							<option value="4">국민카드</option>	
							<option value="6">하나카드</option>						
						</select>
						<select name="halbu">
							<option value="0">일시불</option>
							<option value="2">2개월</option>
							<option value="3">3개월</option>
							<option value="6">6개월</option>
							<option value="12">12개월</option>
						</select>
					</div>
				</div>
				<div>
					<input type="radio" name="sudan" class="sudan" onclick="viewSub(1)">쿠페이머니
					<div class="sub">
						0원
					</div>
				</div>
			</div>
			<div id="sudanSecond">
				<div>다른 결제 수단<span id="down" onclick="down()">▼</span><span id="up" onclick="up()">▲</span></div>
				<div class="subMain">
					<input type="radio" name="sudan" class="sudan"  value="1" onclick="viewSub(2)">계좌이체
					<div class="sub">
						<select name="bank">
							<option value="0">선택</option>	
							<option value="1">신한은행</option>	
							<option value="2">농협은행</option>	
							<option value="3">우리은행</option>	
							<option value="4">국민은행</option>	
							<option value="5">하나은행</option>	
						</select>
					</div>
				</div>
				<div class="subMain"><input type="radio" name="sudan" value="3" class="sudan" onclick="viewSub(3)">법인카드
					<div class="sub">
						<select name="lcard">
							<option value="0">선택</option>	
							<option value="1"> 신한카드</option>	
							<option value="2">농협카드</option>	
							<option value="3">우리카드</option>	
							<option value="4">국민카드</option>	
							<option value="5">하나카드</option>						
						</select>
					</div>
				</div>
				<div class="subMain"><input type="radio" name="sudan" value="4" class="sudan" onclick="viewSub(4)">휴대폰
					<div class="sub">
						<select name="tong">
							<option value="0">선택</option>	
							<option value="1">SKT</option>	
							<option value="2">KT</option>	
							<option value="3">LG</option>	
							<option value="4">별정통신</option>								
						</select>
					</div>
				</div>
				<div class="subMain"><input type="radio" name="sudan" value="5" class="sudan" onclick="viewSub(5)">무동장입금
					<div class="sub">
						<select name="nbank">
							<option value="0">선택</option>	
							<option value="1">신한은행</option>	
							<option value="2">농협은행</option>	
							<option value="3">우리은행</option>	
							<option value="4">국민은행</option>	
							<option value="5">하나은행</option>	
						</select>
					</div>
				</div>
			</div>
		</section>
		<section>
			<input type="submit" value="상품구매">
		</section>
	</form>	
	</main>
</body>
</html>