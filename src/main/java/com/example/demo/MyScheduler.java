package com.example.demo;



import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.MainMapper;

//스케줄에 등록하는 클래스는 빈에 등록 되어야 된다.
@Service
public class MyScheduler {
		///1/1000초 
	@Autowired
	private MainMapper mapper;
	
	
	//fixedRate, fixedDelay, cron(매년 10월 10일 열시에 저장하라)
	/*
	 * @Scheduled(fixedRate=1000) public void test() {
	 * System.out.println(LocalDateTime.now().getSecond()); }
	 */
	//초 분 시 일 월 요일
	@Scheduled(cron="0 43 12 * * *")
	public void delUser() {
		mapper.delUser();
	}
	//cron 처리
	//0 * * * * * : 매 초마다 실행
	//*0 ****: 매분마다.
	//0 0 12 * * * : 매일 열두시 정각에
	//0  12 5 * * : 매달 5일 12시 정각에
   	//0 0 12 5 2 * : 2월 
	//0 0 12 * * 1,7 :매일 열두시 일요일, 토요일
	
	//자바가 필요한 경우에 이렇게 한다.

}
