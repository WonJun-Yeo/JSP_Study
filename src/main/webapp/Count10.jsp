<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 1-10까지의 숫자를 화면에 출력하시오
	for (int i = 1; i <= 10; i++) {
		// 콘솔에 출력
		System.out.println(i);
	%>
	
		<!-- 브라우저에 출력 -->
		<%= i %><br/>
			
	<%	
	}
	%>
	
</body>
</html>