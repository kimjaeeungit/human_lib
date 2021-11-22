package shop.j980108.service;

import static org.junit.Assert.assertNotNull;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.BookVo;
import shop.j980108.domain.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BooksServiceTests {
	@Setter 
	@Autowired
	private BooksService service;
	
	@Test
	public void testExist(){
		assertNotNull(service);//객체 service가 null이 아닌지 확인
	}
	
	//게시글 작성
		@Test
		public void testRegister(){
			BookVo bookVo=new BookVo();
			bookVo.setIsbn("23123 1s2312");
			bookVo.setTitle("서비스 테스트 제목");
			bookVo.setAuthors("서비스 테스트 제목");
			bookVo.setContents("서비스 테스트 내용");
			Date now = new Date();
			bookVo.setDatetime(now);
			bookVo.setPrice(20000L);
			bookVo.setPublisher("서비스 테스트 출판사");
			bookVo.setThumbnail("서비스 테스트 표지");
			bookVo.setTranslators("서비스 테스트 번역자");
			service.register(bookVo);
		}
		 
	
	//게시글 목록 보여주기
	@Test
	public void testGetList(){
		service.getList(new Criteria()).forEach(log::info);
	}
	
	//검색한 게시글 갯수 또는 게시글 개수
	@Test
   public void testGetTotal() {
      log.info(service.getTotal(new Criteria()));
   }
	
	//게시글 상세보기
	@Test
	public void testGet(){
		//log.info(service.get("8965962374 9788965962373"));
	}

}
