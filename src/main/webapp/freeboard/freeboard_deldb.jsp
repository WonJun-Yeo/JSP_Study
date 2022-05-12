<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "dbconn_oracle.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href = "filegb.css" rel = "stylesheet" type = "text/css">
<title>실제 데이터 베이스 삭제</title>
</head>
<body>
	<a href = "freeboard_list.jsp?go=<%= request.getParameter("page") %>">게시판 목록으로 이동</a>
	<%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int cnt = 0;
	
	int id = Integer.parseInt(request.getParameter("id"));
	
	try {
		sql = "SELECT * FROM freeboard WHERE id = ?";				// 넘겨받은 id로 DB 레코드 검색
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery();
		
		if (!(rs.next())) {
			out.println("해당 내용은 존재하지 않습니다.");
		} else {
			// DB에서 가져온 password 컬럼값과 넘겨받은 password값이 일치하면 해당 레코드 삭제
			String pwd = rs.getString("password");					// DB에서 가져온 password 컬럼 값
			if (pwd.equals(request.getParameter("password"))) {
				sql = "DELETE freeboard WHERE id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				cnt = pstmt.executeUpdate();
				
				if (cnt > 0) {
					out.println("해당 내용은 잘 삭제되었습니다.");
				} else {
					out.println("해당 내용은 삭제되지 않았습니다.");
				}
			} else {
				out.println("비밀번호가 일치하지 않습니다.");
			}
		}
		
	} catch(Exception e) {
		out.println(e.getMessage());
	} finally {
		if (rs != null) {
			rs.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
	%>
</body>
</html>