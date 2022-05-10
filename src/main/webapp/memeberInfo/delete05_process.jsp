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
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email= request.getParameter("email");
	
	// 실행할 SQL 문 변수 생성 및 기본값 할당
	String sql = null;
	
	
	// PrepareStatement 객체 생성 및 기본값 할당 (sql문을 실행시키는 객체)
	PreparedStatement pstmt = null;
	
	// ResultSet 객체 생성 및 기본값 할당 (select 한 recode set를 담는 객체)
	ResultSet rs = null;
	
	// 폼에서 넘겨받은 id와 passwd를 DB에서 가져온 ID, PASSWD를 비교해 같을 경우 Delete
	
	try {
		// form에서 넘겨받은 id를 조건으로 DB의 값을 select 해온다.	
		
		// sql 변수에 실행할 SQL 문 할당
		sql = "SELECT id, pass FROM mbTbl WHERE id = ?";
		
		// conn의 prepareStatement() 메소드를 사용해서 PreparedStatement 객체 활성화
		pstmt = conn.prepareStatement(sql);
		
		// ?인자에 값을 받는 변수 할당
		pstmt.setString(1, id);
		
		// select 문을 실행시켜 넘겨받은 record set을 Resultset 객체에 할당
		rs = pstmt.executeQuery();
		
		// re.next() : re가 받은 record set이 남아 있으면 true, 없으면 false
		if(rs.next()) {
			// DB에서 값을 가지고온 ID와 PASS를 변수에 할당
			String rId = rs.getString("ID");
			String rPassword = rs.getString("PASS");
			
			// id가 존재하는 경우, form에서 넘긴 id, passwd와 DB의 ID, PASS가 일치하는지 확인
			// 이미 id값이 있다고 하고 거기에 맞는 id값과 passwd를 가져왔기 떄문에 passwd만 비교해도됨
			if (id.equals(rId) && passwd.equals(rPassword)) {
				// sql 변수 재사용
				sql = "DELETE mbTbl WHERE id = ? AND pass = ?";
				
				pstmt.setString(1, id);
				pstmt.setString(2, passwd);
				
				// sql에 담긴 Delete 구문 실행
				pstmt.executeUpdate();
				
				// sql 확인
				out.println(sql);
			} else {
				// passwd와 PASS가 일치 않는 경우
				out.println("비밀번호가 일치하지 않습니다.");
			}
			
			
			
		} else {
			out.println(id + " : 해당 아이디가 DB에 존재하지 않습니다.");
		}
		
	} catch (Exception e) {
		out.println (e.getMessage());
		
		// sql 확인
		out.println(sql);
	} finally {
		if (conn != null) {
			conn.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (rs != null) {
			rs.close();
		}
	}

	%>
</body>
</html>