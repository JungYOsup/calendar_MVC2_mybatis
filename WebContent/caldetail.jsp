<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->
<%@page import="com.hk.caldtos.CalDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("utf-8"); %> 
<%response.setContentType("text/html; charset=UTF-8"); %>
    
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> HTML4버전     --> 
<!DOCTYPE html> <!--HTML5로 버전을 지정해줌 -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="util" class="com.hk.utils.Util"/>
<body>
<h1>일정상세보기</h1>
<table border="1">
	<tr>
		<th>아이디</th>
		<td>${dto.id}</td>
		
	</tr>
	<tr>
		<th>일정</th>
		<td><jsp:setProperty property="toDates" name="util" value="${dto.mDate}"/>
			<jsp:getProperty property="toDates" name="util"/>+
		</td>
		
	</tr>
	<tr>
		<th>제목</th>
		<td>${dto.content}</td>
		
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly">${dto.content}</textarea></td>
		
	</tr>
	<tr>
		
		<td colspan="2">
		<input type="button" value="수정" onclick="location.href='CalController.do?command=updateForm&seq=${dto.seq}'"/>	
		<input type="button" value="삭제 " onclick="location.href='CalController.do?command=muldel&chk=${dto.seq}'">
		</td>
		
	</tr>


</table>
</body>
</html>