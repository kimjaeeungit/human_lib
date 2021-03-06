package shop.j980108.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.LoansVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
@WebAppConfiguration
public class LoansControllerTests {
	
	@Autowired @Setter
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	@Before
	public void setup() {
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	/** λμΆ μμ½ by Member */  
	@Test
	public void testReserveLoans() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setBkno(1L);
		loansVo.setId("dldlrwns");
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/reserveLoans")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμΆ μμ½ μ·¨μ by Member */
	@Test
	public void testCancelLoansReservationByMember() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setLno(404L);
		loansVo.setBkno(1L);
		loansVo.setId("dldlrwns");
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/cancelLoansReservationByMember")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμΆ μμ½ μ·¨μ by Task */
	@Test
	public void testCancelLoansReservationByTask() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setLno(261L);
		loansVo.setStatus(2);
		loansVo.setBkno(186L);
		loansVo.setId("μμ΄λ1");
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/cancelLoansReservationByTask")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμΆ μμ½ μ·¨μ by Manager */
	@Test
	public void testCancelLoansReservationByManager() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setLno(261L);
		loansVo.setStatus(3);
		loansVo.setBkno(186L);
		loansVo.setId("μμ΄λ1");
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/cancelLoansReservationByManager")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμΆ μμ½ νμ  by manager */
	@Test
	public void testAcceptLoans() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setLno(261L);
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/acceptLoans")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμΆ μλ£ by manager */
	@Test
	public void testCompleteLoans() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setLno(261L);
		loansVo.setBkno(186L);
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/completeLoans")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** νμ₯ λμΆ by Manager */
	@Test
	public void testLoans() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setBkno(5L);
		loansVo.setId("μμ΄λ1");
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/loans")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμΆ μ°μ²΄ μ²λ¦¬ by Task */
	@Test
	public void testCheckLoansOverdue() throws Exception {
		mvc.perform(post("/loans/checkLoansOverdue"));
	}
	
	/** λμ λ°λ© by Manager */
	@Test
	public void testReturnLoans() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setLno(261L);
		loansVo.setStatus(7);
		loansVo.setBkno(186L);
		loansVo.setId("μμ΄λ1");
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/returnLoans")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμ μκ΅¬λ―Έλ°λ© by Manager */
	@Test
	public void testNotReturnLoans() throws Exception {
		LoansVo loansVo = new LoansVo();
		loansVo.setLno(261L);
		loansVo.setStatus(7);
		loansVo.setBkno(186L);
		loansVo.setId("μμ΄λ1");
		String jsonStr = new Gson().toJson(loansVo);
		log.info("jsonStr ::" + jsonStr);
		mvc.perform(post("/loans/notReturnLoans")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	
	/** λμΆ μμ½ νν© λ¦¬μ€νΈ by Member */
	@Test
	public void testListLoansReservationForMember() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/loans/listLoansReservationForMember")
				.param("id", "μμ΄λ1"))
			.andReturn()
			.getModelAndView()
			.getModelMap();
		List<?> list= (List<?>)map.get("list");
		list.forEach(log::info);
	}
	
	/** λμΆ μμ½ νν© λ¦¬μ€νΈ by Manager */
	@Test
	public void testListLoansReservationForManager() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/loans/listLoansReservationForManager")
				.param("pageNum", "1")
				.param("amount", "10")
				.param("status", "0"))
			.andReturn()
			.getModelAndView()
			.getModelMap();
		List<?> list= (List<?>)map.get("list");
		list.forEach(log::info);
	}
	
	/** λμΆμ€ λ¦¬μ€νΈ by Member */
	@Test
	public void testListLoansForMember() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/loans/listLoansForMember")
				.param("id", "μμ΄λ1"))
			.andReturn()
			.getModelAndView()
			.getModelMap();
		List<?> list= (List<?>)map.get("list");
		list.forEach(log::info);
	}
	
	/** λμΆμ€ λ¦¬μ€νΈ by Manager */
	@Test
	public void testListLoansForManager() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/loans/listLoansForManager")
				.param("pageNum", "1")
				.param("amount", "10"))
			.andReturn()
			.getModelAndView()
			.getModelMap();
		List<?> list= (List<?>)map.get("list");
		list.forEach(log::info);
	}
	
	/** μ΅κ·Ό λ°λ© μλ£ λ¦¬μ€νΈ by Member */
	@Test
	public void testListReturnedLoansRecently() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/loans/listReturnedLoansRecently")
				.param("pageNum", "1")
				.param("amount", "10")
				.param("id", "μμ΄λ1"))
			.andReturn()
			.getModelAndView()
			.getModelMap();
		List<?> list= (List<?>)map.get("list");
		list.forEach(log::info);
	}
	
	/** λ°λ© μλ£ λμΆ λ¦¬μ€νΈ by Member */
	@Test
	public void testListReturnedLoans() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/loans/listReturnedLoans")
				.param("pageNum", "1")
				.param("amount", "10")
				.param("id", "μμ΄λ1"))
			.andReturn()
			.getModelAndView()
			.getModelMap();
		List<?> list= (List<?>)map.get("list");
		list.forEach(log::info);
	}
	
}
