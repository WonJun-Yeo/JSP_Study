<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>세션 연습</h2>
<%
	String name = "RubisCo";
	
	// 다음 페이지까지 데이터값을 유지하고 싶을 때 session을 사용한다.
	// 브라우저 내에서 데이터가 계속 유지된다.
	session.setAttribute("name1", name);
	
	// 세션 유지시간
	// 10초 동안만 유지 : 쓰이지 않는 데이터를 계속 가지고 있으면 자원 소모가 일어나기 때문에 시간제한을 두는것
	session.setMaxInactiveInterval(10);
	
%>

<a href="sessionName.jsp?name">세션네임 페이지로 이동</a>
</body>
</html>