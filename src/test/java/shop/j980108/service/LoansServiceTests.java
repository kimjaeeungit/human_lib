package shop.j980108.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import shop.j980108.domain.Criteria;
import shop.j980108.domain.LoansVo;
import shop.j980108.service.LoansService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/**
 * @author 박인영
 * @date 2021-10-21 ~ 
 * @name 대출 Service Tests
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class LoansServiceTests {
	
	@Setter @Autowired
	private LoansService service;
	
	@Test
	public void testExist() {
		assertNotNull(service);
	}
	
	/** 대출예약 by Member */
	@Test
	public void testReserveLoans() {
		LoansVo loans = new LoansVo();
		loans.setId("아이디1");
		loans.setBkno(5L);
		service.reserveLoans(loans);
		log.info(loans);
	}

	/** 대출 예약 취소 by Member */
	@Test
	public void testCancelLoansReservationByMember() {
		LoansVo loans = new LoansVo();
		loans.setLno(447L);
		loans.setBkno(3L);
		loans.setId("dldlrwns");
		service.cancelLoansReservationByMember(loans);
		log.info(loans);
	}
	
	/** 대출 예약 취소 by Task */
	@Test
	public void testCancelLoansReservationByTask() {
		LoansVo loans = new LoansVo();
		loans.setLno(56L);
		loans.setBkno(3L);
		loans.setId("아이디1");
		service.cancelLoansReservationByTask(loans);
		log.info(loans);
	}
	
	/** 대출 예약 취소 by Manager */
	@Test
	public void testcancelLoansReservationByManager() {
		LoansVo loans = new LoansVo();
		loans.setLno(56L);
		loans.setBkno(3L);
		loans.setId("아이디1");
		service.cancelLoansReservationByManager(loans);
		log.info(loans);
	}
	
	/** 대출 예약 확정 by Manager */
	@Test
	public void testAcceptLoans() {
		LoansVo loans = new LoansVo();
		loans.setLno(244L);
		service.acceptLoans(loans);
	}
	
	/** 대출 완료 by Manager */
	@Test
	public void testCompleteLoans() {
		LoansVo loans = new LoansVo();
		loans.setLno(244L);
		loans.setBkno(5L);
		service.completeLoans(loans);
		log.info(loans);
		
	}
	
	/** 대출 연체 처리 by Task */
	@Test
	public void testCheckLoansOverdue() {
		service.checkLoansOverdue().forEach(log::info);
	}
	
	/** 도서 반납 by Manager */
	@Test
	public void testReturnLoans() {
		LoansVo loans = new LoansVo();
		loans.setLno(61L);
		loans.setBkno(1L);
		loans.setId("아이디1");
		service.returnLoans(loans);
		log.info(loans);
	}
	
	/** 도서 영구미반납 by Manager */
	@Test
	public void notReturnLoans() {
		LoansVo loans = new LoansVo();
		loans.setLno(245L);
		loans.setBkno(1L);
		loans.setId("아이디1");
		service.notReturnLoans(loans);
		log.info(loans);
	}
	
	/** 대출 예약 현황 리스트 by Member */
	@Test
	public void testListLoansReservationForMember() {
		service.listLoansReservationForMember("아이디1").forEach(log::info);
	}
	
	/** 대출 예약 현황 리스트 by manager */
	@Test
	public void testListLoansReservationForManager() {
		service.listLoansReservationForManager(new Criteria(), 4).forEach(log::info);
	}
	
	/** 대출중 리스트 by Member */
	@Test
	public void testListLoansForMember() {
		service.listLoansForMember("dldlrwns");
	}
	
	/** 대출중 리스트 by Manager */
	@Test
	public void testListLoansForManager() {
		service.listLoansForManager(new Criteria());
	}
	
	/** 최근 7일 이내 반납 도서 개수 by Member */
	@Test
	public void testGetReturnedLoansCountRecently() {
		log.info(service.getReturnedLoansCountRecently("dldlrwns"));
	}
	
	/** 최근 7일 이내 반납 도서 리스트 by Member */
	@Test
	public void testListReturnedLoansRecently() {
		service.listReturnedLoansRecently(new Criteria(), "아이디1").forEach(log::info);
	}
	
	/** 반납 완료 대출 리스트 by Member */
	@Test
	public void testListReturnedLoans() {
		service.listReturnedLoans(new Criteria(), "아이디1").forEach(log::info);
	}
	
	/** 대출 상태별 개수 조회 for Member */
	@Test
	public void testGetLoansStatusCount() {
		log.info(service.getLoansStatusCount(0, "dldlrwns"));
	}
	
	/** 대출 상태별 개수 조회 for Manager */
	@Test
	public void testGetLoansStatusTotalCount() {
		log.info(service.getLoansStatusTotalCount(0));
	}
	
	/** 대출 이중 상태 개수 조회 for Member */
	@Test
	public void testGetLoansDualStatusCount() {
		log.info(service.getLoansDualStatusCount(5, 6, "dldlrwns"));
	}
	
	/** 대출 이중 상태 개수 조회 for Manager */
	@Test
	public void testGetLoansDualStatusTotalCount() {
		log.info(service.getLoansDualStatusTotalCount(5, 6));
	}
	
	/** 대출번호로 대출 조회 */
	@Test
	public void testFindLoansByLno() {
		log.info(service.findLoansByLno(301L));
	}
	
}
