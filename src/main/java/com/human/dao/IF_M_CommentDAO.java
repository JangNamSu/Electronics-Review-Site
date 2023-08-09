package com.human.dao;

import java.util.List;

import com.human.VO.M_CommentVO;

public interface IF_M_CommentDAO {
	
	public void commentAdd(M_CommentVO cvo) throws Exception; // 댓글 등록하기
	public List<M_CommentVO> listAllComment(int num) throws Exception; // 댓글 가져오기
	public void commentDel(int delComment) throws Exception; // 댓글 삭제하기
	public void commentMod(int m_c_num,String modComment) throws Exception; // 댓글 수정하기
	public void selMemoCommentDel(int num) throws Exception; // 해당 게시글 모든댓글 삭제하기
	public void myCommentAllDel(String id) throws Exception; // 내 모든 댓글 지우기 // 회원탈퇴
}
