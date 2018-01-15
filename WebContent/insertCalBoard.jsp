<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8"); %> 
<%response.setContentType("text/html; charset=UTF-8"); %>
    
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> HTML4버전     --> 
<!DOCTYPE html> <!--HTML5로 버전을 지정해줌 -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month")); 
	int date=Integer.parseInt(request.getParameter("date")); 
	int lastday=Integer.parseInt(request.getParameter("lastday")); // 파마리터를 받을때는 String으로 가져오므로 int로 변환해줘야한다.
	
	Calendar cal = Calendar.getInstance(); //캘런터 객체를 구한다음에
	
	int hour = cal.get(Calendar.HOUR_OF_DAY); //현재시간
	int min = cal.get(Calendar.MINUTE); //현재분
	

%>
<body>
<h1>일정추가하기</h1>
<form action="CalController.do" method="post">
	<input type="hidden" name="command" value="inserCal">
	<table border="1">
		
	<tr>
		<th>아이디</th>
		<td><input type="text" name="id" value="hk" readonly="readonly"/></td>
	
	
	</tr>
		
	<tr>
		<th>일정</th>
		<td>
			<select name="year"> <!--키값은 select의 키인year  -->
				<%
					for(int i=year-5; i<year+5; i++){
						%>
				<option value="<%=i%>" <%=year==i?"selected":"" %> ><%=i%></option><!--전송되는거는 여기 value의 i  -->
						
						<%
					}
				%>
			</select>년
			<select name="month">
				<%
					for(int i=1;i<13;i++){
						%>
						<option value="<%=i%>" <%=month==i?"selected":"" %>><%=i%></option>
						<% 
					}
				%>
			</select>월
			<select name="date">
				<%
					for(int i=1;i<=lastday;i++){
						%>
						<option value="<%=i%>" <%=date==i?"selected":"" %>><%=i%></option>
						<% 
					}
				%>
			</select>일
			<select name="hour">
				<%
					for(int i=0;i<24;i++){
						%>
						<option value="<%=i%>"<%=hour==i?"selected":"" %>><%=i%></option>
						<% 
					}
				%>
			</select>시
			<select name="min">
				<%
					for(int i=0;i<60;i++){
						%>
						<option value="<%=i%>"<%=min==i?"selected":"" %>><%=i%></option>
						<% 
					}
				%>
			</select>분
			
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content"></textarea> </td>
	</tr>
	<tr>
	
		<td colspan="2">
			<input type="submit" value="일정작성">
			<input type="button" value="돌아가기"
			onclick="location.href='CalController.do?command=calendar'">
			
		</td>
	
	</tr>
	
	
	</table>
</form>
</body>
</html>