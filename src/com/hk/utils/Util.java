package com.hk.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import com.hk.caldtos.CalDto;


//잡다한 기능들을 모아둔 클래스
public class Util {
	
	private String toDates;
	
	//달력에서 토요일,일요일의 폰트색을 변환해주는 메서드
	public static String method(int i){
		String str = "";
		
		if(i==0){
		str="blue";
		}else if(i==1){
		str="red";
		}else{
		str="black";
		}
	
		
		return str;
	}
	
	//한자리수를 두자릿수로 변환하는 메서드
	public static String isTwo(String msg) {
		
		return msg.length()<2?"0"+msg:msg; //파라미터에 3이들어가면 03으로 바꿔줌!
										   //파리미터에 11이 들어가면 그대로 돌려줌
	}

	//문자열을 날짜형식으로 표현하는 메서드 
	//date형식:yyyy-MM-dd hh:mm:ss
	
	public void setToDates(String mDate) {
		
		String m =mDate.substring(0, 4)+"-"
				+mDate.substring(4,6)+"-"
				+mDate.substring(6,8)+" " //공백 띄어야한다.
				+mDate.substring(8,10)+":"
				+mDate.substring(10)+":00"; //substring(10)은 처음부터 10까지 자르겠다.즉나머지를 구함
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd HH시mm분"); //날짜형식을 자기가 원하는걸로 바꿔줌
		Timestamp tm = Timestamp.valueOf(m); //문자열을 날짜형식으로 변환 , Timestamp는 java.sql껄 import해야함	
		
		this.toDates=sdf.format(tm); //문자열을 날짜형식으로 변환한것을 자기가원하는모습으로 바꿔준값을 맴버필드에 저장
		
	}
	public String getToDates() {
		return this.toDates;
	}
	
	//달력에 일정 일부를 일별로 출력하는 기능
	public static String getCalView(int i, List<CalDto> clist) {
		
		String d =isTwo(i+"");// 9 --> 09로 바꿔줌 +""를 왜 붙였냐 ? i의 타입이 int이므로 String으로 만들어주기위해 concat해줌
		String calList = ""; //"<p>title</p><p>title</p><p>title</p>"
		
		for(CalDto dto : clist) {
			
			if(dto.getmDate().substring(6,8).equals(d)) {
				calList+="<p>"
						+(dto.getTitle().length()>6?dto.getTitle().substring(0,5)+"....":dto.getTitle())
						+"</p>";
			}	
			
		}
		return calList;
	}

}
