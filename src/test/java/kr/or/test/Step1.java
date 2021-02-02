package kr.or.test;
/*
 * 
 * @author 신숙정
 * 2020-12-08
 * */

public class Step1 {

	public static void main(String[] args) {
		// String문자, int 숫자
		String name;
		int age;
		String phoneNum;

		name = "홍길동";
		age = 45;
		phoneNum = "000-0000-0000";
		printMember(name, age, phoneNum);
		name = "성춘향";
		age = 18;
		phoneNum = "111-1111-1111";
		printMember(name, age, phoneNum);
		name = "각시탈";
		age = 28;
		phoneNum = "222-2222-2222";
		printMember(name, age, phoneNum);

		String[] names = { "홍길동", "성춘향", "각시탈" };
		int[] ages = { 45, 18, 28 };
		String[] phoneNums = { "000-0000-0000", "111-1111-1111", "222-2222-2222" };
		printMember(names, ages, phoneNums);
	}

	private static void printMember(String[] names, int[] ages, String[] phoneNums) {
		int dataLength = names.length;
		System.out.println("매개변수로 받은 names 의 사람의 명수는:" + names.length);
		for (int cnt = 0; cnt < dataLength; cnt++) {
			System.out.println("cnt변수의 변화는=" + cnt);
			System.out.println("배열의 이름은: " + names[cnt] + " | 나이는: " + ages[cnt] + " | 연락처는: " + phoneNums[cnt]);
		}
	}

	private static void printMember(String name, int age, String phoneNum) {
		System.out.println("회원의 이름은: " + name + " | 나이는: " + age + " | 연락처는: " + phoneNum);

	}

}
