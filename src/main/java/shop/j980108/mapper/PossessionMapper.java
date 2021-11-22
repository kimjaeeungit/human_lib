package shop.j980108.mapper;

import java.util.List;

import shop.j980108.domain.PossessionVo;

/**
 * @author 박인영
 * @date 2021-11-01 ~ 2021-11-09
 * @name 소장도서 Mapper
 */
public interface PossessionMapper {
	
	/** 도서번호(bkno)로 소장 도서 정보(possession) 조회 */
	PossessionVo getPossession(Long bkno);
	
	/** ISBN으로 소장 도서(possession) 목록 조회 */
	List<PossessionVo> listPossessionInfo(String isbn);
	
	/** 소장도서의 상태(Possession.status) 변경 */
	void updatePossessionStatus(PossessionVo possession);
	
	/** index 최근 7일 대출 인기 소장 도서 6권 리스트 */
	List<PossessionVo> listPopularityPossession();
	
	/** index 신착 도서(최근 등록된 소장도서) 6권 리스트 */
	List<PossessionVo> listNewPossession();
	
}