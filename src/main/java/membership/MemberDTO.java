package membership;

/*
DTO(Data Transfer Object)
:JSP와 Java간에 데이터를 전달하기 위한 객체로 자바빈 규약에 의해 제작한다.

자바빈즈 규약(자바클래스라고 말하면된다.)
1.자바빈즈는 기존(default) 패키지 이외의 패키지에 속해야한다.
2.멤버변수의 접근지정자는 private으로 선언한다.
3.기본생성자가 있어야한다.
4.멤버변수에 접근하기 위한 getter/setter메서드가 있어야한다.
5.getter/setter의 접근지정자는 public으로 선언한다.
 * */
public class MemberDTO { //자바빈즈
	//멤버변수 : 일반적으로 테이블의 컬럼과 동일하게 생성한다.
	private String id;
	private String pass;
	private String name;
	private String regidate;
	
	/*
	생성자의 경우 꼭 필요한 경우가 아니라면 생략한다.
	이 경우 디폴트(기본)생성자가 컴파일러에 의해 자동으로 추가되기 때문이다. */
	
	/*
	정보은닉된 멤버변수에 접근하기 위해 public으로 정의된 getter/setter
	메서드를 정의한다.*/
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	
}
