<!-- 녹색들이 속성, page 디렉티브 : 
3가지를 쓸 수 있다.
1. 인클루드 : 
2. 태그라이브러리
3. 페이지
	JSP페이지를 구성하는 요소를 Page 디렉티브라고 한다.

language : 언어, JSP의 스트립트요소에 사용할 언어를 선언하는 속성. default 값은 java
contentType : JSP가 어떻게 바뀌며, 이 안에서 사용하는 문자열 타입 선언하는 속성. default 값은 text/html
pageEncoding : 인코딩 타입을 선언하는 속성
import : Java에서 사용할 클래스를 import하는것과 같음
session : JSP의 내장 객체로서, 페이지 이동간에 데이터를 전송해야하는데 페이지가 바뀌어도 데이터 DB에 저장하지 않고도 데이터를 유지하고 싶을 때 사용한다. 이 기능을 사용할지 안할지 선언하는 속성. 일정시간이 지나면 session을 끊어줌으로써 메모리 효율성을 올릴 수 있다. default 값은 true
buffer : 기본적은로 8kb로 잡혀있다. buffer라고하는 메모리 공간에 데이터를 저장시켜놓는것. 이 출력 버퍼크기를 지정하는 속성
autoFlush : 지정한 buffer크기만큼 데이터가 다 차지 않아도 자동으로 응답을 내보낼지 않을 지 선택하는 속성. default 값은 true
errorPage : JSP가 에러가 발생했는 때 보여줄 페이지의 파일명을 선언하는 속성
isErrorPage : JSP가 에러가 발생했을 때 errorPage 속성에 지정한 페이지를 보여줄 지 말 지 선언하는 속성. default 값은 false
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" errorPage="Error.jsp" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 스크립트 요소를 사용할 때 꺽쇠 퍼센트로 묶어준다. 이걸 스크립트릿 이라고 함 -->
<%
	// java.util.Date 클래스를 import 해주어야 한다.
	Date date = new Date();

	// 에러코드 => Error.jsp 를 화면에 출력
	int b = 10/0;
	
%>

</body>
</html>