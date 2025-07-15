package test;

public class HelloJava {
	
	//static으로 선언했으므로 인스턴스 생성없이 클래스명으로 직접 호출가능
	public static int myFx() {
		int sum = 0;
		for(int i=1 ; i<=10 ; i++) {
			sum += i;
		}
		return sum;
	}
	
	//일반적인 멤버메서드이므로 인스턴스 생성 후 호출할 수 있다.
	public int myFx(int s, int e) {
		int sum = 0;
		for(int i=s ; i<=e ; i++) {
			sum += i;
		}
		return sum;
	}
	/*
	main() 함수를 단독으로 실행하고 싶다면 Java Application
	을 선택한 후 실행하면된다. */
	public static void main(String[] args) {
		System.out.println("Hello Java..!!");
	}

}
