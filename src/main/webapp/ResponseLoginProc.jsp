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
	request.setCharacterEncoding("UTF-8");
	
	// 임의적으로 DB의 id와 pass를 설정 (DB에서 가져왔다 가정)
	String dbid = "aaaa";
	String dbpass = "1234";
	
	// 사용자로부터 넘어온 데이터를 입력받아 변수에 저장
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	if (dbid.equals(id) && dbpass.equals(pass)) {
		// 아이디와 패스워드가 일치하므로 메인 페이지를 보여주어야함
			// 데이터를 넘기는 법
		response.sendRedirect("ResponseMain.jsp?id=" + id);
	} else {
	%>
		alert("id와 패스워드가 일치하지 않습니다.");
		history.go(-1);
	<%
	}
	
	
	%>
	
	
</body>
</html>