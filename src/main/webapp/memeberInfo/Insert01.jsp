<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method = "post" action = "insert01_process.jsp">
		<p> 아이디 : <input type = "text" name = "id"></p>
		<p> 패스워드 : <input type = "password" name = "passwd"></p>
		<p> 이름 : <input type = "text" name = "name"></p>
		<p> 이메일 : <input type = "text" name = "email"></p>
		<p> <input type = "submit" values = "전송"></p>
	</form>
</body>
</html>

<!-- 2가지 전송방식

	1. method = "POST"
		http 헤더 앞에 값을 넣어 전송
		전송 용량에 제한이 없다.
		보안이 강하다.
		주로 파일 전송 시에 사용
		
		
	2. method = "GET"
		http 헤더 뒤에 값을 붙여서 전송
		전송 용량에 제한이 있다.
		보안이 취약하다.
		게시판에서 사용

-->