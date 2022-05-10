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
	request.setCharacterEncoding("UTF-8");					// 폼에서 넘긴 한글처리하기 위함
	
	// form에서 넘긴 name값을 받아오는 request.getParameter
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	PreparedStatement pstmt = null;
	
	try {
		String sql = "INSERT INTO mbTbl(idx, id, pass, name, email) VALUES (seq_mbTbl_idx.nextval, ?, ?, ?, ?)";						// 문자열은 따옴표처리를 쥬의해야한다.
		
		pstmt = conn.prepareStatement(sql);					// Preparedstatement는 객체 활성화시에 sql변수를 넣는다.
		
		// ? 인자에 값을 받을 변수 할당
		pstmt.setString(1, id);
		pstmt.setString(2, passwd);
		pstmt.setString(3, name);
		pstmt.setString(4, email);
		
		pstmt.executeUpdate();						// PreparedStatement 객체의 executeUpdate() 함수를 통해 sql을 실행한다. sql 변수를 넣지 않는다.
		
		/* SQL 실행법 2가지
			stmt.executeUpdate(sql); : DML(insert, update, delete) 구문이 온다.
			stmt.executeQuery(sql); : select 문이 오면서 그 결과를 Resultset 객체로 반환한다.
		*/
		
		// JSP 블락에서 출력할때 out.println();
		out.println("mbTbl 테이블에 정상적으로 삽입되었습니다.");
		
		// sql 찍어서 SQL문을 확인해보는 것이 좋다.
		//out.println("<br/>");
		//out.println(sql);
	} catch (Exception e) {
		out.println("mbTbl 테이블에 삽입을 실패했습니다.");
		out.println(e.getMessage());
	} finally {											// 사용한 객체는 모두 종료해주어야 한다.
		if (pstmt != null) {								// stmt 객체 종료 선언
			pstmt.close();
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
	
	<!-- HTML 블락에서 출력할때 -->
	<%= id %> <br/>
	<%= passwd %> <br/>
	<%= name %> <br/>
	<%= email %>
	
</body>
</html>