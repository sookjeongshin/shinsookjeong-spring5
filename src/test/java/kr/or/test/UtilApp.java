package kr.or.test;

public class UtilApp {

	public static void main(String[] args) {
		// 클래스 실행 진입점
		// java.lang.Math클래스를 사용해서 랜덤하게 숫자를 뽑아 봅니다.
		System.out.println("1부터 30까지 제비뽑기 숫자 출력하기= " + (int) (Math.random() * 30)
				// 결과가 float(실수)로 나오기때문에, 정수형(int)으로 형변환해서 출력
		);
	}

}
