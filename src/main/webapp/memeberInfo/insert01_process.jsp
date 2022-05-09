<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폼에서 넘겨받은 값을 DB에 저장하는 파일</title>
</head>
<body>
	<%@ include file = "dbconn_oracle.jsp"%>
	
	
	<%
	request.setCharacterEncoding("UTF-8");				// 폼에서 넘긴 한글처리하기 위함
	
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	Statement stmt = null;								// Statement 객체 : SQL 쿼리 구문을 담아서 실행하는 객체
	
	try {
		String sql = "INSERT INTO mbTbl(idx, id, pass, name, email) VALUES (seq_mbTbl_idx.nextval, '" + id + "', '" + passwd  + "', '" + name + "',  '" + email + "')";						// 문자열은 따옴표처리를 쥬의해야한다.
		
		stmt = conn.createStatement();					// connection 객체를 통해서 statement 객체 활성화
		stmt.executeUpdate(sql);						// statement 객체의 executeUpdate() 함수를  통해 sql을 실행한다.
		
		/* SQL 실행법 2가지
			stmt.executeUpdate(sql); : DML(insert, update, delete) 구문이 온다.
			stmt.executeQuery(sql); : select 문이 오면서 그 결과를 Resultset 객체로 반환한다.
		*/
		
		out.println("mbTbl 테이블에 정상적으로 삽입되었습니다.");
	} catch (Exception e) {
		out.println("mbTbl 테이블에 삽입을 실패했습니다.");
		out.println(e.getMessage());
	} finally {
		if (stmt != null) {								// stmt 객체 종료 선언
			stmt.close();
		}
		if (conn != null) {								// conn 객체 종료 선언
			conn.close();
		}
	}
	
	
	
	%>
	<br/>
	<br/>
	<br/>
	<br/>
	
	<%= id %> <br/>
	<%= passwd %> <br/>
	<%= name %> <br/>
	<%= email %>
	
</body>
</html>