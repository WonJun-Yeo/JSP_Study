<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<main>
	<h2>회원 정보 보기</h2>
	<%
	// post방식으로 데이터가 넘어올 때 한글이 깨어질 수 있기에 하는 선언
	request.setCharacterEncoding("UTF-8");
	
	// 사용자로부터 넘어온 데이터를 저장
	String id = request.getParameter("id");
	String pass1 = request.getParameter("pass1");
	String pass2 = request.getParameter("pass2");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	String job = request.getParameter("job");
	String age = request.getParameter("age");
	String info = request.getParameter("info");
	
	// checkbox의 경우 넘어오는 값이 여러개이므로 배열타입으로 return 받아야 함
	String[] hobby = request.getParameterValues("hobby");
	
	// pass1과 pass2가 같지 않은 경우
	if (!pass1.equals(pass2)) {
	%>
		<script>
			alert("비밀번호가 일치하지 않습니다.");
			// 이전 페이지로 이동
			history.go(-1);
		</script>
	<%
	}
	%>
	<table width="400" border="1">
		<tr height="50">
			<td width="150" align="center">아이디</td>
			<td width="350" align="center"><%= id %></td>
		</tr>
		<tr height="50">
			<td width="150" align="center">이메일</td>
			<td width="350" align="center"><%= email %></td>
		</tr>
		<tr height="50">
			<td width="150" align="center">전화번호</td>
			<td width="350" align="center"><%= tel %></td>
		</tr>
		<tr height="50">
			<td width="150" align="center">관심분야</td>
			<!-- job은 배열에 저장되었기 때문에 -->
			<td width="350" align="center"><%
			for (int i =0; i < hobby.length; i++) {
				out.write(hobby[i] + " ");				
			}
			%></td>
		</tr>
		<tr height="50">
			<td width="150" align="center">직업</td>
			<td width="350" align="center"><%= job %></td>
		</tr>
		<tr height="50">
			<td width="150" align="center">연령</td>
			<td width="350" align="center"><%= age %></td>
		</tr>
		<tr height="50">
			<td width="150" align="center">하고싶은말</td>
			<td width="350" align="center"><%= info %></td>
		</tr>
	</table>

</main>
</body>
</html>