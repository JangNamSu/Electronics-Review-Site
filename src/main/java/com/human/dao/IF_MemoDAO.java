package com.human.dao;

import java.util.List;

import com.human.VO.MemoVO;
import com.human.VO.PageVO;

public interface IF_MemoDAO {
	
	public void memoInsertOne(MemoVO vo) throws Exception; // 게시글 작성
	public List<MemoVO> memoSelectAll(PageVO pagevo) throws Exception; // 게시글 작성목록 가져오기
	public List<MemoVO> memoDatailView(int num) throws Exception; // 게시글 상세보기
	public int totalCount(String sword) throws Exception; // DB를 통해서 총게시물 숫자 가져오자
	public void memoViewCntUpdate(int num) throws Exception; // 조회수 업데이트
	public String memoWriteId(int num) throws Exception; // 작성자 글번호로 알아내기
	public int memoNum() throws Exception; // 씨퀀스 작성글 번호 알아내기
	public List<MemoVO> myMemoSelect(String nowUser) throws Exception; // 내 게시물 목록 가져오기
	public void myMemoMod(MemoVO vo) throws Exception; // 내 게시물 수정하기 업데이트
	public void myMemoDel(int num) throws Exception; // 내 게시물 삭제하기
	public void myMemoAllDel(String id)throws Exception; // 내 모든게시물 삭제 (회원탈퇴)
	public void memoLike(int num) throws Exception; // 게시물 좋아요 기능
	public void memoLikeDel(int num) throws Exception; // 게시물 추천 취소 기능
}
