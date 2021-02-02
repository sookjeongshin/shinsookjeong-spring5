package kr.or.test;

public class InterfaceApp {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		AllCalc allCalc = new AllCalc();
		allCalc.add(5, 5);
		allCalc.sub(5, 5);
		allCalc.mul(5, 5);
		allCalc.div(5, 5);
	}

}

//인터페이스
interface CalcAddSub {
	void add(double dx, double dy);

	void sub(double dx, double dy);
}

interface CalMulDiv extends CalcAddSub {
	void mul(double dx, double dy);

	void div(double dx, double dy);
}

class AllCalc implements CalcAddSub, CalMulDiv {

	@Override
	public void add(double dx, double dy) {
		// TODO Auto-generated method stub
		System.out.println("더하기 결과는" + dx + dy);
	}

	@Override
	public void sub(double dx, double dy) {
		// TODO Auto-generated method stub
		System.out.println("빼기 결과는 " + (dx - dy));
	}

	@Override
	public void mul(double dx, double dy) {
		// TODO Auto-generated method stub
		System.out.println("곱하기 결과는" + (dx * dy));
	}

	@Override
	public void div(double dx, double dy) {
		// TODO Auto-generated method stub
		System.out.println("나누기 결과는" + (dx / dy));
	}

}