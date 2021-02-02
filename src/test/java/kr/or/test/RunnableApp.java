package kr.or.test;

public class RunnableApp implements Runnable {

	public static void main(String[] args) {
		// Runnable 인터페이스 구형
		(new Thread(new RunnableApp())).start();
	}

	@Override
	public void run() {
		// runnableapp을 start하면 자동실행
		System.out.println("러너블시작시 자동실행됩니다.");

	}

}
