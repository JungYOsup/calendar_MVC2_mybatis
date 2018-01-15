<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("utf-8"); %> 
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!--조건,반복문등 테그로 제공  -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!--내가 원하는 날짜로 표시하게끔 하줌  -->
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  <!-- 메서드를 제공  -->
   
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> HTML4버전     --> 
<!DOCTYPE html> <!--HTML5로 버전을 지정해줌 -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>일정수정하기</h1>
<form action="CalController.do" method="post">
<input type="hidden" name="seq" value="${dto.seq}">
<input type="hidden" name="command" value="update">
<table border="1">
	<tr>
		<th>아이디</th>
		<td>${dto.id}</td>
		
	</tr>
	<tr>
		<th>일정</th>
		<td>
		<select name="year">
			<c:set var="yearparam" value="${fn:substring(dto.mDate,0,4)}"/> <!-- var(변수명), value(값), fn:substring(dto.mDate,0,4) 12자리 mDate에서 년도만 남기고 잘라서
			변수에다 넣어줌 , value값이 변수에 들어감-->
			
			<c:forEach begin="${yearparam-5}" end="${yearparam+5}" step="1" var="i"> 
			<!--begin,end,step,var =>(for문의 초기값 이 begin이고 ,조건이 end이고 ,증감연산자가 step이다,변수는 var) ,우리가 원래는  items="" 를 사용했었음  -->
			<!--그리고 속성 사이의 공백이 있어야한다 붙어있으면 오류뜸 ex) begin="${yearparam-5}"end="${yearparam+5}" -->
			
			<option value="${i}"${yearparam==i?"selected":""}>${i}</option>
			
			</c:forEach>
		</select>년
		<select name="month">
			<c:forEach begin="1" end="12" step="1" var="i">
			
			
			<option value="${i}"${fn:substring(dto.mDate,4,6)==i?"selected":""}>${i}</option>
			
			</c:forEach>
			
		</select>월
		
		<select name="date">
			<c:forEach begin="1" end="31" step="1" var="i">
			
			
			<option value="${i}"${fn:substring(dto.mDate,6,8)==i?"selected":""}>${i}</option>
			
			</c:forEach>
			
		</select>일
		
		<select name="hour">
			<c:forEach begin="0" end="23" step="1" var="i">
			
			
			<option value="${i}"${fn:substring(dto.mDate,8,10)==i?"selected":""}>${i}</option>
			
			</c:forEach>
			
		</select>시간
		
		<select name="min">
			<c:forEach begin="0" end="59" step="1" var="i">
			
			<!--여기substring은 무조건 범위값을 2개넣어야한다. 한개넣으면 오류발생  -->
			<option value="${i}"${fn:substring(dto.mDate,10,12)==i?"selected":""}>${i}</option>
			
			</c:forEach>
			
		</select>분
		
		
		</td>
		
		
		
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="${dto.title}"></td>
		
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content">${dto.content}</textarea></td>
		
	</tr>
	<tr>
		
		<td colspan="2">
		<input type="submit" value="수정완료"/>	
		<input type="button" value="취소" onclick="location.href='CalController.do?command=caldetail&seq=${dto.seq}'">
		<input type="button" value="돌아가기"	onclick="location.href='CalController.do?command=calendar'" />
		</td>
		
	</tr>


</table>

</form>
</body>
</html>