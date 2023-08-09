package com.human.VO;

public class PageVO {
	
	private int startNo; // 페이지에 출력할 게시물의 시작 번호 > 데이터 베이스 정렬 후 가져올 튜플의 시작
	private int endNo;	// 페이지에 출력할 게시물의 마지막 번호 > 데이터베이스 정렬 후 가져올 튜플의 마지막
	
	private int perPageNum = 10; // 2가지 의미 1. 페이지에 출력 할 게시물의 수, 2. 페이지의 그룹의 수
	private Integer page; // 현재 페이지.. 클라이언트로 부터 정보를 받는다.. 그래서 Integer로 선언함
	
	private int totalCount; // 전체 게시물 수.. select count(*) from memo
	
	private int startPage;	// 페이지 그룹의 시작 번호
	private int endPage;	// 페이지 그룹의 마지막 번호
	
	private boolean prev;	// 이전 페이지 그룹이 있는가?
	private boolean next;	// 이후 페이지 그룹이 있는가?
	
	private String search_word;
	

	public void calcPage() { // 페이지 계산 알고리즘 메서드.
		// 페이지에 출력할 게시물의 시작 번호
		startNo = (page-1)*perPageNum+1;
		
		// startPage 계산
		// 마지막 페이지를 계산..
		// 마지막 페이지 정보로 시작페이지를 계산..
		// 마지막 페이지는 유동적이다 왜냐면 게시물의 수에 따라 마지막 페이지가 달라 질 수 있다..
		
		int tempEndPage= (int)(Math.ceil(page/(double)perPageNum)*perPageNum);
		
		startPage= (tempEndPage-perPageNum)+1;
		
		if(tempEndPage * perPageNum > totalCount) {
			endPage = (int)(Math.ceil(totalCount/(double)perPageNum));
			if(endPage != page) { // 마지막 페이지가 아니란 뜻이죠..
				endNo = startNo + perPageNum -1;
			}else { // 마지막 페이지라면
				endNo = startNo + totalCount%10-1;
			}
		}else {
			endPage = tempEndPage;
			endNo = startNo + perPageNum -1;
		}
		prev = startPage != 1;
		next = endPage*perPageNum < totalCount;
		
	}
	
	public String getSearch_word() {
		return search_word;
	}


	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	
	
}
