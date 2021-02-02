package kr.or.test;

public class LoopApp {

	public static void main(String[] args) {
		// for문
		int[] numbers = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
		int cnt; // 반복횟수 카운트하는 역할
//for문(반복의시작값정의;반복의종료값정의;반복할때증가하는값)
		for (cnt = 0; cnt < 10; cnt++) {// cnt++ => cnt=cnt=+1;1씩증가
//System.out.println ("현재 카운터는" + numbers[cnt]);
		}
		String[] names = { "사용자1", "사용자2", "사용자3", "사용자4", "사용자5" };
		int length = names.length;
		char name = '사';
//배열타입[ 1차원배열 = 가로선 1row 단일줄
//향상된 for문에서는 시작값,끝값,증가값 필요없습니다.
		for (String user_name : names) {
			System.out.println("등록된 사용자이름은 " + user_name);
		}
		String[][] members = { { "admin", "관리자", "admin@abc.com", "2020-12-04", "ROLE_ADMIN" },
				{ "user", "사용자1", "user@abc.com", "false", "2020-12-04", "ROLE_USER" } };
		//
		System.out.println("======회원리스트 입니다=====");
		System.out.println("user_id  user_name  eamil  use  regdate  levels");
		for (String[] member : members) {
			System.out.println(member[0] + "|" + member[1] + "|" + member[2] + "|" + member[3] + "|" + members[4] + "|"
					+ member[5]);

		}
	}
//향상된 for문, 스프링jsp에서 제일많이 사용하게 될 구문.(아래)
}
