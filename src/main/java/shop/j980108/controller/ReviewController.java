package shop.j980108.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.Criteria;
import shop.j980108.domain.ReplyVo;
import shop.j980108.domain.ReviewVo;
import shop.j980108.service.ReplyService;
import shop.j980108.service.ReviewService;

@RestController
@AllArgsConstructor
@RequestMapping("/reviews")
@Log4j
public class ReviewController {
  private ReviewService service;
  
  //댓글 작성
  @PostMapping("new")
  public String create(@RequestBody ReviewVo vo){
	  log.info("create::"+vo);
	  service.register(vo);
	  log.info(vo);
	  return "success";
  }
  
  //댓글 하나만 보기
  @GetMapping("{rno}")
  //@PathVariable : url경로에 변수 넣어주는거
  public ReviewVo get(@PathVariable Long rno){
	  log.info("get..::"+rno);
	  return service.get(rno);
  }
  
  //댓글 수정
  @PutMapping("{rno}")
  public String modify(@PathVariable Long rno,@RequestBody ReviewVo vo){
	  log.info("modify::"+vo);
	  service.modify(vo);
	  return "success";
  }
  //댓글 삭제
  @DeleteMapping("{rno}")
  public String remove(@PathVariable Long rno){
	  log.info("remove :: " +rno);
	  service.remove(rno);
	  return "success";
  }
  //댓글리스트
  @GetMapping(value="/pages/{isbn}/{page}")
	public ResponseEntity<Map<String, Object>> getList(
			@PathVariable("page") int page,
			@PathVariable("isbn") String isbn) {
		
		Criteria cri = new Criteria(page,10);
		log.info("get Review List isbn: " + isbn);
		log.info("cri: " + cri);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", service.getList(cri,isbn));
		map.put("reviewCnt", service.getTotal(isbn, cri));
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
