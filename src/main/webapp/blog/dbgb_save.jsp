<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!-- form에서 넘겨주는 한글 처리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form에서 넘겨 받은 값을 DB에 insert하는 페이지</title>
</head>
<body>
<!-- Connection 객체 : commit이 자동으로 내장되어 있음-->
<%@ include file = "db_conn_oracle.jsp" %>
<%
String na = request.getParameter("name");
String em = request.getParameter("email");
String sub = request.getParameter("subject");
String cont = request.getParameter("content");
// 오늘 날짜를 저장, 현재 시스템의 Locale = 한국
String ymd = (new java.util.Date()).toLocaleString();

/* 폼에서 넘긴 변수가 잘 넘어오는지 확인
out.println(na + "<br>");
out.println(em + "<br>");
out.println(sub + "<br>");
out.println(cont + "<br>");
out.println(ymd);
*/

String sql = null;
Statement st = null;
// 값이 잘 입력되었는지 확인하는 변수
// 정상적으로 record를 처리했다면 0이 아니라 처리 레코드 수로 바뀔 것
int cnt = 0;

try {
	sql = "INSERT INTO guestboard2 (name, email, inputdate, subject, content) ";
	sql = sql + "VALUES ('" + na + "', '" + em + "', '" + ymd + "', '" + sub + "', '" + cont + "')";
	
	st = conn.createStatement();				// Statement 객체 활성화 (XE, "hr2", "1234")
	cnt = st.executeUpdate(sql);				// Statement 객체 실행 (insert, update, delete문), 반환값 : 처리레코드의 수
	
	/*
	if (cnt > 0) {
		out.println("DB에 값이 입력되었습니다.");
	} else {
		out.println("값 입력에 실패하였습니다.");
	}
	*/
	
} catch(Exception e) {
	out.println(e.getMessage());
} finally {
	if (st != null) {
		st.close();
	}
	if (conn != null) {
		conn.close();
	}
}

%>
<jsp:forward page = "dbgb_show.jsp" />
</body>
</html>