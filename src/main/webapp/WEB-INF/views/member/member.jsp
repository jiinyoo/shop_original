<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  main {
     width:1100px;
     height:700px;
     margin:auto;
     text-align:center;
   }
   main div {
     margin-top:20px;
   }
   main #txt {
     width:400px;
     height:40px;
     outline:none;
     border:1px solid purple;
   }
   main #submit {
     width:406px;
     height:44px;
     outline:none;
     border:1px solid purple;
     background:purple;
     color:white;
   }
   main #txt2 {
     width:126px;
     height:40px;
     outline:none;
     border:1px solid purple;
   }
   main select {
     width:107px;
     height:44px;
     border:1px solid purple;
   }
   
   
   
   
</style>
<script>
var uchk=0;
function useridCheck(userid)
{
	if(userid.trim().length>=6)
	{
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			if(chk.responseText=="0")
				{
					document.getElementById("umsg").innerText="사용가능한 아이디입니다.";
					document.getElementById("umsg").style.fontSize="11px";
					document.getElementById("umsg").style.color="blue";
					uchk=1;
				}
			else
				{
					document.getElementById("umsg").innerText="사용불가능한 아이디입니다.";
					uchk=0;
				}
		}
		chk.open("get","useridCheck?userid="+userid);
		chk.send();
		
	}else
	{
		document.getElementById("umsg").innerText="아이디를 다시 입력하고 체크하세요";
		uchk=0;
	}
	
}


function check()
{
	
	var email=document.mform.e1.value+"@"+document.mform.e2.value;
	document.mform.email.value=email;
	
	if(uchk==0)
		{
		 	return false;
		}
	else{
			return true;
		}
	
}



function chgServer(server)
{
	
	document.mform.e2.value=server;	
	
}

</script>
</head>
<body>
	<main>
	<form name="mform" method="post" action="memberOk" onsubmit="return check()">
    <h3 align="center"> 회원 등록 </h3>
    <input type="hidden" name="email">
     <div> <input type="text" name="userid" id="txt" placeholder="아 이 디" onblur="useridCheck(this.value)"> 
     <br><span id="umsg"></span>
     
     </div>
     <div> <input type="text" name="name" id="txt" placeholder="이 름"> </div>
     <div> <input type="password" name="pwd" id="txt" placeholder="비밀번호"> </div>
     <div> <input type="password" name="pwd2" id="txt" placeholder="비밀번호 확인"> </div>
     <div>
       <input type="text" name="e1" id="txt2" placeholder="이메일아이디"> 
       <input type="text" name="e2" id="txt2" placeholder="이메일서버">
       <select id="txt2" onchange="chgServer(this.value)">
         <option value=""> 직접입력 </option>
         <option value="naver.com"> 네이버 </option>
         <option value="daum.net"> 다음 </option>
         <option value="google.com"> 구글 </option>
         <option value="hotmail.com"> 핫메일 </option>
         <option value="channy.co.kr"> 차니 </option>
       </select>
     </div>
     <div> <input type="text" name="phone" id="txt" placeholder="전화번호"> </div>
     <div> <input type="submit" value="회원 등록" id="submit"> </div>
	</form>
	</main>
</body>
</html>