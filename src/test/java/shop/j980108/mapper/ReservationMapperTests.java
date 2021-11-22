package shop.j980108.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.BoardVo;
import shop.j980108.domain.Criteria;
import shop.j980108.domain.ReservationVo;

/**
 * @author 조윤정
 * @date 2021-10-25 ~ 
 * @name ReservationMapper Tests
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class ReservationMapperTests {
	@Autowired @Setter
	private ReservationMapper mapper;
	
	@Test
	public void testGetTimetable(){
		ReservationVo vo=new ReservationVo();
		vo.setSeatNo(1);
		vo.setRevTime(2);
		vo.setLoc(1);
		log.info(mapper.getTimetable(vo));
	}
	
	@Test
	public void testCheckDupRev(){
		ReservationVo vo=new ReservationVo();
		vo.setId("아이디1");
		vo.setRevTime(1);
		log.info(mapper.checkDupRev(vo));
	}
	
	@Test
	public void testInsert(){
		ReservationVo rev =  new ReservationVo();
		rev.setSeatNo(2);
		rev.setRevTime(3);
		rev.setId("아이디1");
		rev.setLoc(1);
		mapper.insert(rev);
		log.info(rev);
	}
	
	@Test
	public void testDelete(){
		mapper.delete(21L);
	}
	
	@Test
	public void testGetRevList(){
		mapper.getRevList(new Criteria()).forEach(log::info);
	}
	
	@Test
	public void testGetMyRev(){
		mapper.getMyRev(new Criteria(),"iiii").forEach(log::info);
	}
	

}
