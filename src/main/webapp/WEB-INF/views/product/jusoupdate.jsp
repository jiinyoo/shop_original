<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	//opener.location.reload();
	
	opener.document.getElementById("bname").innerText="${bname}";
	opener.document.getElementById("bjuso").innerText="${bjuso}";
	opener.document.getElementById("bphone").innerText="${bphone}";
	opener.document.getElementById("breq").innerText="${breq}";
	
	window.onload = function() {
	    location.href = "jusoList";
	};
</script>

</head>
<body>

</body>
</html>