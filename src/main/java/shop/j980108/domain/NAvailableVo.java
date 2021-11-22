package shop.j980108.domain;


import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 조윤정
 * @date 2021-10-19
 * @name 불가정보
 */

@Data @Alias("navailable") @NoArgsConstructor @AllArgsConstructor
public class NAvailableVo {
	/* 불가번호 */
	private Long nANo;
	/* 자리번호 */
	private Integer seatNo;
	/* 열람실 번호 */
	private Integer loc;
	/* 불가 사유 */
	private String reason;
}
