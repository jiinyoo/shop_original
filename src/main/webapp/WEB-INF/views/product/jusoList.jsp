<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
  .baeJuso {
     width:420px;
     height:130px;
     margin:auto;
     border:1px solid purple;
     margin-top:5px;
     padding:4px;
     font-family: 'GmarketSansMedium';
   }
   .baeJuso > div {
     margin-top:4px;
   }
   input[type=button] {
     width:430px;
     height:36px;
     background:purple;
     border:1px solid purple;
     color:white;
     font-family: 'GmarketSansMedium';
   }
   #submit {
     text-align:center;
     margin-top:5px;
   }
   #gibon {
     border:1px solid purple;
     padding:1px 4px;
     font-size:12px;
     border-radius:10px;
   }
   button {
     width:100px;
     height:26px;
     background:white;
     border:1px solid purple;
     color:purple;
     font-family: 'GmarketSansMedium';
   }
</style>
<script>
function transJuso(n){
	opener.document.getElementById("bname").innerText=document.getElementsByClassName("bname")[n].innerText;
	opener.document.getElementById("bjuso").innerText=document.getElementsByClassName("bjuso")[n].innerText;
	opener.document.getElementById("bphone").innerText=document.getElementsByClassName("bphone")[n].innerText;
	opener.document.getElementById("breq").innerText=document.getElementsByClassName("breq")[n].innerText;
	
	close();
}

</script>
</head>
<body>
	<c:forEach items="${blist}" var="bdto" varStatus="sts">
		<div class="baeJuso">
		<c:if test="${bdto.gibon==1}" >
			<div><span id="gibon">기본배송지</span></div>
		</c:if>
		<div class="bname">${bdto.name}</div>
		<div class="bjuso">${bdto.juso} ${bdto.jusoEtc}</div>
		<div class="bphone">${bdto.phone}</div>
		<div>
			<div style="float:left" class="breq">${bdto.breq}</div>
			<div style="flost:right">&nbsp;
			
			<button type="button" onclick="location='jusoUpdate?id=${bdto.id}'" >수정</button>
			<button type="button" onclick="location='jusoDel?id=${bdto.id}'">삭제</button>
			<button type="button" onclick="transJuso(${sts.index})">선택</button>
			</div>
		</div>
 	</div>
	</c:forEach>
	<div> <input type="button" value="배송지 추가" id="submit" onclick="location='jusoWrite?tt=1'"></div>
</body>
</html>