package shop.j980108.mapper;

import static org.junit.Assert.assertNotNull;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.Criteria;
import shop.j980108.domain.ReplyCriteria;
import shop.j980108.domain.ReplyVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	@Setter @Autowired
	private ReplyMapper mapper;
	
	@Test
	public void testExist(){
		assertNotNull(mapper);
	}
	//페이지,글개수에따라 게시글 목록 보여주기
	@Test
	public void tetGetListPaging() {
		Criteria cri =  new Criteria(); //기본생성자(1,10)
		mapper.getListWithPaging(333l,cri).forEach(log::info);//1,10,T,수정
		//mapper.getList();
	}
	
	@Test
	public  void testInsert(){
		IntStream.range(0,50).forEach(i->{
			ReplyVo vo= new ReplyVo();
			vo.setBno(294L);
			vo.setReply("댓글 테스트" + i);
			vo.setReplyer("댓글러");
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead(){
		log.info(mapper.read(84L));
	}
	
	@Test
	public void testUpdate(){
		ReplyVo vo=new ReplyVo();
		vo.setReply("수정된 댓글");
		vo.setReplyer("수정맨");
		vo.setRno(139L);
		mapper.update(vo);
	}
	@Test
	public void testRemove(){
		log.info(mapper.delete(140L));
	}
	//댓글 목록
	@Test
	public void testGetList(){
		ReplyCriteria criteria = new ReplyCriteria();
		//criteria.setLastRno(11L);
		mapper.getList(257L, criteria).forEach(log::info);
	}
}
