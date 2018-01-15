<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("utf-8"); %> 
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>    
<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->


<!DOCTYPE html> 

<html>
<head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function allChk(bool) {
	
	$("input[name=chk]").prop("checked", bool);
	
	
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>일정목록보기</title>
</head>
<body>
<jsp:useBean id="util" class="com.hk.utils.Util"/>

	<h1>일정목록보기</h1>
	<form action="CalController.do" method="post">
		<input type="hidden" name="command" value="muldel" />
		<table border="1">
			<col width="50px">
			<col width="50px">
			<col width="200px">
			<col width="100px">
			<col width="100px">

			<tr>
				<th><input type="checkbox" name="all"
					onclick="allChk(this.checked)" /></th>
				<th>번호</th>
				<th>제목</th>
				<th>일정</th>
				<th>작성일</th>
			</tr>
			<c:choose>
				<c:when test="${empty lists}>">
					<tr>
						<td colspan="5">---일정이 없습니다. ---</td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach items="${lists}" var="dto">
						<tr>
							<td><input type="checkbox" name="chk" value="${dto.seq}" /></td>
							<td>${dto.seq}</td>
							<td><a href="CalController.do?command=caldetail&seq=${dto.seq}">${dto.title}</a></td>
							
							<!--usebean에 대한 자세한 내용은 2018-01-11.txt파일을 찾아보자  -->	
		
							<!--mDate는 String타입이기때문에 변환을 못한다. 따라서 ${dto.mDate}를 date타입으로 변환해야한다. -->
							<!--그래서 변환하는 메서드를 만든다음 dto.mDate값을 넣으로고 했으나-->
							<%-- <td><%=Util.toDates(${dto.mDate}) %> </td> dto.mDate는 자바가 아니므로 오류가 뜬다.
							따라서 ***usebean형태로 바꿔야한다.!! --%>	
												
							<td>
								<jsp:setProperty property="toDates" name="util" value="${dto.mDate}"/>	
								<jsp:getProperty property="toDates" name="util"/>
							</td> 							
							
											
							<!--regDate는 Date타입이기때문에 변환을 할수있다. -->
							<td><f:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="5"><input type="submit" value="삭제" /> <input
					type="button" value="돌아가기"
					onclick="location.href='CalController.do?command=calendar'" /></td>
			</tr>
		</table>

	</form>


</body>
</html>