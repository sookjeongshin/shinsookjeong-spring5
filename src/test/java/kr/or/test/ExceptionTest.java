package kr.or.test;

import java.io.IOException;
import java.io.InputStreamReader;

import org.edu.vo.MemberVO;

public class ExceptionTest {

	public static void main(String[] args) {
		// toString메서드에 대해서
		MemberVO memberVO = new MemberVO();
		memberVO.setUser_id("shinsookjeong");
		memberVO.setUser_name("신숙정");
		memberVO.setEmail("sookjeongshin@abc.com");
		System.out.println("회원정보 클래스의 메머변수 값들을 출력하기=" + memberVO.getUser_name() + memberVO.toString());
		// 진입(실행)메서드 main
		// 메서드 내부변수
		String[] stringArray = { "10", "2a", "100" };
		int indexValue = 0;
		for (int cnt = 0; cnt <= 2; cnt++) {
			/*
			 * ex예외처리를 하지않으면 프로그램이 종료됨 indexValue = Integer.parseInt(stringArray[cnt]); 배열된
			 * 문자값을 int형변환 System.out.println(cnt + " 번째 배열에 저장된 숫자는 = " + indexValue);
			 */

			try {
				indexValue = Integer.parseInt(stringArray[cnt]); // 배열의 문자값을 int형 변환
				System.out.println((cnt + 1) + "번째 배열에 저장된 숫자는= " + indexValue);
			} catch (ArrayIndexOutOfBoundsException e) {
				System.out.println("에러메시지 출력 = " + e.toString());
				System.out.println("베열의 크기가 올바르지 않습니다.");
			} catch (NumberFormatException e) {
				System.out.println("에러메시지 출력" + e.toString());
				System.out.println("개발자가 지정한 에러메시지는 숫자 변환시 에러가 발생 되었음.");
			} finally {
				System.out.println("finally는 try~catch 결과와 상관없이 항상 실행");
			}
		}

	}

}
