<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	body{
		margin:0px;
		font-family: 'Pretendard-Regular',"Noto Sans KR","Malgun Gothic","맑은 고딕",helvetica,"Apple SD Gothic Neo",sans-serif;
	}


	
	article{
	 width:1500px;
	 height:300px;
	 margin:auto;
	 background:pink;
	 overflow:hidden;
	
	}
	
	
	article #inner{
	
	  width:10000px;
	}
	
	main{
		width:1100px;
		margin:auto;
	}
	
	main #p1{
		
		width:1100px;
		height:400px;
		margin:auto;
		background:#abcdef;
	
	}
	
	main #p2{
		
		width:1100px;
		height:400px;
		margin:auto;
		background:#abcd12;
	
	}
		main #p3{
		
		width:1100px;
		height:400px;
		margin:auto;
		background:#ab18ef;
	}
	 main #p4{
		
		width:1100px;
		height:400px;
		margin:auto;
		background:#20cdef;
	}


</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
//document.ready jquery 
$(function()
		   {
			    setInterval(function()
			    {
			    	 $("#inner").animate(
			    	 {
			    		 marginLeft:"-1500px"
			    	 },2000,function()
			    	        {
			    		        $("#inner").css("margin-left","0px");
			    		        $(".mimg").eq(0).insertAfter($(".mimg").eq(5));
			    	        });
			    },4000);
		   });
</script>
</head>
<body>
	
	
	<article id="outer">
		<div id="inner"><img class="mimg" src="../static/main/s2.png" width="1500" height="300"><img class="mimg" src="../static/main/s3.png" width="1500" height="300"><img class="mimg" src="../static/main/s4.png" width="1500" height="300"><img class="mimg" src="../static/main/s5.png" width="1500" height="300"><img class="mimg" src="../static/main/s6.png" width="1500" height="300"><img class="mimg" src="../static/main/s7.png" width="1500" height="300">
				
		</div>
	
	</article>
	
	
	<main><!-- 전체 내용 -->
		
		<section id="p1"></section>
		<section id="p2"></section>
		<section id="p3"></section>
		<section id="p4"></section>
		
	</main>
	
	
	
</body>
</html>