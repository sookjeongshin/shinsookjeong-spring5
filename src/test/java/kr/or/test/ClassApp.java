package kr.or.test;

public class ClassApp {

	public static void main(String[] args) {
		//
		Circle c = new Circle(5);// 인스턴스(오브젝트 클래스)변수 c 생성 new 키워드 생성자circle(반지름값5)
		// 위에서 new 키워드는 프로그램 실행공간을 메모리에 새로 할당한다는 이야기 입니다.
		Circle c2 = new Circle(10);
		double print_result = c.getshinsookjeong();
//System.out.println("원의 넓이는"+ print_result+"입니다.");
		double print_result2 = c2.getshinsookjeong();
//System.out.println("두번째 원의 넓이는" + print_result2 + "입니다.");

		Employee employee = new Employee();
		Salesman salesman = new Salesman();
		Development development = new Development();
		// employee.doJob();
		// salesman.doJob();
		// development.doJob();
		GraphicObject graphicObject = new Triangle();
		graphicObject.draw();
	}
}

// 추상클래스에 대한 연습(아래)
abstract class GraphicObject {
	int x, y; // 그래픽오브젝트 클래스 멤버변수 선언

	abstract void draw();// 명세만 있는 구현내용이 없는 추상메서드 선언
}

class Triangle extends GraphicObject {

	@Override
	void draw() {
		System.out.println(" *");
		System.out.println(" * * ");
		System.out.println("*****");
	}

}

class Employee {
	int nSalary;
	String szDept;

	public void doJob() {
		System.out.println("환영합니다. 직원분들!");
	}
}

class Salesman extends Employee {
	public Salesman() {
		szDept = "판매 부서";
	}

	public void doJob() {
		System.out.println("환영합니다. 판매부서 입니다!");
	}
}

class Development extends Employee {
	public Development() {
		szDept = "개발 부서";
	}

	public void doJob() {
		System.out.println("환영합니다." + szDept + "입니다!");
	}
}

class Circle {
	private int r;// 멤버변수 반지름 이클래스에서 전연변수

	public Circle(int a) {// 생성자매서드 a인자=매개변수=파라미터 값은 new키워드로 오브젝트 만들어질때 발생
		r = a;
	}

	public double getshinsookjeong() {
		return r * r * 3.14;// 원의 넓이를 반환
	}
}
