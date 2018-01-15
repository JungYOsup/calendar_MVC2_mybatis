<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->
<%@page import="com.hk.caldtos.CalDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.caldaos.CalDao"%>
<%@ page import="com.hk.utils.Util"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> HTML4버전     -->
<!DOCTYPE html>
<!--HTML5로 버전을 지정해줌 -->

<html>
<head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

<style type="text/css">
	#calendar {
		border: 1px solid gray;
		border-collapse: collapse;
	}
	
	#calendar th {
		width: 80px;
		border: 1px solid gray;
	}
	
	#calendar td {
		position: relative;
		width: 80px;
		height: 80px;
		border: 1px solid gray;
		text-align: left;
		vertical-align: top;
	}
	
	.clist>p {
		font-size: 6pt;
		margin: 1px;
		background-color: black;
		color: white;
		text-indent: 3px; /*들여쓰기   */
	}
	
	a {
		text-decoration: none;
	}
	
	img {
		width: 25px;
		height: 25px;
	}
	
	.cPreview{
		position: absolute;
		top: -10px;
		left: 10px;
		background-color: pink;
		width: 40px;
		height: 40px;
		text-align: center;
		line-height: 40px;
		border-radius: 40px 40px 40px 1px;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	$(function() {
		$(".countview").hover(function() {
			var aCountView = $(this); //현재 마우스가 올라간 a테그 객체를 구한다.

			var year = $(".y").text().trim(); //년도를 가지고옴 , 앞뒤공백이 있을경우 완벽하게 앞뒤공백을 제거
			var month = $(".m").text().trim();
			var date = aCountView.text().trim(); //내가 마우스를 올린 곳의 text를 구함 그 text는 date이므로 

			var yyyyMMdd = year + isTwo(month) + isTwo(date); //8자리로 만든다.


			$.ajax({
			type: "post",
			url: "CalCountAjax.do",
			data: "id=hk&yyyyMMdd="+yyyyMMdd,
			datatype:"json",
			success: function (obj) {
				
//			alert(obj["count"]);
			var count=obj["count"];
			
			aCountView.after("<div class='cPreview'>"+count+"</div>");
			
			},
			
			error: function () {
				alert("서버통신실패입니다!!");
			}
			
			}); 

		}, function() {
			$(".cPreview").remove(); //마우스가 나가면 삭제하기
			
		});

	})
	
	//자바스크립트에서의 함수표현
	function isTwo(n) {
		return n.length < 2 ? "0" + n : n
	}
</script>
</head>
<%
	//달력의 날짜를 바꾸기 위해 전달된 year와 month
	String paramYear = request.getParameter("year");
	String paramMonth = request.getParameter("month");

	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR); //현재년도를 가지고옴
	int month = cal.get(Calendar.MONTH) + 1; //현재 월을 가지고옴,API에서 달은 0~11월까지 되어있으므로 +1을 해줘야한다
	//년도아 월을 변경할때 처리
	if (paramYear != null) {
		year = Integer.parseInt(paramYear);//get타입에서 year가 넘어왔으므로 String타입인 paramYear을 int로 바꿔줌

	}
	if (paramMonth != null) {
		month = Integer.parseInt(paramMonth);
	}

	if (month > 12) {
		month = 1;
		year++;
	}
	if (month < 1) {
		month = 12;
		year--;
	}

	//월의 마지막날을 구하기
	int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	//현재 월의 1일에 대한 요일 구하기
	cal.set(year, month - 1, 1); //현재 년월에 대한 1일로 객체 셋팅 month-1을 해준이유는
	//Calendar API는 1월을 0으로 인식하기 때문에 다시 API가 인식하게 하기위해서는 +1해준것을 다시 원래대로 돌려야한다.

	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); //1일의 요일을 가지고옴 :1(일) ,2(월) ~ 7(토), 그렇기에 여기다가 -1을 해주면 공백수를 얻어옴

	//--달력에 일정을 3개씩 표현하기 위한 일정목록 구하기(clist구하기)
	CalDao dao = new CalDao();
	String yyyyMM = year + Util.isTwo(String.valueOf(month)); //yyyyMM 6자리구하기 ,month가 int이므로 String으로 바꿔줌
	//	String id = (String)session.getAttribute("ldto").getid(); //로그인 된 아이디는 세션에서 구함 , 왜 오류뜨냐..?

	List<CalDto> cList = dao.getCalViewList("hk", yyyyMM);

	//요청할 당시의 현재 년 월을 모르니까 달력 표현은 Separation방식으로 만들었다.
%>






<body>
	<h1>일정보기</h1>
	<table id="calendar">
		<caption>
			<a href="calendar.jsp?year=<%=year - 1%>&month=<%=month%>">◁</a> <a
				href="calendar.jsp?year=<%=year%>&month=<%=month - 1%>">◀</a> <span
				class="y"><%=year%></span>년 <span class="m"><%=month%></span>월 <a
				href="calendar.jsp?year=<%=year%>&month=<%=month + 1%>">▶</a> <a
				href="calendar.jsp?year=<%=year + 1%>&month=<%=month%>">▷</a>
		</caption>
		<!--표의 제목을 나타내는 테그 caption -->

		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		</tr>
		<tr>
			<%
				for (int i = 0; i < dayOfWeek - 1; i++) {

					out.print("<td>&nbsp;</td>");
				}
				for (int i = 1; i <= lastday; i++) {
			%>
			<td><a class="countview"
				href="CalController.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>"
				style="color:<%=Util.method((dayOfWeek - 1 + i) % 7)%>;"><%=i%></a> <a
				href="insertCalBoard.jsp?year=<%=year%>&month=<%=month%>&date=<%=i%>&lastday=<%=lastday%> ">
					<img alt="일정추가" src="img/pen.png">
			</a>
				<div class="clist">
					<%=Util.getCalView(i, cList)%>
					<!--i는 현재 날짜 cList는 전체에 대한 일정  -->

				</div></td>
			<%
				//공백 + i 의 갯수가 7개면 띄어준다.
					if ((dayOfWeek - 1 + i) % 7 == 0) { //결과값이 1이면 일요일 0이면 토요일

						out.print("</tr><tr>");

					}

				}
				//7-((공백수 + 마지막날)%7) = 남은공백수
				for (int i = 0; i < (7 - ((dayOfWeek - 1 + lastday) % 7)) % 7; i++) {

					out.print("<td>&nbsp;</td>");

				}
			%>


		</tr>


	</table>
</body>
</html>