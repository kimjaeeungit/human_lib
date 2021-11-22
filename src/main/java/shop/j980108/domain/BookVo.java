package shop.j980108.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * @author 박인영
 * @date 2021-10-18
 * @name 도서
 */
@Data
@Alias("book")
public class BookVo {
	/** 도서 고유 번호(13자리) */
	private String isbn;
	/** 도서 제목 */
	private String title; 
	/** 저자 */
	private String authors;
	/** 번역자 */
	private String translators;
	/** 출판사 */
	private String publisher;
	/** 발행일 */
	private Date datetime;
	/** 표지이미지 <br> Book Image URL */
	private String thumbnail;
	/** 책소개 */
	private String contents;
	/** 가격 (단위: 원) */
	private Long price;
	/*댓글수*/
	private int reviewCnt; 

}
