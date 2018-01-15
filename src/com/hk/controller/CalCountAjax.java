package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hk.caldaos.CalDao;

import net.sf.json.JSONObject;
@WebServlet("/CalCountAjax.do")
public class CalCountAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/json; charset=utf-8");
		
		String id = request.getParameter("id");
		String yyyyMMdd=request.getParameter("yyyyMMdd");
		
		System.out.println("전달값:" + yyyyMMdd);
		
			CalDao dao= new CalDao();
		int count = dao.getCalViewCount(id, yyyyMMdd);
		
		Map<String, Integer>map = new HashMap<String,Integer>();
		map.put("count", count);
		
		JSONObject obj = JSONObject.fromObject(map); //json으로 변환
		
		PrintWriter pw = response.getWriter();//브라우저로 출력하는 프린터 구함
		
		obj.write(pw); //json객체를 받은 프린터를 이용해서 브랑줘로 출력
	}

}
