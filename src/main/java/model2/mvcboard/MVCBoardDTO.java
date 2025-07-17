package model2.mvcboard;

//mvcboard 테이블의 레코드를 저장하기 위한 DTO 클래스
public class MVCBoardDTO {
	//멤버변수 : 컬럼과 동일하게 생성
	private String idx;
	private String id;
	private String title;
	private String content;
	//날짜타입이므로 Date형으로 선언
	private java.sql.Date postdate;
	private String ofile;//원본파일명
	private String sfile;//저장된파일명
	//카운트는 +1 연산을 해야하므로 int형으로 선언
	private int downcount;
	private int visitcount;
	/*
	회원의 이름을 출력하기 위해서 member 테이블과 join을 걸어야 하므로
	name 컬럼도 추가한다. */
	private String name;
	
	//생성자는 특별한 이유가 없다면 생략해도 됨
	//컴파일러에 의해 디폴트 생성자가 만들어지기 때문
	
	
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
	public int getDowncount() {
		return downcount;
	}
	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}
	public int getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(int visitcount) {
		this.visitcount = visitcount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
