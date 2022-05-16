<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="filedb.css" rel="stylesheet" type="text/css">
<title>DB 출력 페이지 (페이징X)</title>
</head>
<body>
	<%@ include file = "db_conn_oracle.jsp" %>
	<%
	// 페이징 처리 없이 나열
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;						// SELECT문 결과인 레코드셋을 담는 객체
	
	try {
		sql = "SELECT * FROM guestboard2";
		st = conn.createStatement();			// Statement 객체 활성화
		rs = st.executeQuery(sql);				// ResultSet 객체에 SELECT문 결과인 레코드셋을 할당
		
		if (!(rs.next())) {						// DB에 값이 존재하지 않을때
			out.println("블로그에 올린 글이 없습니다.");
		} else {
			do {
	%>
				<table width="600" border="1">
				<tr height="25"><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2" align="center"><h3><%= rs.getString("subject") %></h3></td></tr>
				<tr>
					<td>글쓴이 : <%= rs.getString("name") %></td>
					<td>이메일 : <%= rs.getString("email") %></td>
				</tr>
				<tr><td colspan="2">작성일 : <%= rs.getString("inputdate") %></td></tr>
				<tr><td colspan="2" width="600">내용 : <%= rs.getString("content") %></td></tr>
				<tr height="25"><td colspan="2">&nbsp;</td></tr>
				</table>
	<%
			} while(rs.next());
		}
	} catch(Exception e) {
		out.println(e.getMessage());
	} finally {
		if (rs != null) {
			rs.close();
		}
		if (st != null) {
			st.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
	%>
</body>
</html>