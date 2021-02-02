package kr.or.member;

import java.io.IOException;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import org.apache.commons.net.ntp.NTPUDPClient;
import org.apache.commons.net.ntp.TimeInfo;

import kr.or.member.MemberService;
import kr.or.member.MemberVO;

public class MainController {

	public static <Timeinfo> void main(String[] args) throws IOException {
		MemberVO memberVO = new MemberVO();
		memberVO.setName("신숙정");
		memberVO.setAge(45);
		memberVO.setPhoneNum("000-000-0000");
		MemberVO memberVO2 = new MemberVO();
		memberVO2.setName("신숙정");
		memberVO2.setAge(18);
		memberVO2.setPhoneNum("111-1111-1111");
		MemberVO memberVO3 = new MemberVO();
		memberVO3.setName("신숙정");
		memberVO3.setAge(28);
		memberVO3.setPhoneNum("222-2222-2222");

		if (memberVO2 == memberVO3) {
			System.out.println("동일객체=인스턴스");
		} else {
			System.out.println("다른오브젝트");
		}
		MemberVO[] members = new MemberVO[3];
		members[0] = memberVO;
		members[1] = memberVO2;
		members[2] = memberVO3;
		MemberService memberService = new MemberService();
		memberService.printMember(members);
//

		NTPUDPClient timeClient = new NTPUDPClient();
		timeClient.setDefaultTimeout(1000);// 서버응답타임설정 1초
		timeClient.open();
		InetAddress address = InetAddress.getByName("pool.ntp.org");
		TimeInfo timeinfo = timeClient.getTime(address);
		long returnTime = timeinfo.getMessage().getTransmitTimeStamp().getTime();
		Date nowdate = new Date(returnTime);
		// System.out.println("현재 서버시간은 "+ nowdate);
		// Wed Dec 09 11:18:09 KST 2020
		// SimpleDateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd hh-mm:ss");
		// System.out.println("현재 서버시간은-한국버전"+formatdate.format(nowdate));
		LocalDateTime localDateTime = nowdate.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
		System.out.println("Server 시간:" + localDateTime);
		System.out.println("로컬PC시간:" + LocalDateTime.now());
	}

}
