package com.human.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.human.VO.M_CommentVO;
import com.human.VO.M_likeVO;
import com.human.VO.MemberVO;
import com.human.VO.MemoVO;
import com.human.VO.PageVO;
import com.human.dao.IF_M_CommentDAO;
import com.human.dao.IF_M_likeDAO;
import com.human.dao.IF_MemberDAO;
import com.human.dao.IF_MemoDAO;
import com.human.dao.IF_MemoPictureDAO;

@Service
public class EletronicsServiceImpl implements IF_EletronicsService {

	@Inject
	private IF_MemberDAO memberdao;
	@Inject
	private IF_MemoDAO memodao;
	@Inject
	private IF_MemoPictureDAO memopicdao;
	@Inject
	private IF_M_CommentDAO m_commentdao;
	@Inject
	private IF_M_likeDAO m_likedao;
	
	@Override
	public void insertOne(MemberVO mvo) throws Exception { // 회원 가입
		memberdao.insertOne(mvo);
	}

	@Override
	public void memoInsertOne(MemoVO vo) throws Exception { // 게시글 작성
		memodao.memoInsertOne(vo);
	}

	@Override
	public List<MemoVO> memoSelectAll(PageVO pagevo) throws Exception { // 게시글 리스트로 받기
		return memodao.memoSelectAll(pagevo);
	}

	@Override
	public List<MemoVO> memoDatailView(int num) throws Exception { // 게시글 상세보기
		memodao.memoViewCntUpdate(num);
		return memodao.memoDatailView(num);
	}

	@Override
	public int totalCount(String sword) throws Exception { // DB를 통해서 총게시물 숫자 가져오자
		return memodao.totalCount(sword);
	}

	@Override
	public String login(String id, String pw) throws Exception { // 로그인 DB 체크
		return memberdao.login(id, pw);
	}

	@Override
	public String memoWriteId(int num) throws Exception { // 게시물 작성자 아이디 알아오기
		return memodao.memoWriteId(num);
	}

	@Override
	public String m_pro(String id) throws Exception { // 멤버 아이디로 프로필 사진 구하기
		return memberdao.m_pro(id);
	}

	@Override
	public void picInsert(int num, String[] pname) throws Exception { // 게시글 사진 첨부
		memopicdao.picInsert(num, pname);
	}

	@Override
	public int memoNum() throws Exception { // 씨퀀스 게시물 번호 알아오기 
		return memodao.memoNum();
	}

	@Override
	public List<String> memoNumPic(int num) throws Exception { // 게시글 사진 리스트 조회
		return memopicdao.memoNumPic(num);
	}

	@Override
	public void commentAdd(M_CommentVO cvo) throws Exception { // 게시글 상세보기에서 댓글 남기기
		m_commentdao.commentAdd(cvo);
		
	}

	@Override
	public List<M_CommentVO> listAllComment(int num) throws Exception { // 댓글 가져오기
		return m_commentdao.listAllComment(num);
	}

	@Override
	public void commentDel(int delComment) throws Exception { // 댓글 삭제하기	
		m_commentdao.commentDel(delComment);
	}

	@Override
	public void commentMod(int m_c_num, String modComment) throws Exception { // 댓글 수정하기
		m_commentdao.commentMod(m_c_num, modComment);
	}

	@Override
	public List<MemoVO> myMemoSelect(String nowUser) throws Exception { // 내 작성 게시물 가져오기
		return memodao.myMemoSelect(nowUser);
	}

	@Override
	public void picDel(java.lang.String delPic) throws Exception { // 게시글 수정 첨부 사진 삭제
		memopicdao.picDel(delPic);
	}

	@Override
	public void myMemoMod(MemoVO vo) throws Exception { // 내 게시물 수정하기 업데이트
		memodao.myMemoMod(vo);
	}

	@Override
	public void myMemoDel(int num) throws Exception { // 내 게시물 삭제하기
		memodao.myMemoDel(num);
		
	}

	@Override
	public void MemoNumdelPic(int num) throws Exception {	//나의 해당게시글 모든 사진 삭제(내글 삭제하기)
		memopicdao.MemoNumdelPic(num);
	}

	@Override
	public List<MemberVO> myInfo(String id) throws Exception { // 내 정보 조회
		return memberdao.myInfo(id);
	}

	@Override
	public void myInfoMod(MemberVO vo) throws Exception { //내정보 수정하기  업데이트
		memberdao.myInfoMod(vo);
	}

	@Override
	public void myInfoDel_m_pro(String id) throws Exception { //내정보 수정하기 프로필 사진 삭제
		memberdao.myInfoDel_m_pro(id);
	}

	@Override
	public void selMemoCommentDel(int num) throws Exception { // 해당 게시글 댓글 삭제하기
		m_commentdao.selMemoCommentDel(num);
	}

	@Override
	public List<MemberVO> allMemberInfo() throws Exception { // 모든 회원 정보 가져오기
		return memberdao.allMemberInfo();
	}

	@Override
	public void selMemberDel(String id) throws Exception { // 선택한 회원 탈퇴
		memberdao.selMemberDel(id);
	}

	@Override
	public void myMemoAllDel(String id) throws Exception { // 내 모든 게시물 삭제(회원탈퇴)
		memodao.myMemoAllDel(id);
	}

	@Override
	public void myCommentAllDel(String id) throws Exception { // 내 모든 댓글 삭제 (회원탈퇴)
		m_commentdao.myCommentAllDel(id);
	}

	@Override
	public void memoLike(int num) throws Exception {  // 게시물 좋아요 기능
		memodao.memoLike(num);
	}
	
	@Override
	public void memoLikeDel(int num) throws Exception { // 게시글 추천 취소 기능
		memodao.memoLikeDel(num);
	}

	@Override
	public int checkId(String id) throws Exception { // 아이디 중복체크 비동기
		return memberdao.checkId(id);
	}

	@Override
	public int likeChk(M_likeVO vo) throws Exception { // 추천 안눌렀을때 추천상태 로 바꾸기
		return m_likedao.likeChk(vo);
	}

//	@Override
//	public void likeChkCancel(M_likeVO vo) throws Exception { // 추천 이미 눌렀을때 추천상태 취소로 바꾸기
//		m_likedao.likeChkCancel(vo);
//	}

	@Override
	public void likeAdd(M_likeVO vo) throws Exception { //추천 테이블 튜플 추가
		m_likedao.likeAdd(vo);
	}

	@Override
	public void likeDel(M_likeVO vo) throws Exception { // 추천 취소시 튜플 삭제
		m_likedao.likeDel(vo);
	}


	
	

}
