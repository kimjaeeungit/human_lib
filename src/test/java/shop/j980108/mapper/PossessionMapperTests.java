package shop.j980108.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.PossessionVo;

/**
 * @author 박인영
 * @date 2021-11-01 ~ 2021-11-03
 * @name 소장도서 Mapper Tests
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class PossessionMapperTests {
	
	@Autowired @Setter
	private PossessionMapper mapper;
	
	/** 도서번호(bkno)로 소장 도서 정보(possession) 조회 */
	@Test
	public void testGetPossession() {
		log.info(mapper.getPossession(1L));
	}
	
	/** ISBN으로 소장 도서(possession) 목록 조회 */
	@Test
	public void testListPossessionInfo() {
		mapper.listPossessionInfo("9791158362157").forEach(log::info);
	}
	
	/** 소장도서의 상태(Possession.status) 대출가능(0)에서 대출예약중(1)으로 갱신 */
	@Test
	public void testUpdatePossessionStatus() {
		PossessionVo possession = new PossessionVo();
		possession.setBkno(4L);
		possession.setStatus(1);
		mapper.updatePossessionStatus(possession);
		log.info(1L);
	}
	
	/** index 최근 7일 대출 인기 소장 도서 6권 리스트 */
	@Test
	public void testListPopularityPossession() {
		mapper.listPopularityPossession().forEach(log::info);
	}
	
	/** index 신착 도서(최근 등록된 소장도서) 6권 리스트 */
	@Test
	public void testListNewPossession() {
		mapper.listNewPossession().forEach(log::info);
	}
	
}
