package shop.j980108.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import shop.j980108.domain.SeatVo;

/**
 * @author 조윤정
 * @date 2021-10-25 ~ 
 * @name 좌석 Mapper
 */
public interface SeatMapper {
	/* 현재시간을 시간대로 바꿔서 출력 */
	int returnTime();
	
	/* 선택한 해당 LOC, 해당 시간에 좌석가져오기 파라미터 null 이면 전!부! */
	List<SeatVo> getList(SeatVo seat);
	
	/* 현재 자리의 상태 바꾸기 (0: 이용가능, 1:가능)*/
	void update(SeatVo vo);
	
	/* 현재 시간 열람실 자리현황 가져오기 */
	int getSeatCntByLoc(@Param("loc")int loc,@Param("revTime")int revTime);
}
