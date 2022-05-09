<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file = "dbconn_oracle.jsp"%>
	
	
	<%
	request.setCharacterEncoding("UTF-8");			
	
	String eno = request.getParameter("eno");
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	String manager = request.getParameter("manager");
	String hiredate = request.getParameter("hiredate");
	String salary = request.getParameter("salary");
	String commission = request.getParameter("commission");
	String dno = request.getParameter("dno");
	
	
	Statement stmt = null;							
	
	try {
		String sql = "INSERT INTO emp_copy VALUES (" + eno + ", '" + ename + "', '" + job + "', '" + manager + "', '" + hiredate + "', " + salary + ", " + commission + ", " + dno + ")";
		
		stmt = conn.createStatement();					
		stmt.executeUpdate(sql);
		
		
		out.println("emp_copy 테이블에 정상적으로 삽입되었습니다.");
	} catch (Exception e) {
		out.println("emp_copy 테이블에 삽입을 실패했습니다.");
		out.println(e.getMessage());
	} finally {
		if (stmt != null) {
			stmt.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
	
	
	
	%>
	<br/>
	<br/>
	<br/>
	<br/>
	
	<%= eno %> <br/>
	<%= ename %> <br/>
	<%= job %> <br/>
	<%= manager %> <br/>
	<%= hiredate %> <br/>
	<%= salary %> <br/>
	<%= commission %> <br/>
	<%= dno %>
	
</body>
</html>