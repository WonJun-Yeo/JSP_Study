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
String name = "안녕하세요";
%>

<!-- 스크립트릿 표현식으로 화면에 출력 -->
<%= name %>

<br>

<%
// out 객체를 이용해 화면에 출력
out.println(name);
%>

</body>
</html>