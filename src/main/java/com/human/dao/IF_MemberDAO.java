package com.human.dao;

import java.util.List;

import com.human.VO.MemberVO;

public interface IF_MemberDAO {
	
	public void insertOne(MemberVO mvo) throws Exception; // 회원가입
	public String login(String id,String pw) throws Exception; // 로그인 DB 체크
	public String m_pro(String id) throws Exception; // 멤버 프로필사진 구하기
	public List<MemberVO> myInfo(String id) throws Exception; // 나의 정보 조회 
	public void myInfoMod(MemberVO vo) throws Exception; // 내정보 수정하기  업데이트
	public void myInfoDel_m_pro(String id) throws Exception; // 내정보 수정하기 프로필 사진 삭제
	public List<MemberVO> allMemberInfo() throws Exception; // 모든 회원 정보 가져오기
	public void selMemberDel(String id) throws Exception; // 선택한 회원 탈퇴
	public int checkId(String id) throws Exception; // 아이디 중복 체크
}
