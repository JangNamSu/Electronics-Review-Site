package com.human.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.MemberVO;

@Repository 
public class MemberImpl implements IF_MemberDAO{

	private static String mapperQuerry = "com.human.dao.IF_MemberDAO";
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void insertOne(MemberVO mvo) throws Exception { // 회원가입
		
		sqlSession.insert(mapperQuerry+".insert",mvo);
	}

	@Override
	public String login(String id, String pw) throws Exception { // 로그인 DB정보 체크
		
		HashMap<String,String> datamap = new HashMap<String,String>();
		datamap.put("id", id);
		datamap.put("pw", pw);
		
		return sqlSession.selectOne(mapperQuerry+".login",datamap);
	}

	@Override
	public String m_pro(String id) throws Exception { // 멤버 프로필사진 조회
		return sqlSession.selectOne(mapperQuerry+".m_pro",id);
	}

	@Override
	public List<MemberVO> myInfo(String id) throws Exception { // 나의 정보 조회
		return sqlSession.selectList(mapperQuerry+".myInfo",id);
	}

	@Override
	public void myInfoMod(MemberVO vo) throws Exception { // 내정보 수정하기  업데이트
		sqlSession.update(mapperQuerry+".myInfoMod",vo);
	}

	@Override
	public void myInfoDel_m_pro(String id) throws Exception { // 내정보 수정하기 프로필 사진 삭제
		sqlSession.update(mapperQuerry+".myInfoDel_m_pro",id);
	}

	@Override
	public List<MemberVO> allMemberInfo() throws Exception { // 모든 회원 정보가져오기
		return sqlSession.selectList(mapperQuerry+".allMemberInfo");
	}

	@Override
	public void selMemberDel(String id) throws Exception { // 선택한 회원 탈퇴
		sqlSession.delete(mapperQuerry+".selMemberDel",id);
	}

	@Override
	public int checkId(String id) throws Exception { // 아이디 중복체크 비동기
		
		return sqlSession.selectOne(mapperQuerry+".checkId",id);
	}

}
