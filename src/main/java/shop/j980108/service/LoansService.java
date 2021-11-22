package shop.j980108.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import shop.j980108.domain.Criteria;
import shop.j980108.domain.LoansVo;
import shop.j980108.domain.SmsVo;

/**
 * @author 박인영
 * @date 2021-10-21 ~ 
 * @name 대출 Service
 */
public interface LoansService {
	
	/** 대출 예약 by Member */
	void reserveLoans(LoansVo loans);	
	
	/** 대출 예약 취소 by Member */
	void cancelLoansReservationByMember(LoansVo loans);
	
	/** 대출 예약 취소 by Task */
	void cancelLoansReservationByTask(LoansVo loans);
	
	/** 대출 예약 취소 by Manager */
	void cancelLoansReservationByManager(LoansVo loans);
	
	/** 대출 예약 확정 by Manager */
	void acceptLoans(LoansVo loans);
	
	/** 대출 완료 by Manager */
	void completeLoans(LoansVo loans);
	
	/** 현장 대출 by Manger */
	void loans(LoansVo loans);
	
	/** 대출 연체 처리 by Task */
	List<SmsVo> checkLoansOverdue();
	
	/** 도서 반납 by Manager */
	void returnLoans(LoansVo loans);
	
	/** 도서 영구미반납 by Manager */
	void notReturnLoans(LoansVo loans);
	
	/** 대출 예약 현황 리스트 by Member */
	List<LoansVo> listLoansReservationForMember(String id);
	
	/** 대출 예약 현황 리스트 by manager */
	List<LoansVo> listLoansReservationForManager(Criteria cri, int Status);	
	
	/** 대출중 리스트 by Member */
	List<LoansVo> listLoansForMember(String id);
	
	/** 대출중 리스트 by Manager */
	List<LoansVo> listLoansForManager(Criteria cri);	
	
	/** 최근 7일 이내 반납 도서 개수 by Member */
	int getReturnedLoansCountRecently(String id);
	
	/** 최근 7일 이내 반납 도서 리스트 by Member */
	List<LoansVo> listReturnedLoansRecently(Criteria cri, String id);
	
	/** 반납 완료 대출 리스트 by Member */
	List<LoansVo> listReturnedLoans(Criteria cri, String id);
	
	/** 대출 상태별 개수 조회 for Member */
	int getLoansStatusCount(@Param("status") int status, @Param("id") String id);
	
	/** 대출 상태별 개수 조회 for Manager */
	int getLoansStatusTotalCount(int Status);

	/** 대출 이중 상태 개수 조회 for Member */
	int getLoansDualStatusCount(@Param("status1") int status1, @Param("status2") int status2, @Param("id") String id);
	
	/** 대출 이중 상태 개수 조회 for Manager */
	int getLoansDualStatusTotalCount(int status1, int status2);	
	
	/** 대출번호로 대출 조회 */
	LoansVo findLoansByLno(Long lno);
	
}
