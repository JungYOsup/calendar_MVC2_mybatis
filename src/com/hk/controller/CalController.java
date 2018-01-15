package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hk.caldaos.CalDao;
import com.hk.caldtos.CalDto;
import com.hk.utils.Util;

@WebServlet("/CalController.do")
public class CalController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");//브라우저가 읽게 되는 정보들(ajax일떄는 text/json)
		
		String command = request.getParameter("command");
		CalDao dao = new CalDao();
		
		if(command.equals("calendar")) {
			response.sendRedirect("calendar.jsp"); //sevlet에서는 pageContext를 쓸수가 없다.
			
		}else if(command.equals("inserCal")) {
			//mdate에 추가될 내용 5개 값
			String year = request.getParameter("year");//2018
			String month = request.getParameter("month");//1
			String date = request.getParameter("date");//11
			String hour = request.getParameter("hour");//11
			String min = request.getParameter("min");//31
			//만약 이 상태로 데이터베이스에 넣게 되면 20181111131이라고 넣어지므로 
			//우리는 11자리가 아닌 12자리를 넣어야한다. 따라서 한자리 수에 0을 넣어주는 작업을 하자
			//mdate는 12자리:201801111131 -- 12자리로 변환을 해주어야한다.
			String mdate = year+Util.isTwo(month)+Util.isTwo(date)+Util.isTwo(hour)+Util.isTwo(min);
			
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			boolean isS = dao.insertCalBoard(new CalDto(0,id,title,content,mdate,null));
			if(isS) {
				response.sendRedirect("CalController.do?command=calendar");
			}else {
				request.setAttribute("msg", "일정추가에 실패했어요 ㅜㅜ");
				dispatch("error.jsp", request, response);
				
			}
		
		}else if(command.equals("callist")) {
			String year = request.getParameter("year");//2018
			String month = request.getParameter("month");//1
			String date = request.getParameter("date");//11
			String yyyyMMdd = year+Util.isTwo(month)+Util.isTwo(date);
			
			HttpSession session=request.getSession();
			session.setAttribute("ymd", yyyyMMdd); //일정목록을 조회를 위해 session에 년월일 값을 담아놓기
			
			//로그인 정보에서 아이디정보를 구함(session스코프에서)
//			LoginDto ldto= request.getSession().getAttribute("ldto");
//			String id =ldto.getid()
			List<CalDto>list = dao.getCalList("hk", yyyyMMdd);
			
			request.setAttribute("lists", list);
			dispatch("callist2.jsp", request, response);
			
		}else if(command.equals("muldel")) {
			String []seqs = request.getParameterValues("chk");
			HttpSession session = request.getSession();    //session을 만들고
			String ymd=(String)session.getAttribute("ymd");//session안에 있는 값을 가져오기, 여기서 왜 session을 가져왔을까? 
														   //우리가 callist에 이동하려면 year , month, date를 주어야하는데
														   //여기서는 가져와서 줄수있는방법이 없기 때문에 session을 이용해서 session에 년월일 값을 넣어주고
														   //여기서 꺼내 사용할수 있기 때문이다.
														   //session에서 꺼낸것은 object타입
			String year = ymd.substring(0, 4);
			String month= ymd.substring(4,6);
			String date = ymd.substring(6);
			
			boolean isS = dao.mulDel(seqs);
			
			if(isS) {
				response.sendRedirect("CalController.do?command=callist&year="+year+"&month="+month+"&date="+date);
			}else {
				request.setAttribute("msg", "글삭제 실패~");
				dispatch("erro.jsp", request, response);
			}
		}else if(command.equals("caldetail")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			CalDto dto = dao.getCalBoard(seq);
			request.setAttribute("dto", dto);
			dispatch("caldetail.jsp", request, response);
		}else if(command.equals("updateForm")) {
			
			int seq = Integer.parseInt(request.getParameter("seq"));
			CalDto dto =dao.getCalBoard(seq);
			request.setAttribute("dto", dto);
			dispatch("updateform.jsp", request, response);
		}else if(command.equals("update")) {
			String year = request.getParameter("year");//2018
			String month = request.getParameter("month");//1
			String date = request.getParameter("date");//11
			String hour = request.getParameter("hour");//11
			String min = request.getParameter("min");//31

			String mdate = year+Util.isTwo(month)+Util.isTwo(date)+Util.isTwo(hour)+Util.isTwo(min);
			
			int seq = Integer.parseInt(request.getParameter("seq"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			
			
			boolean isS=dao.updateCalBoard(new CalDto(seq,title,content,mdate));
									
			if(isS) {
				
				response.sendRedirect("CalController.do?command=caldetail&seq="+seq);
			}else {
				request.setAttribute("msg", "일정수정실패");
				dispatch("error.jsp", request, response);
			}
		}
		
		
	}
	
	public void dispatch(String url,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);

	}
	//굳이 PrintWriter을 해준이유는 ?
	public void jsForward(String msg,String url,HttpServletResponse response) throws IOException{
		
		String str="<script type='text/javascript'>" //script type='text/javascript : 컴퓨터야 이 언어는 자바 스크립트야,자바스크립트로 해석해야해 ! 
				+ "alert('"+msg+"');"
				+ "location.href='"+url+"';"
				+ "</script>";

		PrintWriter pw = response.getWriter();//브라우저에 출력할 전용 프린터를 만든다.//프린터에 출력을 날리는 작업, java파일에서는 브라우저에 출력해줄수 있는게 없기 때문에 브라우저에 출력할 전용 프린터를 만들어야한다
		pw.print(str);//그렇기에 pw에 str파라미터로 넣어주고 그 값을 바로 출력할수 있도록 메서드 print를 쓰는것이다.
	}
	
	

}
