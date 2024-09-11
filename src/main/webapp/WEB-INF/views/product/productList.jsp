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
     margin-top:20px;
     font-family:'GmarketSansLight';
     font-weight:900;
   }
 
   main #juk {
     border:1px solid #cccccc;
     padding:2px;
     padding-left:8px;
     padding-right:8px;
     border-radius:15px;
     font-size:12px;
   }
   main a {
     text-decoration:none;
     color:black;
   }
   main table {
     border-spacing:8px;
   }
   main table td {
     cursor:pointer;
     width:270px;
     height:360px;
     border:1px solid #eeeeee;
     padding:4px;
     outline:2px solid white;
   }
   main table td:last-child {
     height:60px;
   }
   main table td > div {
     width:270px;
     margin-top:5px;
   }
    main table td > div:first-child {
     text-align:center;
   }
   main table td .img_wrap {
   	 height:230px;
   	 padding:10px;
   	 box-sizing:border-box;
   }
   main table td .img_wrap img {
     max-height:100%;
     max-width:100%;
   }
   
   main table td > #ptitle {
   
   }
   main table td > #phalin {
     font-size:12px;
   }
   main table td > #phalinPrice {
     font-size:18px;
     color:#CB1400;
     font-family:'GmarketSansMedium';
   }
   main table td > #pbaeEx {
     color:green;
   }
   

   main table td:hover{
   	outline:2px solid #cccccc;   	
   }
   
   
  #lasttd:hover {
    outline: 2px solid white;  
}

main a.active {
     color: red; /* active 클래스에 붉은색을 적용 */
   }



	</style>
</head>
<body> <!-- product/productList.jsp -->
  <main>
  <table width="1100" align="center">
    <h4 align="left" style="letter-spacing:2px;font-size:13px;float:left;"> ${pos} </h4> 
    <h4 style="float:right;font-size:13px;">
        <span class="links">
            <a href="productList?pcode=${pcode}&order=1&page=${page}" 
               class="${param.order == '1' ? 'active' : ''}">판매량순</a> |
        </span>
        <span class="links">
            <a href="productList?pcode=${pcode}&order=2&page=${page}" 
               class="${param.order == '2' ? 'active' : ''}">가격높은순</a> | 
        </span>
        <span class="links">
            <a href="productList?pcode=${pcode}&order=3&page=${page}" 
               class="${param.order == '3' ? 'active' : ''}">가격낮은순</a> | 
        </span>
        <span class="links">
            <a href="productList?pcode=${pcode}&order=4&page=${page}" 
               class="${param.order == '4' ? 'active' : ''}">별점순</a> | 
        </span>
        <span class="links">
            <a href="productList?pcode=${pcode}&order=5&page=${page}" 
               class="${param.order == '5' ? 'active' : ''}">최신상품순</a>
        </span>
    </h4>
    <tr>
    <c:forEach items="${plist}" var="pdto" varStatus="sts" >
	      <td onclick="location='productContent?pcode=${pdto.pcode}'" valign="top">
    			<div class="img_wrap" style="text-align: center;">
        				<img src="../static/product/${pdto.pimg}" >
   				</div>
	      	<div id="ptitle">${pdto.title}</div>
	      	<c:if test="${pdto.halin!=0}">
	      		<div><span id="phalin">${pdto.halin}%</span> <s> <fmt:formatNumber value="${pdto.price}" type="number"/>원  </s></div>
	      	</c:if>
	      	<div id="phalinPrice"><fmt:formatNumber value="${pdto.halinPrice}" type="number"/>원 </div>
	      	<div></div>
	      	<div id="pbaeEx"> ${pdto.baeEx} </div>       
	      	<div>
					<c:forEach begin="1" end="${pdto.ystar}">
						<img src="../static/pro/star1.png" width="10">
					</c:forEach>
					<c:if test="${pdto.hstar==1}">
						<img src="../static/pro/star3.png" width="10">
					</c:if>
					<c:forEach begin="1" end="${pdto.gstar}">
						<img src="../static/pro/star2.png" width="10">
					</c:forEach>      	
	      	</div>
	      	<c:if test="${pdto.juk!=0}">
	      		<div>
	      			<span id="juk"> 최대 <img src="../static/pro/juk.png" width="10">
	      				<fmt:formatNumber value="${pdto.jukPrice}" type="number"/>원 적립
	      			</span>
	      		</div>
	      	</c:if>
	      </td>
	      <c:if test="${sts.count%4==0}">
    		</tr><tr>
    	  </c:if> 
    </c:forEach>
    </tr>
    <tr>
      <td colspan="4" align="center" id="lasttd">
        <c:forEach begin="${pstart}" end="${pend}" var="i">
            <a href="productList?pcode=${pcode}&order=${param.order}&page=${i}">${i}</a>&nbsp;
        </c:forEach>
    </td>
    </tr>
  </table>
  </main>
</body>
</html>