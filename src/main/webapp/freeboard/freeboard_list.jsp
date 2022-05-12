<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<HTML>
<HEAD>
<META charset="UTF-8">
<TITLE>게시판</TITLE>
<LINK href="freeboard.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript">
	function check() {
		with (document.msgsearch) {
			if (sval.value.length == 0) {
				alert("검색어를 입력해 주세요!!");
				sval.focus();
				return false;
			}
			document.msgsearch.submit();
		}
	}
	function rimgchg(p1, p2) {
		if (p2 == 1)
			document.images[p1].src = "image/open.gif";
		else
			document.images[p1].src = "image/arrow.gif";
	}

	function imgchg(p1, p2) {
		if (p2 == 1)
			document.images[p1].src = "image/open.gif";
		else
			document.images[p1].src = "image/close.gif";
	}
</SCRIPT>
</HEAD>
<BODY>
	<%@ include file="dbconn_oracle.jsp"%>
	<P>
	<P align=center>
		<FONT color=#0000ff face=굴림 size=3><STRONG>자유 게시판</STRONG></FONT>
	</P>
	<P>
	<CENTER>
		<TABLE border=0 width=600 cellpadding=4 cellspacing=0>
			<tr align="center">
				<td colspan="5" height="1" bgcolor="#1F4F8F"></td>
			</tr>
			<tr align="center" bgcolor="#87E8FF">
				<td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
				<td width="340" bgcolor="#DFEDFF"><font size="2">제목</font></td>
				<td width="84" bgcolor="#DFEDFF"><font size="2">등록자</font></td>
				<td width="78" bgcolor="#DFEDFF"><font size="2">날짜</font></td>
				<td width="49" bgcolor="#DFEDFF"><font size="2">조회</font></td>
			</tr>
			<tr align="center">
				<td colspan="5" bgcolor="#1F4F8F" height="1"></td>
			</tr>
			<%
			// Vector : 멀티스레드 환경에서 사용, 모든 메소드가 동기화 처리되어 있음 
			Vector name = new Vector();
			Vector inputdate = new Vector();
			Vector email = new Vector();
			Vector subject = new Vector();
			Vector rcount = new Vector();

			Vector step = new Vector();
			Vector keyid = new Vector();

			// 페이징 처리 시작 부분
			int where = 1;

			int totalgroup = 0; 						// 출력할 페이징의 그룹핑의 최개 갯수
			int maxpages = 3; 							// 화면에 출력할 페이지네이션의 페이지 갯수
			int startpage = 1; 							// 처음 페이지
			int endpage = startpage + maxpages - 1; 	// 마지막 페이지
			int wheregroup = 1; 						// 현재 위치하는 그룹

			// go : 해당페이지 번호로 이동 (페이지 숫자 버튼으로)
			// freeboard_list.jsp?go=3 : 3페이지로 이동
			// gogroup : maxpages로 그룹핑한 그룹 단위 이동 (이전, 다음 버튼으로)
			// freeboard_list.jsp?gogroup=2 : maxpages가 5라면, 6,7,8,9,10이 페이지네이션에 표시

			if (request.getParameter("go") != null) {
				// go 변수의 값이 넘어올때 (페이지 번호를 클릭했을 때)
				where = Integer.parseInt(request.getParameter("go")); 					// 현재 페이지 번호를 담은 변수
				wheregroup = (where - 1) / maxpages + 1; 								// 현재 위치한 페이지의 gogroup
				startpage = (wheregroup - 1) * maxpages + 1; 							// 현재 위치한 페이지 그룹의 start page 번호
				endpage = startpage + maxpages - 1; 									// 현재 위치한 페이지 그룹의 end page 번호
			} else if (request.getParameter("gogroup") != null) {
				// gogroup 변수를 가지고 넘어올때 (이전, 다음 버턴을 클릭했을 때)
				wheregroup = Integer.parseInt(request.getParameter("gogroup")); 		// 현재 위치한 페이지의 gogroup
				startpage = (wheregroup - 1) * maxpages + 1; 							// 현재 위치한 페이지 그룹의 start page 번호
				where = startpage; 														// 현재 위치한 페이지 그룹의 start page 번호
				endpage = startpage + maxpages - 1; 									// 현재 위치한 페이지 그룹의 end page 번호
			}
			int nextgroup = wheregroup + 1; 											// 현재 위치한 페이지 그룹의 다음 그룹
			int priorgroup = wheregroup - 1; 											// 현재 위치한 페이지 그룹의 이전 그룹

			int nextpage = where + 1; 			// 현재 위치한 페이지의 다음 페이지
			int priorpage = where - 1; 			// 현재 위치한 페이지의 이전 페이지
			int startrow = 0; 					// DB에서 Select한 레코드 시작번호 (하나의 페이지에서) (기본값 할당)
			int endrow = 0; 					// DB에서 Select한 레코드 마지막번호 (하나의 페이지에서) (기본값 할당)
			int maxrows = 3; 					// 화면에 출력할 recode 수
			int totalrows = 0; 					// DB에서 Select한 레코드 총 갯수 (기본값 할당)
			int totalpages = 0; 				// 총 페이지 갯수 (기본값 할당)
			// 페이지 처리 마지막 부분

			int id = 0;

			String em = null;
			//Connection con = null;
			Statement st = null;
			ResultSet rs = null;

			try {
				st = conn.createStatement();
				String sql = "select * from freeboard order by";
				sql = sql + " masterid desc, replaynum, step, id";
				rs = st.executeQuery(sql);

				//out.println(sql);
				//if(true) return;

				if (!(rs.next())) {
					out.println("게시판에 올린 글이 없습니다");
				} else {
					do {
				// Select 된 DB의 값을 가져와 각각의 Vector에 저장
				keyid.addElement(new Integer(rs.getInt("id"))); 			// rs의 id 컬럼의 값을 가져와 벡터에 저장
				name.addElement(rs.getString("name")); 						// rs의 name 컬럼의 값을 가져와 벡터에 저장
				email.addElement(rs.getString("email")); 					// rs의 email 컬럼의 값을 가져와 벡터에 저장
				String idate = rs.getString("inputdate"); 					// rs의 inputdate 컬럼의 값을 가져와 String에 저장
				idate = idate.substring(0, 8); 								// inputdate 컬럼의 값을 첫째자리부터 8번쨰자리까지만 저장 (년월일 까지만 나오게 시간을 짜른것)
				inputdate.addElement(idate); 								// 가공한 inputdate 컬럼의 값을 벡터에 저장
				subject.addElement(rs.getString("subject")); 				// rs의 suject 컬럼의 값을 가져와 벡터에 저장
				rcount.addElement(new Integer(rs.getInt("readcount"))); 	// rs의 readcount 컬럼의 값을 가져와 벡터에 저장
				step.addElement(new Integer(rs.getInt("step"))); 			// rs의 step 컬럼의 값을 가져와 벡터에 저장
					} while (rs.next());
					totalrows = name.size(); 								// name 백터에 저장된 데이터 갯수, 총 레코드 수와 같다.
					totalpages = (totalrows - 1) / maxrows + 1; 			// 총페이지 계산
					startrow = (where - 1) * maxrows; 						// 현재 페이지의 시작 레코드번호
					endrow = startrow + maxrows - 1; 						// 현재 페이지의 마지막 레코드번호
					if (endrow >= totalrows)
				endrow = totalrows - 1;

					totalgroup = (totalpages - 1) / maxpages + 1;
					if (endpage > totalpages)
				endpage = totalpages;
					
					// 현재 페이지에서 시작레코드 ~ 마지막레코드 까지 순환하면서 출력
					for (int j = startrow; j <= endrow; j++) {
						String temp = (String) email.elementAt(j);					// email 백터에서 email 주소를 가져와 String에 저장
						if ((temp == null) || (temp.equals("")))					// email 값이 비어있을 때,
							em = (String) name.elementAt(j);						// em 변수에 name값을 String에 저장
						else
							em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";			// email 값이 있을 경우, mail을 보내는 링크를 걸어준다.
		
						id = totalrows - j;
						if (j % 2 == 0) {
							// j가 짝수 일때, 레코드의 배경색이 흰색
							out.println("<TR bgcolor='#FFFFFF' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor=''\">");
						} else {
							// j가 홀수 일때, 레코드에 특수 배경색이 적용
							out.println(
									"<TR bgcolor='#F4F4F4' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor='#F4F4F4'\">");
						}
						out.println("<TD align=center>");
						out.println(id + "</TD>");
						out.println("<TD>");
						int stepi = ((Integer) step.elementAt(j)).intValue();
						int imgcount = j - startrow;
						if (stepi > 0) {
							for (int count = 0; count < stepi; count++)
								out.print("&nbsp;&nbsp;");
							out.println("<IMG name=icon" + imgcount + " src=image/arrow.gif>");
							out.print("<A href=freeboard_read.jsp?id=");
							out.print(keyid.elementAt(j) + "&page=" + where);
							out.print(" onmouseover=\"rimgchg(" + imgcount + ",1)\"");
							out.print(" onmouseout=\"rimgchg(" + imgcount + ",2)\">");
						} else {
							out.println("<IMG name=icon" + imgcount + " src=image/close.gif>");
							out.print("<A href=freeboard_read.jsp?id=");
							out.print(keyid.elementAt(j) + "&page=" + where);
							out.print(" onmouseover=\"imgchg(" + imgcount + ",1)\"");
							out.print(" onmouseout=\"imgchg(" + imgcount + ",2)\">");
						}
						out.println(subject.elementAt(j) + "</TD>");
						out.println("<TD align=center>");
						out.println(em + "</TD>");
						out.println("<TD align=center>");
						out.println(inputdate.elementAt(j) + "</TD>");
						out.println("<TD align=center>");
						out.println(rcount.elementAt(j) + "</TD>");
						out.println("</TR>");
					}
					
					rs.close();
				}
				out.println("</TABLE>");
				st.close();
				conn.close();
			} catch (java.sql.SQLException e) {
				out.println(e);
			}

			if (wheregroup > 1) {
				// 현재 그룹이 1이상일 때 (첫 페이지가 아닐 때)
				out.println("[<A href=freeboard_list.jsp?gogroup=1>처음</A>]");
				out.println("[<A href=freeboard_list.jsp?gogroup=" + priorgroup + ">이전</A>]");
			} else {
				// 현재 그룹이 1일 때 (첫 페이지 일 때)
				out.println("[처음]");
				out.println("[이전]");
			}
			if (name.size() != 0) {
				for (int jj = startpage; jj <= endpage; jj++) {
					if (jj == where)
				out.println("[" + jj + "]");
					else
				out.println("[<A href=freeboard_list.jsp?go=" + jj + ">" + jj + "</A>]");
				}
			}
			if (wheregroup < totalgroup) {
				out.println("[<A href=freeboard_list.jsp?gogroup=" + nextgroup + ">다음</A>]");
				out.println("[<A href=freeboard_list.jsp?gogroup=" + totalgroup + ">마지막</A>]");
			} else {
				out.println("[다음]");
				out.println("[마지막]");
			}
			out.println("전체 글수 :" + totalrows);
			%>
			<!--<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right valign=bottom>
   <A href="freeboard_write.htm"><img src="image/write.gif" width="66" height="21" border="0"></A>
   </TD>
  </TR>
 </TABLE>-->

			<FORM method="post" name="msgsearch" action="freeboard_search.jsp">
				<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
					<TR>
						<TD align=right width="241"><SELECT name=stype>
								<OPTION value=1>이름
								<OPTION value=2>제목
								<OPTION value=3>내용
								<OPTION value=4>이름+제목
								<OPTION value=5>이름+내용
								<OPTION value=6>제목+내용
								<OPTION value=7>이름+제목+내용
						</SELECT></TD>
						<TD width="127" align="center"><INPUT type=text size="17"
							name="sval"></TD>
						<TD width="115">&nbsp;<a href="#" onClick="check();"><img
								src="image/serach.gif" border="0" align='absmiddle'></A></TD>
						<TD align=right valign=bottom width="117"><A
							href="freeboard_write.htm"><img src="image/write.gif"
								border="0"></TD>
					</TR>
				</TABLE>
			</FORM>
</BODY>
</HTML>