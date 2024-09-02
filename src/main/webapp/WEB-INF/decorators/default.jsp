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
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
	}
	ul {list-style:none;}
	body{
		margin:0px;
		font-family: 'Pretendard-Regular',"Noto Sans KR","Malgun Gothic","맑은 고딕",helvetica,"Apple SD Gothic Neo",sans-serif;
	}

	#ads{
		width:100%;
		height:40px;
		background:purple;
	}
	
	
	#ads #first{
		position:relative;
		width:1100px;
		height:40px;
		margin:auto;
		
	}
	
	
	#ads #first #left{
	 height:40px;
	 line-height:40px;
	 text-align:center;
	 color:white;
	
    
	}
	
	#ads #first #right{
	 width:100px;
	 height:40px;
	 line-height:40px;
	 position:absolute;
	 top:0;
	 right:0;
	 text-align:right;
	 color:white;
	}
	
	
	header{
		width:1100px;
		height:70px;
		line-height:70px;
		margin:auto;
	}
	
	
	header #logo{
		width:300px;
		height:70px;
		line-height:70px;
		background:white;
		float:left;
	}
	
	
	header #search{
		width:420px;
		height:70px;
		float:left;
		margin:auto;
	}
	
	header #member{
		width:380px;
		height:70px;
		line-height:70px;
		background:white;
		float:right;
		text-align:right;
	}
	
	header #member #myMenu{
	
		position:relative;
		display:inline-block;
		
		
	
	}
	
	header #member #myMenuList{
		padding-left:0px;
		position:absolute;
		left:-20px;
		top:45px;
		visibility:hidden;
		border:1px solid purple;
		background:white;
	}
	
	header #member #myMenuList li{
		list-style-type:none;
		height:28px;
		line-height:28px;
		width:100px;
		text-align:center;
		
	}
	
	
	
	
	
	header #search #searchForm
	{
		width:300px;
		height:40px;
		line-height:40px;
		border:1px solid purple;
		margin:auto;
		margin-top:15px;
		border-radius:5px;
	
	}
	
	
	header #search #searchForm #searchTxt
	{
		width:220px;
		margin-left:14px;
		border:none;
		outline:none;
	
	}
	
	header #search #searchForm  #xx
	{
		visibility:hidden;
		cursor:pointer;
	
	}
	
	
	nav, ul, li, span {
    padding: 0;
    margin: 0;
	}
	
	
	
	
	
	
	
	
	nav{
	 width:1100px;
	 height: 50px;
     line-height: 50px; /* line-height와 height가 일치하는지 확인 */
     text-align: center;
     vertical-align: middle; /* vertical-align 사용하여 정렬 문제 해결 */
     margin:auto;
	}
	
	
	nav > #mainmenu {
	
		padding-left:0px;
		display: flex;
    	justify-content: space-between;
    	margin:0;
    	padding:0;
		
	}
	
	nav > #mainmenu > li{
		list-style-type:none;
		display:inline-block;
		width:160px;
		height:50px;
		line-height:50px;
		text-align:center;
		padding:0;
		margin:0;
	}
	
	
	nav > #mainmenu > li:first-child{
		width:230px;
		text-align:left;
		margin-left:30px;
		padding:0;
		margin:0;
	}
	

	nav > #mainmenu  #cate{
		/*주메뉴*/
		position:relative;
		display:inline-block;
		background:white;
		padding:0;
		margin:0;
		
		
	}
	
	nav > #mainmenu #cate #daeMenu{
		position:absolute;
		border:1px solid purple;
		background:white;
		padding:0;
		margin:0;
		
	}
	
	nav #daeMenu > li {   /* 대분류 메뉴 */
	      list-style-type:none;
	      width:100px;
	      height:30px;
	      line-height:30px;
	      text-align:center;
	      background:white;
	      cursor:pointer;
	      position:relative;
   }
   
   
   	
	 nav #daeMenu > li .jungMenu:empty {
   			 border: none;
	}
   
   
  	 nav #daeMenu > li > .jungMenu { /* 중분류메뉴의 UL태그 */
	      position:absolute;
	      left:100px;
	      top:-1px;
	      padding-left:0px;
	      background:white;
	      border:1px solid purple;   
  	 }
   	nav #daeMenu > li .jungMenu > li {
   		 list-style-type:none;
     	 width:100px;
      	 height:30px;
      	 position:relative;
   	}
   	
   	nav #daeMenu > li .jungMenu > li > .soMenu {
   		position:absolute;
   		left:100px;
   		top:-1px;
   		padding-left:0px;
   		background:white;
   		border:1px solid purple;
   	}
   	
	nav #daeMenu > li .jungMenu > li > .soMenu > li{
		list-stye-type:none;
		width:100px;
		height:30px;
	}
	
	footer{
		width:1100px;
		height:150px;
		margin:auto;
		background:black;
	}

	


