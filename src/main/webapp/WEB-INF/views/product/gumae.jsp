<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function jusoChuga()
{
	open("jusoWrite","","width=400,height=500");	
	
}

function jusoChange()
{
	
	open("jusoList","","width=450,height=500");	
	
}







</script>


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
	<main>
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
					<td><input type="text" name="phone" value="${mdto.phone}">
					<input type="button" value="수정"></td>
				</tr>
			</table>
		
		</section>
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
		<section id="baesong">
		
		
		</section>
		<section id="product">
		
		
		</section>
		<section id="price">
		
		
		</section>
		<section id="sudan">
		
		
		</section>
		
		
		
	</main>
</body>
</html>