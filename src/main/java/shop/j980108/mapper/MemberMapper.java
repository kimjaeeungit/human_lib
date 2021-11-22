package shop.j980108.mapper;

import java.util.Map;

import shop.j980108.domain.AuthVo;
import shop.j980108.domain.MemberVo;

public interface MemberMapper {
	//회원가입
	//void memberJoin(MemberVo member) throws Exception; 
	//회원로그인
	int memberLogin(MemberVo member) throws Exception;
	//테스트회원가입
	void memberJoin(Map<String, Object> map);
	//테스트회원가입후 권한
	void authJoin(Map<String, Object> map);
	//테스트회원로그인 리드
	MemberVo memberLogin(String string) throws Exception;
	//회원가입후 권한
	void authJoin(AuthVo auth);

	//회원탈퇴(등급 변경)
	void memberDelete(String id) throws Exception;
	//권한삭제
	void authDelete(String id) throws Exception;
	
	MemberVo read(String userid);
	
	MemberVo login(MemberVo member);
	
	MemberVo login(String id);
	//정보수정
	void memberModify(MemberVo vo);
	
	/** 아이디로 회원 조회
	 * @author 박인영
	 * @date 2021-11-02
	 */
	MemberVo findMemberByID(String id);
	
	/** 회원의 대출중 도서수(loansCnt) 변경
	 * @author 박인영
	 * @date 2021-11-01
	 */
	void updateMemberLoansCnt(MemberVo member);
}
