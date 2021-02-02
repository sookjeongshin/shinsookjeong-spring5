package kr.or.test;

import java.util.function.IntSupplier;

public class LambdaApp {

	public static int method(int x, int y) {
		IntSupplier intSupplier = new IntSupplier() {

			@Override
			public int getAsInt() {
				int sum = x + y;
				return sum;
			}

		};
		int result = intSupplier.getAsInt();
		IntSupplier intSupplier2 = () -> {
			int sum = x + y;
			return sum;
		};

		int result2 = intSupplier.getAsInt();
		return result2;
	}

	public static void main(String[] args) {
		System.out.println("람다식 테스트용 메서드 반환값 출력 = " + method(3, 5));

	}
}
