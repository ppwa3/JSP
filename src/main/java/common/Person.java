package common;

public class Person {
	//멤버변수 : 접근지정자는 무조건 private
	private String name;
	private int age;
	//기본생성자
	public Person() {}
	//인수생성자
	public Person(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}
	//게터&세터 메서드 정의
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	
	
}
