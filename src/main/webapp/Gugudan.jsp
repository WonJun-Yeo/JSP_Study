<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 화면에 구구단을 출력 -->
	<%
	for(int i = 1; i < 10; i++) {
		for (int j = 1; j < 10; j++) {
			// 콘솔에 출력
			System.out.println(i + " * " + j + " = " + i*j);
			// 브라우저에 출력
			out.write(i + " * " + j + " = " + i*j);
	%>
		<!-- 브라우저에 출력 -->
		<%= i + " * " + j + " = " + i*j %><br/>
	
	<%	
		}
	}
	
	%>
</body>
</html>