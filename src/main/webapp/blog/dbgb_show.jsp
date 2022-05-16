<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="filedb.css" rel="stylesheet" type="text/css">
<title>DB 출력 페이지 (페이징)</title>
</head>
<body>
	<%@ include file = "db_conn_oracle.jsp" %>
	<%
	// DB에서 가져온 데이터를 저장하는 Vector 컬렉션 객체 생성, 페이지 처리를 위해 필요하다. 
	Vector<String> name = new Vector<>();
	Vector<String> email = new Vector<>();
	Vector<String> inputdate = new Vector<>();
	Vector<String> subject = new Vector<>();
	Vector<String> content = new Vector<>();
	
	// 페이징 처리 변수 선언
	int where = 1;								// 현재 페이지
	int totalgroup = 0;							// maxpage 갯수대로 그룹핑한 총 그룹 갯수
	int maxpage = 2;							// 출력할 페이지 갯수, 그룹핑할 페이지 갯수
	int startpage = 1;
	int endpage = startpage + maxpage - 1;
	int wheregroup = 1;							// 그룹핑한 그룹중 현재 포함된 그룹
	
	// Get 방식으로 페이지를 선택 했을 때 go(현재페이지), gogroup(현태 페이지 그룹) 변수를 받아서 처리를 한다.
	if (request.getParameter("go") != null) {						// 현재 페이지 번호가 넘어올 경우
		where = Integer.parseInt(request.getParameter("go"));
		wheregroup = (where-1) / maxpage + 1;
		startpage = (wheregroup - 1) * maxpage + 1;
		endpage = startpage + maxpage - 1;
	} else if (request.getParameter("gogroup") != null) {			// 현재 페이지 그룹의 번호가 넘어얼 경우
		wheregroup = Integer.parseInt(request.getParameter("gogroup"));
		startpage = (wheregroup - 1) * maxpage + 1;
		where = startpage;
		endpage = startpage + maxpage - 1;
	}
	
	int nextgroup = wheregroup + 1;				// [다음]에 링크걸릴 변수 <== 페이지 그룹
	int priorgroup = wheregroup - 1;				// [이전]에 링크걸릴 변수
	int nextpage = where + 1;						// 다음 페이지
	int priorpage = where - 1;						// 이전 페이지
	
	int startrow = 0;								// 특정 페이지에서 시작될 레코드의 index
	int endrow = 0;									// 특정 페이지에서 마지막이될 레코드의 index
	int maxrow = 3;									// 한 페이지에 출력할 레코드 갯수
	int totalrows = 0;								// DB에 저장되어있는 레코드의 총 갯수
	int totalpages = 0;
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;						// SELECT문 결과인 레코드셋을 담는 객체
	
	try {
		sql = "SELECT * FROM guestboard2";
		st = conn.createStatement();			// Statement 객체 활성화
		rs = st.executeQuery(sql);				// ResultSet 객체에 SELECT문 결과인 레코드셋을 할당
		
		if (!(rs.next())) {						// DB에 값이 존재하지 않을때
			out.println("블로그에 올린 글이 없습니다.");
		} else {
			do {
				// DB에서 가져온 값을 벡터에 저장
				name.addElement(rs.getString("name"));
				email.addElement(rs.getString("email"));
				inputdate.addElement(rs.getString("inputdate"));
				subject.addElement(rs.getString("subject"));
				content.addElement(rs.getString("content"));
			} while(rs.next());
			
			// 출력할 변수의 범위를 설정
			totalrows = name.size();						// 백터에 저장된 총 레코드 갯수
			totalpages = (totalrows - 1) / maxrow + 1;		// 총 페이지 갯수
			startrow = (where - 1) * maxrow;				// 현재 페이지의 시작 레코드의 index
			endrow = startrow + maxrow - 1;					// 현재 페이지의 마지막 레코드의 index
			
			if (endrow >= totalrows) {
				endrow = totalrows - 1;
			}
			
			totalgroup = (totalpages - 1) / maxpage + 1;	// totalgroup을 생성하는 수식
			
			if (endpage > totalpages) {
				endpage = totalpages;
			}
			
			// 백터에 저장된 값을 가져와 출력
			for (int j = startrow; j <= endrow; j++) {
				%>
				<table width="600" border="1">
				<tr height="25"><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2" align="center"><h3><%= subject.elementAt(j) %></h3></td></tr>
				<tr>
					<td>글쓴이 : <%= name.elementAt(j) %></td>
					<td>이메일 : <%= email.elementAt(j) %></td>
				</tr>
				<tr><td colspan="2">작성일 : <%= inputdate.elementAt(j) %></td></tr>
				<tr><td colspan="2" width="600">내용 : <%= content.elementAt(j) %></td></tr>
				<tr height="25"><td colspan="2">&nbsp;</td></tr>
				</table>
				<%
			}
			
			// pagenation 출력
			if (wheregroup > 1) {
				out.println("[<a href=\"dbgb_show.jsp?go=1\">처음</a>]");
				out.println("[<a href=\"dbgb_show.jsp?gogroup=" + priorgroup + "\">이전</a>]");
			} else {
				out.println("[처음]");
				out.println("[이전]");
			}
			
			for (int j = startpage; j <= endpage; j++) {
				if (j == where) {
					out.println("[" + j + "]");
				} else {
					out.println("[<a href=\"dbgb_show.jsp?go=" + j + "\">" + j + "</a>]");
				}
			}
			
			if (wheregroup < totalgroup) {
				out.println("[<a href=\"dbgb_show.jsp?gogroup=" + nextgroup + "\">다음</a>]");
				out.println("[<a href=\"dbgb_show.jsp?gogroup=" + totalgroup + "\">마지막</a>]");
			} else {
				out.println("[다음]");
				out.println("[마지막]");
			}
			out.println(where + "/" + totalpages);
		}
	} catch(Exception e) {
		out.println(e.getMessage());
	} finally {
		if (rs != null) {
			rs.close();
		}
		if (st != null) {
			st.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
	%>
</body>
</html>