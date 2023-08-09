package com.human.dao;

import java.util.List;

public interface IF_MemoPictureDAO {
	
	public void picInsert(int num,String[] pname)throws Exception; // 게시글 사진 첨부
	public List<String> memoNumPic(int num)throws Exception; // 게시글 사진 조회
	public void picDel(String delPic)throws Exception; // 게시글 수정 첨부 사진 삭제
	public void MemoNumdelPic(int num)throws Exception; //나의 해당게시글 모든 사진 삭제(내글 삭제하기)
}
