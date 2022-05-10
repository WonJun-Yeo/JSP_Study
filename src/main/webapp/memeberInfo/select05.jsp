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

<!-- SQL문을 실행시키는 객체
Statement
	- 단일로 한 번만 실행할 때 빠른 속도를 가진다.
	- 쿼리에 인자를 부여할 수 없다.
	- 따라서 변수를 적용할 때, 따옴표 처리를 잘 해주어야 한다.
	- 매번 컴파일을 수행해야 한다.
		즉, cache(메모리)를 사용하지 않는다.
PreparedStatement
	- 여러번 수행할 때 빠른 속도를 가진다.
	- 쿼리에 인자를 부여할 수 있다.
		?(물음표) 인자에 변수를 할당한다.
	- 처음 컴파일 된 후, 컴파일을 수행하지 않는다.
		즉, cache(메모리)를 사용한다.

-->


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
	
		// Statement stmt = null;								// Statement 객체는 SQL 쿼리를 담아서 실행하는 객체이다.
		PreparedStatement pstmt = null;
		
		try {
			String sql = "SELECT * FROM mbTbl";
			
			pstmt = conn.prepareStatement(sql);				// Connection 객체의 prepareStatement(객체) 함수로 preparedStatement 객체 활성화
															// createStatement와 다르게 객체를 활성화할때 sql 객체를 넣어주어햐 한다. 즉, 실행할때 sql객체를 넣지 않는다.
			rs = pstmt.executeQuery();						// pstmt.executeQuery(); : select 문이 오면서 그 결과를 Resultset 객체로 반환한다.
			
			
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
			
			if (pstmt != null) {
				pstmt.close();
			}
			
			if (conn != null) {
				conn.close();
			}
		}
	
	%>

</table>


</body>
</html>