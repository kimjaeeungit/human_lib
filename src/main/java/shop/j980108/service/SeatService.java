package shop.j980108.service;

import java.util.List;

import shop.j980108.domain.SeatVo;

public interface SeatService {
	/* 현재 시간 알아오기 */
	Integer getCurrentTime();
	
	/* 해당 열람실의 자리 읽어오기 */
	List<SeatVo> readByLoc(int loc);
	
	/* 현재 시간 해당 열람실의 자리 읽어오기 */
	int getSeatCntByLoc(int loc,int revTime);
	
	/* 모든 시간의 모든 자리 정보 읽어오기 */
	List<SeatVo> getList(SeatVo vo);
	
	
}
