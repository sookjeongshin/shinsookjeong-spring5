package org.edu.vo;

import java.util.Date;

/**
 * replyVO클래스는 댓글 데이터 입출력을 담당하는 데이터클래스
 * 
 * @author 신숙정
 * 
 */

public class ReplyVO {
	// 멤버변수 생성(아래)
	private Integer rno; // 댓글 고유번호(자동증가Auto Increase)
	private Integer bno; // 부모 게시글 번호(고유번호, 외래키-참조키)
	private String reply_text; // 댓글 내용
	private String replyer; // 댓글작성자
	private Date reg_date;
	private Date update_date; // 댓글 수정일

	public Integer getRno() {
		return rno;
	}

	public void setRno(Integer rno) {
		this.rno = rno;
	}

	public Integer getBno() {
		return bno;
	}

	public void setBno(Integer bno) {
		this.bno = bno;
	}

	public String getReply_text() {
		return reply_text;
	}

	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}

	public String getReplyer() {
		return replyer;
	}

	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public Date getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}

}
