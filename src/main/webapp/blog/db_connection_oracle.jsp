<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection</title>
</head>
<body>
<%
    // DB 연결하는 것은 매 페이지에서 사용하기 떄문에 따로 하나 만들어 두고 include file 해서 사용하면 된다.
    Connection conn = null;      // Connection : DB를 연결하는 객체      
	String driver = "oracle.jdbc.driver.OracleDriver";		// 오라클에서 제공한 Oracle에 접속할 수 있게 하는 라이브러리에 존재하는 Oracle Driver 클래스의 경로
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    Boolean connect = false;								// 접속이 잘되는지 확인하는 변수
    
    try {
    	 Class.forName(driver);  // OracleDriver를 로드한다.
         conn = DriverManager.getConnection(url,"hr2","1234");  // Connection 객체를 활성화(url주소,계정,비밀번호)
         
         // Connection 객체가 잘 활성화 되면 connect가 true로 바뀌고, 그렇지 않을 경우에는 catch블락으로 넘거간다.
         connect = true;
         conn.close();
    } catch (Exception e) {
    	connect = false;
    	e.printStackTrace();
    }
%>

<%
	if (connect == true) {
		out.println ("오라클 DB에 잘 연결 되었습니다.");
	} else {
		out.println ("오라클 DB 연결에 실패 하였습니다.");
	}



%>
</body>
</html>