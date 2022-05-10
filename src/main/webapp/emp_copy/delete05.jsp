<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete</title>
</head>
<body>
	<form method = "POST" action = "delete01_process.jsp">
		<p> 사원번호 : <input type = "text" name = "eno"></p>
		<p> 이름 : <input type = "text" name = "ename"></p>
		<p> 직책 : <input type = "text" name = "job"></p>
		<p> 직속상관 : <input type = "text" name = "manager"></p>
		<p> 입사일 : <input type = "date" name = "hiredate"></p>
		<p> 급여 : <input type = "text" name = "salary"></p>
		<p> 보너스 : <input type = "text" name = "commission"></p>
		<p> 부서번호 : <input type = "text" name = "dno"></p>
		<p> <input type = "submit" value = "submit"></p>
	</form>
</body>
</html>