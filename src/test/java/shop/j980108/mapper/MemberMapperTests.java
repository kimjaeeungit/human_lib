package shop.j980108.mapper;

import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.controller.MemberController;
import shop.j980108.domain.MemberVo;
import shop.j980108.persistence.DataSourceTests;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired @Setter
	private MemberMapper memberMapper;
	@Autowired @Setter @Qualifier("BCryptPasswordEncoder")
	private PasswordEncoder pwencoder;
	@Autowired @Setter
	private DataSource ds;
 
	@Test
	public void testmemberJoin() throws Exception{
		MemberVo member = new MemberVo();
		
		String sql = "INSERT INTO TBL_MEMBER(ID, PWD, STUDNO, NAME, NICKNAME, PHONE, EMAIL, UUID)" +
				"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	   
		Connection con = null;
		PreparedStatement pstmt = null;
	   
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(2, pwencoder.encode("pw00"));
			pstmt.setString(1, "melona");
			pstmt.setInt(3, 12121);
			pstmt.setString(4, "메로나");
			pstmt.setString(5, "상큼한메로나");
			pstmt.setString(6, "010-1234-5671");
			pstmt.setString(7, "melona@naver.com");
			pstmt.setString(8, "#");
			
			pstmt.executeUpdate();
	}catch(SQLException e){
		e.printStackTrace();
	}  	 
}
   
   	@Test
   	public void testLogin() throws Exception{
	   	MemberVo member = memberMapper.memberLogin("iiii");
	   	log.info(member);
	   	member.getAuths().forEach(log::info);
   	}
   
   		@Test
   		public void testmemberModify() throws Exception {
   		MemberVo vo = new MemberVo();
	    
   		//vo = memberMapper.memberLogin("iiii");
	    //log.info(vo);
	    vo.setId("iiii");
	    vo.setPwd(pwencoder.encode("2222"));
	    vo.setNickName("조윤정");
	    vo.setEmail("eeee@naver.com");
	    vo.setPhone("010-1234-1444");
	    vo.setUuid("#");
	      
	      memberMapper.memberModify(vo);
	    log.info(vo);
}
	
   
@Test
public void testmemberDelete() throws Exception{
	MemberVo vo = memberMapper.read("iiii");
	log.info(vo);
      
	String sql = "UPDATE TBL_MEMBER" +
	"GRADE = 0" +
	"WHERE ID = #{id}";
}

@Test
public void testauthDelete() throws Exception{
	MemberVo vo = memberMapper.read("iiii");
	log.info(vo);
      
	String sql = "DELETE FROM TBL_AUTH" +
			"WHERE ID = #{id}";
}
   
   
	/** 아이디로 회원 조회
	 * @author 박인영
	 * @date 2021-11-02
	 */
	@Test
	public void testFindMemberByID() {
		log.info(memberMapper.findMemberByID("dldlrwns"));
	}
  
	/** 회원의 대출중 도서수(loansCnt) 변경
	 * @author 박인영
	 * @date 2021-11-01
	 */
	@Test
	public void testUpdateLoansCnt() {
		MemberVo member = new MemberVo();
		member.setId("아이디1");
		member.setLoansCnt(-1L);
		memberMapper.updateMemberLoansCnt(member);
		log.info(member);
	}
}