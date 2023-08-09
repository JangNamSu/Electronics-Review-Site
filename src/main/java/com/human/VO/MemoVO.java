package com.human.VO;

public class MemoVO {
	
	private String m_id;
	private int m_num=0;
	private String m_title;
	private String m_con;
	private int m_com_cnt=0;
	private int m_view_cnt=0;
	private int m_like=0;
	private String m_date;
	
	public String getM_date() {
		return m_date;
	}
	public void setM_date(String m_date) {
		this.m_date = m_date;
	}
	private String[] m_pic;
	
	public String[] getM_pic() {
		return m_pic;
	}
	public void setM_pic(String[] m_pic) {
		this.m_pic = m_pic;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public int getM_num() {
		return m_num;
	}
	public void setM_num(int m_num) {
		this.m_num = m_num;
	}
	public String getM_title() {
		return m_title;
	}
	public void setM_title(String m_title) {
		this.m_title = m_title;
	}
	public String getM_con() {
		return m_con;
	}
	public void setM_con(String m_con) {
		this.m_con = m_con;
	}
	public int getM_com_cnt() {
		return m_com_cnt;
	}
	public void setM_com_cnt(int m_com_cnt) {
		this.m_com_cnt = m_com_cnt;
	}
	public int getM_view_cnt() {
		return m_view_cnt;
	}
	public void setM_view_cnt(int m_view_cnt) {
		this.m_view_cnt = m_view_cnt;
	}
	public int getM_like() {
		return m_like;
	}
	public void setM_like(int m_like) {
		this.m_like = m_like;
	}
	
	
	
}
