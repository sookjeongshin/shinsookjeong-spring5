package kr.or.test;

import java.util.Calendar;

/*@author 신숙정 Enumerate EnumClass*/

public class Step3 {

	public static void main(String[] args) {
		// 메인 메서드
		Week today = null; // Week자료형용 today변수
		// String today2 = null;//String자료형용 today2변수생성
		// MemberVO memberVO = new MemberVO();
		// MemberVO자료형용 MemberVO객체변수 오브젝트 선언
		// 현재날짜 요일 한글로 확인
		Calendar calendar = Calendar.getInstance();
		// 현재요일만 반환
		int intWeek = calendar.get(Calendar.DAY_OF_WEEK);
		switch (intWeek) { // 조건판단 if문가능
		case 1: // Week자료형에 바로접근 방법
			today = Week.일;
			break;
		case 2:
			today = Week.월;
			break;
		case 3:
			today = Week.화;
			break;
		case 4:
			today = Week.수;
			break;
		case 5:
			today = Week.목;
			break;
		case 6:
			today = Week.금;
			break;
		case 7:
			today = Week.토;
			break;
		}

		System.out.println("오늘요일은:" + today + "요일 입니다.");
		if (today == Week.수) {
			System.out.println("수요일에는 축구를 합니다.");
		} else {
			System.out.println("열심히 자바 공부를 합니다.");
		}
	}

}
