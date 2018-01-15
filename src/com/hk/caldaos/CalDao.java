package com.hk.caldaos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hk.caldtos.CalDto;

public class CalDao extends SqlMapConfig{
	
	
	private String namespace ="com.hk.calboard.";
	
	public CalDao() {
	}
	
	//일정추가(insert문)
	public boolean insertCalBoard(CalDto dto) {
		int count =0;
		SqlSession sqlSession = null;
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(namespace+"insertboard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return count>0?true:false;
	}
	//일정목록조회(select문ㅡlist)
	public List<CalDto> getCalList(String id,String yyyyMMdd){
		Map<String, String>map = new HashMap<String,String>();
		map.put("id", id);
		map.put("yyyyMMdd", yyyyMMdd);
		
		List<CalDto> list =null;
		
		SqlSession sqlSession=null;
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			list=sqlSession.selectList(namespace+"callist", map); //여러개의 결과값을 받으므로 selectList
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}

		return list;
		
	}
	//일정상세조회(select문,반환 CalDto)
	public CalDto getCalBoard(int seq) {
		CalDto dto =null;
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("seq", seq);
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(namespace+"caldetail", map); //한개의 결과값을 받으므로 selectOne
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		
		return dto;
				
	}
	//일정수정하기(update문)
	public boolean updateCalBoard(CalDto dto) {
		int count =0;
		SqlSession sqlSession =null;
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count = sqlSession.update(namespace+"calupdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return count>0?true:false;
		
	}
	//일정삭제하기(delete문)
	public boolean mulDel(String[] seqs) {
		int count =0;
		SqlSession sqlSession =null;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seqs", seqs);
		try {
			sqlSession=getSqlSessionFactory().openSession(false); // autocommit을 취소한다.why? 하나가실패해도 다 원래상태로 바꿔주기 위해서 
			count = sqlSession.delete(namespace+"calMuldel", map);//예전에는 batch()라는곳에 담아서한꺼번에 쿼리를 실행시켜주었는데 
																  //지금은 dataMapper에서 결과처리를 알아서 다해주니까 성공여부만 판단하면된다.
			sqlSession.commit(); //autocommit을 취소했으므로 다시 전부를 commit해주기 위해 commit()해줌.
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return count>0?true:false;
	}
	
	
	
	//일정조회:달력에 일부를 보여주는 조화(3개 일정보이게 하기)(select문)
	public List<CalDto> getCalViewList(String id, String yyyyMM){
		
		List<CalDto> list =null;
		Map<String, String>map = new HashMap<String,String>();
		map.put("id", id);
		map.put("yyyyMM", yyyyMM);
		
		SqlSession sqlSession =null;
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			list=sqlSession.selectList(namespace+"calViewList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		
		return list;
	}
	
	//일정개수를 보여주는 기능(select문)
	public int getCalViewCount(String id,String yyyyMMdd) {
		int count =0;
		Map<String,String> map = new HashMap<String,String>();
		map.put("id", id);
		map.put("yyyyMMdd", yyyyMMdd);
		SqlSession sqlSession=null;
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count = sqlSession.selectOne(namespace+"calCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
						
		return count;
	}

}
