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

<%@ include file = "dbconn_oracle.jsp" %>

<%
	// 한글이 깨지지 않도록 인코딩 타입처리
	request.setCharacterEncoding("UTF-8");
	
	// form에서 넘긴 데이터를 Request 객체의 getParameter 메소드로 변수에 할당
	String eno = request.getParameter("eno");
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	String manager = request.getParameter("manager");
	String hiredate = request.getParameter("hiredate");
	String salary = request.getParameter("salary");
	String commission = request.getParameter("commission");
	String dno = request.getParameter("dno");
	
	// 실행할 SQL 문 변수 생성 및 기본값 할당
	String sql = null;
	
	
	// Statement 객체 생성 및 기본값 할당 (sql문을 실행시키는 객체)
	Statement stmt = null;
	
	// ResultSet 객체 생성 및 기본값 할당 (select 한 recode set를 담는 객체)
	ResultSet rs = null;
	
	
	try {
		// form에서 넘겨받은 eno를 조건으로 DB의 값을 select 해온다.	
		
		// sql 변수에 실행할 SQL 문 할당
		sql = "SELECT * FROM emp_copy WHERE eno = " + eno;
		
		// conn의 createStatement() 메소드를 사용해서 Statement 객체 활성화
		stmt = conn.createStatement();
		
		// select 문을 실행시켜 넘겨받은 record set을 Resultset 객체에 할당
		rs = stmt.executeQuery(sql);
		
		// re.next() : re가 받은 record set이 남아 있으면 true, 없으면 false
		if(rs.next()) {
			// DB에서 값을 가지고온 ENO를 변수에 할당
			String rEno = rs.getString("eno");
			

			// sql 변수 재사용
			sql = "UPDATE emp_copy SET eno = " + eno + ", ename = '" + ename + "' ,job = '" + job + "', manager = " + manager + ", hiredate = '" + hiredate + "', salary = " + salary + ", commission = " + commission + ", dno = " + dno + " WHERE eno = " + eno;
			
			// sql에 담긴 Update 구문 실행
			stmt.executeUpdate(sql);
			
			// sql 확인
			out.println(sql);

			
		} else {
			out.println(eno + " : 해당 사원번호가 DB에 존재하지 않습니다.");
		}
		
	} catch (Exception e) {
		out.println (e.getMessage());
		
		// sql 확인
		out.println(sql);
	} finally {
		if (conn != null) {
			conn.close();
		}
		if (stmt != null) {
			stmt.close();
		}
		if (rs != null) {
			rs.close();
		}
	}

	%>

</body>
</html>