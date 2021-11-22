package shop.j980108.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.Criteria;
import shop.j980108.domain.LoansVo;

/**
 * @author 박인영
 * @date 2021-10-19 ~ 
 * @name 대출 Mapper Tests
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class LoansMapperTests {
	
	@Autowired @Setter
	private LoansMapper mapper;
	
	/** 대출테이블에 대출예약 관련 정보(대출번호, 대출예약일, 대출만기일, 상태, 도서번호, 아이디) 입력 */
	@Test
	public void testInsertLoansReservation() {
		LoansVo loans = new LoansVo();
		loans.setBkno(1L);
		loans.setId("아이디1");
		mapper.insertLoansReservation(loans);
		log.info(loans);
	}
	
	/** 대출 관련 상태 변경 */
	@Test
	public void testUpdateLoansStatus() {
		LoansVo loans = new LoansVo();
		loans.setStatus(3);
		loans.setLno(61L);
		mapper.updateLoansStatus(loans);
		log.info(loans);
	}
	
	/** 대출 예약 건 대출 완료 후 추가 정보(대출일, 반납예정일, 대출 상태) 입력 */
	@Test
	public void testUpdateLoans() {
		LoansVo loans = new LoansVo();
		loans.setLno(61L);
		mapper.updateLoans(loans);
		log.info(loans);
	}
	
	/** 대출 테이블에 대출 관련 정보(대출번호, 대출일, 반납예정일, 대출상태, 도서번호, 아이디) 입력 */	
	@Test
	public void insertLoans() {
		LoansVo loans = new LoansVo();
		loans.setBkno(1L);
		loans.setId("아이디1");
		mapper.insertLoans(loans);
	}
	
	/** 대출중인 도서 중 반납예정일 지난 건 연체 처리 */
	@Test
	public void testUpdateLoansOverdue() {
		mapper.updateLoansOverdue();
	}
	
	/** 연체 처리된 건 리스트 (for 반납 독촉 문자 발송) */
	@Test
	public void testListUpdateLoansOverdue() {
		mapper.listUpdateLoansOverdue().forEach(log::info);
	}
	
	/** 대출중인 도서 반납 정보(반납일, 대출상태) 입력 */
	@Test
	public void returnLoans() {
		LoansVo loans = new LoansVo();
		loans.setLno(44L);
		loans.setStatus(7);
		mapper.returnLoans(loans);
	}
	
	/** 대출 예약 현황 리스트 by Member */
	@Test
	public void testListLoansReservationForMember() {
		mapper.listLoansReservationForMember("아이디1").forEach(log::info);;
	}	
	
	/** 대출 예약 신청 현황 리스트 by manager */
	@Test
	public void testListLoansReservationForManager() {
		mapper.listLoansReservationForManager(new Criteria(), 0).forEach(log::info);;
	}
	
	/** 대출중 리스트 by Member */
	@Test
	public void testListLoansForMember() {
		mapper.listLoansForMember("dldlrwns").forEach(log::info);;
	}
	
	/** 대출중 리스트 by Manager */
	@Test
	public void testListLoansForManager() {	
		mapper.listLoansForManager(new Criteria()).forEach(log::info);
	}
	
	/** 최근 7일 이내 반납 도서 개수 by Member */
	@Test
	public void testGetReturnedLoansCountRecently() {
		log.info(mapper.getReturnedLoansCountRecently("아이디2"));
	}
	
	/** 최근 7일 이내 반납 도서 리스트 by Member */
	@Test
	public void testListReturnedLoansRecently() {
		mapper.listReturnedLoansRecently(new Criteria(), "아이디").forEach(log::info);
	}
	
	/** 반납 완료 대출 리스트 by Member */
	@Test
	public void testListReturnedLoans() {
		mapper.listReturnedLoans(new Criteria(), "아이디1").forEach(log::info);
	}
	
	/** 대출 상태별 개수 조회 for Member */
	@Test
	public void testGetLoansStatusCount() {
		log.info(mapper.getLoansStatusCount(0, "dldlrwns"));
	}
	
	/** 대출 상태별 개수 조회 for Manager */
	@Test
	public void testGetLoansStatusTotalCount() {
		log.info(mapper.getLoansStatusTotalCount(0));
	}

	/** 대출 이중 상태 개수 조회 for Member */
	@Test
	public void testGetLoansDualStatusCount() {
		log.info(mapper.getLoansDualStatusTotalCount(5, 6));
	}
	
	/** 대출 이중 상태 개수 조회 for Manager */
	@Test
	public void testGetLoansDualStatusTotalCount() {
		log.info(mapper.getLoansDualStatusTotalCount(5, 6));
	}
	
	/** 대출번호로 대출 조회 */
	@Test
	public void testFindLoansByLno() {
		log.info(mapper.findLoansByLno(301L));
	}

}
