<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB의 내용을 가져와서 출력하기</title>
</head>
<body>


<%@ include file = "dbconn_oracle.jsp"%>

<table width = "500" border = "1">
	<tr>
		<th>아이디</th>
		<th>이름</th>
		<th>비밀번호</th>
		<th>email</th>
		<th>city</th>
		<th>phone</th>
	</tr>

	<%
		ResultSet rs = null;								// ResultSet 객체는 DB의 테이블을 Select문으로 read한 결과, 즉 레코드셋을 담는 객체
	
		Statement stmt = null;								// Statement 객체는 SQL 쿼리를 담아서 실행하는 객체이다.
	
		try {
			String sql = "SELECT * FROM mbTbl";
			
			stmt = conn.createStatement();					// Connection 객체의 createStatement() 함수로 Statement 객체 활성화
			
			rs = stmt.executeQuery(sql);					// stmt.executeQuery(sql); : select 문이 오면서 그 결과를 Resultset 객체로 반환한다.
			
			
			while (rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String pass = rs.getString("pass");
				String email = rs.getString("email");
				String city = rs.getString("city");
				String phone = rs.getString("phone");
				
			%>
			
			<tr>
				<td><%= id %></td>
				<td><%= name %></td>
				<td><%= pass %></td>
				<td><%= email %></td>
				<td><%= city %></td>
				<td><%= phone %></td>
			</tr>
			
			<%
				
			}
			
			
			
		} catch (Exception e) {
			out.println("테이블 호출을 실패하였습니다.");
			out.println(e.getMessage());
		} finally {
			if (rs != null) {
				rs.close();
			}
			
			if (stmt != null) {
				rs.close();
			}
			
			if (conn != null) {
				conn.close();
			}
		}
	
	%>

</table>


</body>
</html>