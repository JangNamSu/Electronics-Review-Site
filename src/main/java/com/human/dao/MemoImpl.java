package com.human.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.human.VO.MemoVO;
import com.human.VO.PageVO;

@Repository
public class MemoImpl implements IF_MemoDAO {

	private static String mapperQuerry = "com.human.dao.IF_MemoDAO";
	
	@Inject
	private SqlSession sqlSession; 
	
	@Override
	public void memoInsertOne(MemoVO vo) throws Exception { // 게시글 작성
		sqlSession.insert(mapperQuerry+".insert",vo);
	}

	@Override
	public List<MemoVO> memoSelectAll(PageVO pagevo) throws Exception { // 게시글 작성목록 가져오기
		
		sqlSession.update(mapperQuerry+".updateCommentCnt"); //게시글에 댓글 몇개인지 조회
		
		return sqlSession.selectList(mapperQuerry+".selectAll",pagevo);
	}

	@Override
	public List<MemoVO> memoDatailView(int num) throws Exception { // 게시글 상세보기
		return sqlSession.selectList(mapperQuerry+".datailView",num);
	}

	@Override
	public int totalCount(String sword) throws Exception { // DB를 통해서 총게시물 숫자 가져오자
		return sqlSession.selectOne(mapperQuerry+".memoCount",sword);
	}

	@Override
	public void memoViewCntUpdate(int num) throws Exception { // 조회수 업데이트
		sqlSession.update(mapperQuerry+".viewCntUpdate",num);
	}

	@Override
	public String memoWriteId(int num) throws Exception { // 작성자 글번호로 알아내기
		return sqlSession.selectOne(mapperQuerry+".memoWriteId",num);
	}

	@Override
	public int memoNum() throws Exception { // 씨퀀스 작성글 번호 알아내기
		return sqlSession.selectOne(mapperQuerry+".memoNum");
	}

	@Override
	public List<MemoVO> myMemoSelect(String nowUser) throws Exception { // 내 게시물 목록 가져오기
	
		sqlSession.update(mapperQuerry+".updateCommentCnt"); //게시글에 댓글 몇개인지 조회
		return sqlSession.selectList(mapperQuerry+".myMemoSelect",nowUser);
	}

	@Override
	public void myMemoMod(MemoVO vo) throws Exception { // 내 게시물 수정하기 업데이트
		sqlSession.update(mapperQuerry+".myMemoMod",vo);
	}

	@Override
	public void myMemoDel(int num) throws Exception { // 내 or (관리자) 게시물 삭제하기
		sqlSession.delete(mapperQuerry+".myMemoDel",num);
	}

	@Override
	public void myMemoAllDel(String id) throws Exception { // 내 모든 게시물 삭제 (회원탈퇴)
		sqlSession.delete(mapperQuerry+".myMemoAllDel",id);
	}

	@Override
	public void memoLike(int num) throws Exception { // 게시물 좋아요 기능
		sqlSession.update(mapperQuerry+".memoLike",num);
	}

	@Override
	public void memoLikeDel(int num) throws Exception { // 게시글 추천 취소 기능
		sqlSession.update(mapperQuerry+".memoLikeDel",num);
	}

}
