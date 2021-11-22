package shop.j980108.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.SeatVo;

/**
 * @author 조윤정
 * @date 2021-10-25 ~ 
 * @name SeatMapper Tests
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class SeatMapperTests {
	@Autowired @Setter
	private SeatMapper mapper;
	
	@Test
	public void testReturnTime(){
		log.info(mapper.returnTime());
	}
	
	@Test
	public void testGetList(){
		SeatVo vo=new SeatVo();
		vo.setLoc(1);
		mapper.getList(vo).forEach(log::info);
	}
	
	@Test
	public void testUpdate(){
		SeatVo vo=new SeatVo();
		vo.setStatus(0);
		vo.setSeatNo(1);
		vo.setLoc(1);
		mapper.update(vo);
	}
	@Test
	public void testGetCountByLoc(){
		log.info(mapper.getSeatCntByLoc(4, 12));
	}
	
}
