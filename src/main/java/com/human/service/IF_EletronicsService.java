package com.human.service;

import java.util.List;

import com.human.VO.M_CommentVO;
import com.human.VO.M_likeVO;
import com.human.VO.MemberVO;
import com.human.VO.MemoVO;
import com.human.VO.PageVO;

public interface IF_EletronicsService {
	
	//멤버(Member) 테이블 관련
	public void insertOne(MemberVO mvo) throws Exception; // 회원 가입
	public String login(String id,String pw) throws Exception; // 로그인 DB 체크
	public String m_pro(String id) throws Exception; // 멤버 아이디로 프로필 사진 구하기
	public List<MemberVO> myInfo(String id) throws Exception; // 내 정보 조회
	public void myInfoMod(MemberVO vo) throws Exception; // 내정보 수정하기  업데이트
	public void myInfoDel_m_pro(String id) throws Exception; // 내정보 수정하기 프로필 사진 삭제
	public List<MemberVO> allMemberInfo() throws Exception; // 모든 회원 정보가져오기
	public void selMemberDel(String id) throws Exception; // 선택한 회원 탈퇴
	public int checkId(String id) throws Exception; // 아이디 중복체크 비동기
	
	//메모(Memo) 테이블 관련
	public void memoInsertOne(MemoVO vo)throws Exception; // 게시글 작성
	public List<MemoVO> memoSelectAll(PageVO pagevo) throws Exception; // 게시글 리스트로 받기
	public List<MemoVO> memoDatailView(int num) throws Exception; // 게시글 상세보기
	public int totalCount(String sword) throws Exception; // DB를 통해서 총게시물 숫자 가져오자
	public String memoWriteId(int num) throws Exception; // 게시물 작성자 아이디 알아오기
	public int memoNum() throws Exception; // 씨퀀스 게시물 번호 알아오기 
	public List<MemoVO> myMemoSelect(String nowUser) throws Exception; // 내 작성 게시물 가져오기
	public void myMemoMod(MemoVO vo) throws Exception; // 내 게시물 수정하기 업데이트
	public void myMemoDel(int num) throws Exception; // 내 게시물 삭제하기
	public void myMemoAllDel(String id) throws Exception; // 내 모든 게시물 삭제 (회원탈퇴)
	public void memoLike(int num) throws Exception; // 게시물 좋아요 기능
	public void memoLikeDel(int num) throws Exception; // 게시글 추천 취소 기능
	
	//메모 사진(Memo_picture 게시글 사진)테이블 관련
	public void picInsert(int num,String[] pname)throws Exception; // 게시글 사진 첨부
	public List<String> memoNumPic(int num) throws Exception; // 게시글 사진 조회
	public void picDel(java.lang.String delPic) throws Exception; // 게시글 수정 첨부 사진 삭제
	public void MemoNumdelPic(int num) throws Exception;  //나의 해당게시글 모든 사진 삭제(내글 삭제하기)
	
	//코멘트 (M_Comment) 테이블 관련
	public List<M_CommentVO> listAllComment(int num) throws Exception; // 댓글 가져오기
	public void commentAdd(M_CommentVO cvo) throws Exception; // 댓글 등록하기
	public void commentDel(int delComment) throws Exception; // 댓글 삭제하기
	public void commentMod(int m_c_num,String modComment) throws Exception; // 댓글 수정하기
	public void selMemoCommentDel(int num) throws Exception; // 해당 게시글 댓글 삭제하기
	public void myCommentAllDel(String id) throws Exception; // 내 모든 댓글 지우기(회원탈퇴)
	
	//추천 (M_like) 테이블 관련
	public int likeChk(M_likeVO vo)throws Exception; // 추천 안눌렀을때 추천상태 로 바꾸기
//	public void likeChkCancel(M_likeVO vo) throws Exception; // 추천 이미 눌렀을때 추천상태 취소로 바꾸기
	public void likeAdd(M_likeVO vo) throws Exception; //추천 테이블 튜플 추가
	public void likeDel(M_likeVO vo) throws Exception; //추천 취소하면 테이블에서 튜플 삭제
}
