package com.human.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.M_CommentVO;

@Repository
public class M_CommentImpl implements IF_M_CommentDAO{

	private static String mapperQuerry ="com.human.dao.IF_M_CommentDAO";
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void commentAdd(M_CommentVO cvo) throws Exception { // 댓글 등록
		sqlSession.insert(mapperQuerry+".commentAdd",cvo);
	}

	@Override
	public List<M_CommentVO> listAllComment(int num) throws Exception { //댓글 가져오기
		return sqlSession.selectList(mapperQuerry+".selectAll",num);
	}

	@Override
	public void commentDel(int delComment) throws Exception { // 댓글 삭제하기
		sqlSession.delete(mapperQuerry+".commentDel",delComment);
	}

	@Override
	public void commentMod(int m_c_num, String modComment) throws Exception { // 댓글 수정하기
		
		HashMap<String,String> datamap = new HashMap<String,String>();
		datamap.put("m_c_num", m_c_num+"");
		datamap.put("modComment", modComment);
		
		sqlSession.update(mapperQuerry+".commentMod",datamap);
	}

	@Override
	public void selMemoCommentDel(int num) throws Exception { // 해당 게시글 댓글 삭제하기
		sqlSession.delete(mapperQuerry+".selMemoCommentDel",num);
	}

	@Override
	public void myCommentAllDel(String id) throws Exception { // 내 모든 댓글 지우기(회원탈퇴)
		sqlSession.delete(mapperQuerry+".myCommentAllDel",id);
	}

}
