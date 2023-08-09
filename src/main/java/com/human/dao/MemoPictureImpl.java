package com.human.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MemoPictureImpl implements IF_MemoPictureDAO {

	private static String mapperQuery = "com.human.dao.IF_MemoPictureDAO";
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void picInsert(int num, String[] pname) throws Exception { // 게시글 사진 첨부
		
		HashMap<String, String> datamap = new HashMap<String, String>();

		for(int i = 0; i < pname.length; i++) {
			if(pname[i] != null) {
				datamap.put("num", num + "");
				datamap.put("pname", pname[i]);
				sqlSession.insert(mapperQuery + ".picInsert", datamap);
			}
		}
	}

	@Override
	public List<String> memoNumPic(int num) throws Exception { // 게시글 사진 조회
		
		return sqlSession.selectList(mapperQuery+".memoNumPic",num);
	}

	@Override
	public void picDel(java.lang.String delPic) throws Exception { // 게시글 수정 첨부 사진 삭제
		sqlSession.delete(mapperQuery+".delPic",delPic);
	}

	@Override
	public void MemoNumdelPic(int num) throws Exception { //나의 해당게시글 모든 사진 삭제(내글 삭제하기)
		sqlSession.delete(mapperQuery+".MemoNumdelPic",num);
		
	}
}