</style>
<script>
function xCheck(val)
{
	
	if(val.length==0)
	{
		document.getElementById("xx").style.visibility="hidden";
	}else
	{
		document.getElementById("xx").style.visibility="visible";
		
	}	
	
}


function clearTxt()
{
	document.getElementById("searchTxt").value="";	
	xCheck("");
}


//dae테이블에서 대분류 메뉴 읽어오기
var mchk=0;
//ajax로 계속 호출 하는 거
function viewMenu()
{
	
	document.getElementById("daeMenu").style.display="block";
	
	if(mchk==0)
	{
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			
			var daeAll=JSON.parse(chk.responseText);
			var str="";
			for(dae of daeAll)
				{
					var pcode="p"+dae.code;
					str=str+"<li onmouseover='jungView("+dae.code+")' onmouseout='jungHide("+dae.code+")'> <a href='../product/productList?pcode="+pcode+"'> "+dae.name+" </a> <ul class='jungMenu'> </ul> </li>";
					//받을 때 문자가 아니어서 1,2,3,4,5,6,7,8,9로 받는다.
					
				}
			
				document.getElementById("daeMenu").innerHTML=str;
			
		}
		chk.open("get","../main/getDae");
		chk.send();
		mchk++;
	}
}

function hideMenu()
{
		document.getElementById("daeMenu").style.display="none";
	
}


//마우스가 올라가면 계속 아작스가 실행되므로 메뉴들이 계속 떨리거나 실행되는 현상이 생기지 않음.
//var jungEx=[0,0,0,0,0,0,0]

var jungEx=new Array(100);
jungEx.fill(0);



function jungView(daecode)
{
	
	document.getElementsByClassName("jungMenu")[daecode-1].style.display="block";
	if(jungEx[daecode-1]==0)//읽어오지 않은 중분류
	{
	//중분류의 레코드들을 가져와서 중분류의 메뉴를 출력
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			
			var jungAll=JSON.parse(chk.responseText);
			var str="";
			var i=0;
			for(jung of jungAll)
				{
					var pcode="p"+jung.daecode+jung.code;
				 	str=str+"<li onmouseover='soView(this,"+(daecode+""+jung.code)+","+i+")' onmouseout='soHide("+i+")'><a href='../product/productList?pcode="+pcode+"'>"+jung.name+"</a><ul class='soMenu'></ul></li>";				
					i++;
				}
			
			//dae코드의 index를 jungmenuclass의 -1로 인덱스로 활용
			document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
		}
		chk.open("get","../main/getJung?daecode="+daecode)
		chk.send();
	}
	jungEx[daecode-1]=1;
	
}

function jungHide(daecode)
{
	document.getElementsByClassName("jungMenu")[daecode-1].style.display="none";
}


var soEx=new Array(100);
soEx.fill(0);

