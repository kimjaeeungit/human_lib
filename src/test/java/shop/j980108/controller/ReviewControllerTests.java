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

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.ReplyVo;
import shop.j980108.domain.ReviewVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
//Test Controller
@WebAppConfiguration
public class ReviewControllerTests {
	@Autowired @Setter
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	@Before
	public void setup(){
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testCreate() throws Exception {
		ReviewVo vo=new ReviewVo();
		vo.setIsbn("9788950980726");
		vo.setReply("컨트롤러 테스드 댓글7");
		vo.setReplyer("user1");
		String jsonStr = new Gson().toJson(vo);
		
		log.info("jsonStr ::"+ jsonStr);
		
		 mvc.perform(post("/reviews/new")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
		}
	
	//페이지번호에 따른 댓글 목록 출력
		@Test
		public void testList() throws Exception{
			//MockMvcRequestBuilders를 사용해 get방식으로 호출
			//MockMvcRequestBuilders를 사용해 설정한 요청 데이터를 perform()의 인수로 전달
			ModelMap map =mvc.perform(MockMvcRequestBuilders.get("/review/get")
					.param("pageNum", "1")
					.param("amount", "10")
					)
			.andReturn()
			.getModelAndView()
			.getModelMap();
			
			//BoardController의 getList()에서 반환된 결과를 이용해서 Model에 어떤 데이터들이 담겨있는지 확인
			List<?> list= (List<?>)map.get("list");
			list.forEach(log::info);
		}
		
}
