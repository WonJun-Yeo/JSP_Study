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
	<table width="800">
	<!-- top -->
	<tr height="100">
		<td colspan="2" align="center" width="260">
			<img src="image/다운로드.jpg" width="200" height="70">
		</td>
		<td colspan="4" align="center">
			<font size="10">낭만 캠핑</font>
		</td>
	</tr>
	<tr height="50">
		<td width="130" align="center">텐트</td>
		<td width="130" align="center">의자</td>
		<td width="130" align="center">식기</td>
		<td width="130" align="center">침낭</td>
		<td width="130" align="center">테이블</td>
		<td width="130" align="center">화롯대</td>
		
		<jsp:forward page="Mtfile.jsp">
			<jsp:pram value="안녕" name="hi"></jsp:pram>
		</jsp:forward>
		
	</tr>
	</table>
	</main>
</body>
</html>