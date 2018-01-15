package com.hk.caldaos;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {

private SqlSessionFactory sqlSessionFactory;
	
	public SqlSessionFactory getSqlSessionFactory() {
		//sqlSessionFactory에 작업지시를 하기 위해 
		//mybatis에서 구현해놓은 Resouces의 getResoueceAsReader라는 메소드가
		//환경설정파일경로를 읽어 reader에 전달해주고 결과적으로 그 변수에 환경설정파일을 담아서 sqlSessionFactory에 전달해주어 환결성정파일의 경로를 알게끔한다.

		//mybatis에서 1단계~5단계의 작업을 하기위해서 sqlSessionFactory에 환경설정파일의경로(즉 1단계와 5단계의 작업이있는)를 알게해주어서 이걸 호출할경우 
		//1단계와 5단계의 작업을 알아서 할수 있게 하는것이다. 그 과정에서 Resources.getResourceAsReader(resource)로 환경설정파일 경로를 적은다음 그 적은경로를 받은 reader변수를 
		// new SqlSessionFactoryBuilder().build()을 통해서sqlSessionFactory에 보내준다.

		//이게 왜 싱글턴 ? if문 써주어서 반복될시 한번만 객체생성을 해야하는거 아닐까 ? 근데 여기서는 알아서 그 if문 작업을 해줌 ..
		String resource = "com/hk/sql/Configuration.xml"; //환경설정파일 경로
		
	
		try {
			//java.io(input ouput) 즉 입력이나 출력의 역할을 한다고 생각하자
			//Reader : 메모지 , Resources: 메모지를 만드는 객체 , getResourceAsReader(): 메모지에 메모를 한다, 그 메모내용은 resource객체
			Reader reader = Resources.getResourceAsReader(resource); //Resources를 import할때 ibatis.io껄 가지고 와야한다. 다른것들도 많으니 조심
			
			// SqlSessionFactoryBuilder():sqlSessionFactory객체를 구하는 녀석
			// build(): 메모지 전달
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
			
			reader.close(); //io는 꺼냈으면 닫아줘야한다.
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return sqlSessionFactory;
				
	}
		
}	