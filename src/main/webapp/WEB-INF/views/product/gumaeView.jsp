<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<main>
	<div id="product">
		<table width="900" align="center">
			<caption><h3>상품 정보</h3></caption>
			<c:forEach items="${mapAll}" var="map">
			 <td> <img src="../static/product/${map.pimg}" width="90" height="90"> </td>
        	  <td> ${map.title} </td>
         	 <td> <fmt:formatNumber value="${map.price}" type="number"/> </td>
          	<td> ${map.baeEx} </td>
          	<td> 수량 : ${map.su}개 </td>
			</tr>
			</c:forEach>
			
		</table>
	</div>
	<div id="baesong">
		<table width="900" align="center">
			<caption><h3>배송지 정보</h3></caption>
				<tr>
	          <td> 받는 사람 </td>
	          <td>${mapAll.get(0).name} </td>
	        </tr>
	        <tr>
	          <td> 배송 주소 </td>
	          <td> ${mapAll.get(0).juso}</td>
	        </tr>
	        <tr>
	          <td> 요청 사항 </td>
	          <td> ${breq} </td>
	        </tr>
		</table>
	</div>
	<div id="pay">
		<table width="900" align="center">
			<caption><h3>결제 정보</h3></caption>
			<tr>
	          <td> 주문금액 </td>
	          <td> <fmt:formatNumber value="${halinPrice}" type="number"/>원 </td>
	        </tr>
	        <tr>
	          <td> 배송비 </td>
	          <td> <fmt:formatNumber value="${cBaeprice}" type="number"/>원 </td>
	        </tr>
	        <tr>
	          <td> 사용적립금 </td>
	          <td> <fmt:formatNumber value="${mapAll.get(0).useJuk}" type="number"/>원</td>
	        </tr>
	        <tr>
	          <td> 총결제금액 </td>
	          <td> <fmt:formatNumber value="${halinPrice+cBaeprice}" type="number"/>원 </td>
	        </tr>
		</table>
	</div>
</main>
</body>
</html>