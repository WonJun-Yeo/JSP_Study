<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  패키지에 존재하는 객체를 사용하기 위해 import -->
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 이 파일은 프로젝트 진행 시 여러 페이지에서 사용되므로 import해서 사용 될 것이다. -->
	<%
	Connection conn = null;      // DB를 연결하는 객체      
	String driver = "oracle.jdbc.driver.OracleDriver";		// Oracle Driver에 접속
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    Boolean connect = false;								// 접속이 잘되는지 확인하는 변수
    
    Class.forName(driver);  // 오라클 드라이버 로드함.
    conn = DriverManager.getConnection(url,"hr2","1234");    // url주소,계정,비밀번호
	
    // 여기서 connection 객체를 close() 해버리면 이 파일을 import할 때 close 되어 오기 때문에 사용하지 못한다.
	%>
</body>
</html>