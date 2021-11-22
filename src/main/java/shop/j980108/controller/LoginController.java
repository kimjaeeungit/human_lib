package shop.j980108.controller;

/** 로그인, 로그아웃, 회원탈퇴 컨트롤러
 * @author 양희찬
 * @date 2021-11-01
 */

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import shop.j980108.service.MemberService;

@Component
@Controller @Log4j
@RequestMapping("/member")
public class LoginController {
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired @Setter
	MemberService memberservice;
	
	//로그인 get
	@GetMapping("/login")
	public String login(String error, Model model){
		log.info("error : " + error);
		
		if(error != null){
			model.addAttribute("error", "Login error check your accout");
		}
		return "/member/login";
	}
	
	
//탈퇴
@GetMapping("/delete")
public void getDelete(){

}
	
@PostMapping("/delete")
public String deleteMember
	(@RequestParam("id") String id,RedirectAttributes redirectAttr, SessionStatus sessionStatus) throws Exception {
		log.info("탈퇴전"+id);      
		memberservice.memberDelete(id);
		redirectAttr.addFlashAttribute("msg", "회원탈퇴가 정상적으로 이뤄졌습니다.");
		SecurityContextHolder.clearContext();
	
		memberservice.authDelete(id);
		redirectAttr.addFlashAttribute("msg", "권한삭제");
		SecurityContextHolder.clearContext();
	
		return "/common/index";
	
	}
	
}


