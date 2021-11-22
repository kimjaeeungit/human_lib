package shop.j980108.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import lombok.AllArgsConstructor;
import shop.j980108.domain.Criteria;
import shop.j980108.domain.ReplyVo;
import shop.j980108.mapper.BoardMapper;
import shop.j980108.mapper.ReplyMapper;

@AllArgsConstructor @Service
public class ReplyServiceImpl implements ReplyService {
	private ReplyMapper mapper;
	//댓글수 처리 위해
	private BoardMapper boardMapper;
	
	@Override
	@Transactional //이게 없으면 댓글insert가 안되도 cnt가 올라간다.
	public void register(ReplyVo vo) {
		//작업2 댓글 갯수 업데이트 작업
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		//작업1 댓글 작성잡업
		mapper.insert(vo);
	
	}

	@Override
	public ReplyVo get(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public boolean modify(ReplyVo vo) {
		return mapper.update(vo) > 0;
	}

	@Override
	@Transactional
	public boolean remove(Long rno) {
		boardMapper.updateReplyCnt(get(rno).getBno(), -1);
		return mapper.delete(rno)>0;
	}

//	@Override
//	public List<ReplyVo> getList2(ReplyCriteria cri, Long bno) {
//		return mapper.getList(bno, cri);
//	}
//	
	//게시글 목록
	   @Override
	   public List<ReplyVo> getList(Criteria cri,Long bno) {
	      return mapper.getListWithPaging(bno, cri);
	   }
	 //검색한 게시글 갯수 또는 게시글 개수
	   @Override
	   public int getTotal(Long bno, Criteria cri){
	    return mapper.getTotalCount(bno, cri);
	   }
	
}
