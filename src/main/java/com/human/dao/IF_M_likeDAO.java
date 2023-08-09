package com.human.dao;

import com.human.VO.M_likeVO;

public interface IF_M_likeDAO {
	
	public int likeChk(M_likeVO vo) throws Exception; // 추천 안눌렀을때 추천상태 로 바꾸기
//	public void likeChkCancel(M_likeVO vo) throws Exception; // 추천 이미 눌렀을때 추천상태 취소로 바꾸기 
	public void likeAdd(M_likeVO vo) throws Exception; // 추천 테이블 튜플 추가
	public void likeDel(M_likeVO vo) throws Exception; // 추천 취소하면 테이블에서 튜플 삭제
}
