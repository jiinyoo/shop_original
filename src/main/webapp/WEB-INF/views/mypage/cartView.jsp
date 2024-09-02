<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</style>
</head>
<body>
<main>
<c:forEach items="${clist}" var="cdto">
	<table>
		<tr>
			<td>${cdto.pcode} </td>
			<td>${cdto.su} </td>
			<td>${cdto.writeday} </td>
		<tr>
	</table>
</c:forEach>	



</main>
</body>
</html>