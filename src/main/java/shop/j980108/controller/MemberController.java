package shop.j980108.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

/** 회원가입, 프로필, 정보수정 컨트롤러
 * @author 양희찬
 * @date 2021-11-01
 */

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import shop.j980108.domain.MemberVo;
import shop.j980108.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired @Setter @Qualifier("BCryptPasswordEncoder")
	private PasswordEncoder encoder;
	@Autowired @Setter
	MemberService memberservice;
	
	
	//회원가입약관 get
	@GetMapping("terms")
	public void getTerms(){
		logger.info("회원가입약관");
	}
	
	//회원가입약관 post
	@PostMapping("terms")
	public String postTerms(MemberVo member) throws Exception{
		logger.info("가입페이지이동");
		
		return "redirect:/member/join";
	}
	
	//회원가입 get
	@GetMapping("join")
	public void getmemberJoin(){
		logger.info("회원가입");
	}
	
	//회원가입 post
	@PostMapping("join")
	public String postmemberJoin(@RequestParam Map<String, Object> member) throws Exception{
		logger.info("가입진행");
		
		System.out.println(member);
		member.put("pwd", encoder.encode((CharSequence) member.get("pwd")));
		memberservice.memberJoin(member);
		member.put("auth", "ROLE_MEMBER");
		memberservice.authJoin(member);
		
		return "redirect:/member/login";
	}
	
	//프로필 get
	@GetMapping("profile")
	public void getmemberprofile(){
		logger.info("프로필");
	}	
	
	//프로필 post
	@PostMapping("profile")
	public String postmemberprofile(MemberVo member) throws Exception{
		logger.info("프로필수정페이지 이동");
		
		return "redirect:/member/profilemodify";
	}
	
	//프로필수정 get
	@GetMapping("profilemodify")
	public void getmemberModify(){
		logger.info("프로필수정");
	}
	
	//프로필 post
	@PostMapping("profilemodify")
	public String postmemberModify(MemberVo member, RedirectAttributes rttr, String id) throws Exception{
		logger.info("정보수정");
		
		
		memberservice.memberModify(member);
		
			rttr.addAttribute("nickName",((MemberVo) member).getNickName());
			rttr.addAttribute("phone",((MemberVo) member).getPhone());
			rttr.addAttribute("email",((MemberVo) member).getEmail());
			
		return "redirect:/member/profile";
	}
}