function soView(my,daejung,i)
{
	//document.getElementsByClassName("soMenu")[i].style.display="block";
	
	my.childNodes[1].style.display="block";
	//if(soEx[i]==0)
	 if(my.childNodes[1].innerHTML=="")	
	{
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			var soAll=JSON.parse(chk.responseText);
			var str="";
			
			for(so of soAll)
				{
					var pcode="p"+so.daejung+so.code;
					str=str+"<li><a href='../product/productList?pcode="+pcode+"'>"+so.name +"</a></li>";
				}
			//document.getElementsByClassName("soMenu")[i].innerHTML=str;
			 my.childNodes[1].innerHTML=str;
		}
		//처음에 main안 붙여서 에러났었음
		chk.open("get","../main/getSo?daejung="+daejung);
		chk.send();
		
	
	}
	//soEx[i]=1;
}


function soHide(i)
{
	
	 for(i=0;i<document.getElementsByClassName("soMenu").length;i++)
	      document.getElementsByClassName("soMenu")[i].style.display="none";
	
}





function viewSrc()
{
	document.getElementById("aa").innerText=document.getElementsByTagName("body")[0].innerHTML;
}




window.onload=function()
{
	var chk=new XMLHttpRequest();
	chk.onload=function()
	{
		
		document.getElementById("cartNum").innerText=chk.responseText;
	}
	chk.open("get","../main/cartNum"); //상대경로로 가져오면 안되고 
	chk.send();
}


function myMenuView()
{
	
	document.getElementById("myMenuList").style.visibility="visible";
	
}

function myMenuHide()
{
	
	document.getElementById("myMenuList").style.visibility="hidden";
	
}








</script>



<sitemesh:write property="head"/>



</head>
<body>

<div id="aa"></div>
	<div id="ads">
		<div id="first">
			<div id="left">회원가입하고 상품 첫 주문시 100만원 드립니다.</div>
			<div id="right">x</div>
		</div>
	</div>
	<header><!-- 로고,상품검색 회원가입 로그인 등등 -->
		<div id="logo">로고</div>
		<div id="search">
			<div id="searchForm">
				<input type="text" name="search" id="searchTxt" onkeyup="xCheck(this.value)" placeholder="검색어를 입력하세요">
				<img src="../static/main/x.png" valign="middle" id="xx" onclick="clearTxt()">
				<img src="../static/main/s.png" valign="middle">
			</div>
		</div>
		<div id="member">
		<a href="../member/cartView">
			<img src="../static/main/cart.png" valign="middle" width="20">(<span id="cartNum"></span>)|
		</a>
			<c:if test="${userid==null}">
			<a href="../member/member">회원가입</a> |
			<a href="../login/login">로그인</a> 			
			</c:if>
			<c:if test="${userid!=null}">
				${name}님|
				<span id="myMenu" onmouseover="myMenuView()" onmouseout="myMenuHide()">나의 메뉴|
					<ul id="myMenuList">
						<li><a href="/member/jjimList">찜리스트</a></li>
						<li>회원정보</li>
						<li>주문목록</li>
						<li>배송지관리</li>			
						<li>나의 상품평</li>
						<li>나의 문의</li>		
					</ul>
				</span>
				<a href="../login/logout">로그 아웃</a>
			</c:if>

			| 고객센터		
			
			
		</div>
	</header>
	<nav>	
		<ul id="mainmenu">
			<li>
			
			
				<span id="cate" onmouseover="viewMenu()" onmouseout="hideMenu()">
				<img src="../static/main/3.png" valign="middle">카테고리
				<!-- 부를 안에 넣는다. -->
				
				<ul id="daeMenu">
							
				</ul>
			</span>
			
			
			
			
			</li>
			<li>신상품</li>
			<li>특가상품</li>
			<li>베스트</li>
			<li>이벤트</li>
			<li>일일특가</li>
		</ul>
	</nav>
		
	<sitemesh:write property="body"/>
	

	

	<footer></footer><!-- 쇼핑몰 관련 정보 -->
	
	
</body>
</html>