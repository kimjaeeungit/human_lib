package shop.j980108.domain;

import java.util.Date;
import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 김재은
 * @date 2021-10-18
 * @name 도서상세보기 리뷰댓글
 */
@Data
@Alias("review")
public class ReviewVo {
	/*댓글번호*/
	private Long rno;
	/*댓글*/
	private String reply;
	/*댓글작성자*/
	private String replyer;
	/*댓글작성일*/
	private Date replyDate;
	/*댓글수정일*/
	private Date updateDate;
	/*ISBN*/
	private String isbn;
}

