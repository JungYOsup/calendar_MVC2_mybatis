<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->
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
<body>

<!-- <a href="CalController.do?command=calendar">일정보기</a> -->

<!--둘의 차이점은 a테그 같은경우는 index.jsp페이지가 보이고 일정보기를 누를때 calendar페이지로 이동하지만
jsp:forward는 index.jsp페이지를 보지 않고 바로 calendar페이지로 이동해버림  -->
<!--action tag의 forward, param 이다 -->
<jsp:forward page="CalController.do">
	<jsp:param value="calendar" name="command"/>
</jsp:forward>

</body>
</html>