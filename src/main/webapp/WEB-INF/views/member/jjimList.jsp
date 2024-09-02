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
</style>
<script>
function whole(){
	
	var subchecks=document.getElementsByClassName("subCheck")
	if(document.getElementById("mainChk").checked)
    {	
		for(subcheck of subchecks)
			{
				subcheck.checked=true;
			}
    }else{
    	
    	for(subcheck of subchecks)
		{
			subcheck.checked=false;
		
		}
    }
}




function onecheck(index)
{
	
	
	
	
	var chk=0;
	
	var subchecks=document.getElementsByClassName("subCheck")
	for(var i=0; i<subchecks.length; i++)
	{
		if(subchecks[i].checked==false)
			chk=1;
	}
	
	if(chk==1){
		
		document.getElementById("mainChk").checked=false;
		
	}else{
		
		document.getElementById("mainChk").checked=true;
		
		
	}
	
	
	
}



</script>


</head>
<body>
<main>
<table width="1000" align="center">
<caption><h2>찜 리스트 현황</h2></caption>
<c:forEach items="${plist}" var="pdto" varStatus="sts">
	<tr>
		<td><input type="checkbox" class="subCheck" onclick="onecheck(${sts.index})"></td>
		<td><img src="../static/product/${pdto.pimg}" width="80" height="80"></td>
		<td>${pdto.title }</td>
		<td width="140" align="center">
		<c:if test="${pdto.baeprice==0}">
		무료배송
		</c:if>
		<c:if test="${pdto.baeprice!=0}">
			<fmt:formatNumber value="${pdto.baeprice}" type="number"/>원		
		</c:if>
		</td>
		<td width="120" align="right">
			<fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원
		</td>
		<td width="100" align="center" style="line-height:24px">
			<input type="button" value="장바구니"><br>
			<input type="button" value="삭제">
		</td>
	</tr>
</c:forEach>
	<tr>
		<td colspan="6">
			전체 선택 <input type="checkbox" id="mainChk" onclick="whole()">
		</td>
	</tr>



</table>
</main>




</body>
</html>