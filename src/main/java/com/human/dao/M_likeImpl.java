package com.human.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.M_likeVO;

@Repository
public class M_likeImpl implements IF_M_likeDAO {

	private static String mapperQuerry = "com.human.dao.IF_M_likeDAO";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public int likeChk(M_likeVO vo) throws Exception { // 추천 안눌렀을때 추천상태 로 바꾸기
		return sqlSession.selectOne(mapperQuerry+".likeChk",vo);
	}

//	@Override
//	public void likeChkCancel(M_likeVO vo) throws Exception { // 추천 이미 눌렀을때 추천상태 취소로 바꾸기 	
//		sqlSession.update(mapperQuerry+".likeChkCancel",vo);
//	}

	@Override
	public void likeAdd(M_likeVO vo) throws Exception { //추천 테이블 튜플 추가
		sqlSession.insert(mapperQuerry+".likeAdd",vo);
	}

	@Override
	public void likeDel(M_likeVO vo) throws Exception { //추천 취소하면 테이블에서 튜플 삭제
		sqlSession.delete(mapperQuerry+".likeDel",vo);
		
	}
	
	
}
