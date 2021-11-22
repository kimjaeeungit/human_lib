package shop.j980108.service;

import java.util.List;

import shop.j980108.domain.PossessionVo;

/**
 * @author 박인영
 * @date 2021-11-01 ~ 2021-11-03
 * @name 소장도서 Service
 */
public interface PossessionService {
	
	/** 도서번호(bkno)로 소장 도서 정보(possession) 조회 */
	PossessionVo getPossession(Long bkno);
	
	/** ISBN으로 소장 도서(possession) 목록 조회 */
	List<PossessionVo> listPossessionInfo(String isbn);
	
	/** index 최근 7일 대출 인기 소장 도서 6권 리스트 */
	List<PossessionVo> listPopularityPossession();
	
	/** index 신착 도서(최근 등록된 소장도서) 6권 리스트 */
	List<PossessionVo> listNewPossession();
	
}
