<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:forEach items="${blist}" var="bdto">
	<div class="baeJuso"> </div>
	<div>${bdto.name}</div>
	<div>${bdto.juso} ${bdto.jusoEtc}</div>
	<div>${bdto.phone}</div>
</c:forEach>
<div> <input type="button" value="배송지 추가" onclick="location='jusoWrite?tt=1'"></div>


</body>
</html>