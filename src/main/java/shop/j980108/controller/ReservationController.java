package shop.j980108.controller;

import java.security.Principal;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.Criteria;
import shop.j980108.domain.PageDTO;
import shop.j980108.domain.ReservationVo;
import shop.j980108.service.ReservationService;
import shop.j980108.service.SeatService;

/**
 * @author 조윤정
 * @date 2021-10-27~
 * @name 예약 컨트롤러
 */

@Controller
@Log4j
@AllArgsConstructor
public class ReservationController {
	private SeatService service;
	private ReservationService rservice;
	
	@PostMapping("seat/list")
	public String insert(ReservationVo vo,@RequestParam("revs")ArrayList<Integer>revList,RedirectAttributes rttr){
		log.info("chooseFrm.submit");
		log.info(vo);
		log.info(revList);
		vo.setRevList(revList);
    	int rCode=rservice.makeRev(vo);
    	rttr.addFlashAttribute("vo", vo);
    	if(rCode==1){
    		rttr.addFlashAttribute("code",rCode);
    		return "redirect:/seat/mypage";
    	}else if(rCode==2){
    		rttr.addFlashAttribute("code",rCode);
    		return "redirect:/seat/choose";
    	}
		return "redirect:/seat/complete";
	}
	
	@ResponseBody
	@DeleteMapping("seat/delete/{revNo}")
	public String delete(@PathVariable long revNo){
		log.info("cancel"+revNo);
		rservice.cancelRev(revNo);
		return "success";
	}
	
	@GetMapping("seat/mypage")
	public void mypage(Model model,Criteria cri, Principal principal){
		log.info("seat: mypage");
		log.info(principal);
		log.info(principal.getName());
		int hour=LocalTime.now().getHour();
		Date today = new Date();
		model.addAttribute("current", service.getCurrentTime());
		model.addAttribute("today",today);
		model.addAttribute("hour",hour);
		model.addAttribute("list", rservice.getMyRev(cri,principal.getName())); 
		model.addAttribute("page", new PageDTO(rservice.myRevCount(principal.getName()),cri));
	}
	
	@GetMapping("seat/admin")
	public void admin(Model model,Criteria cri){
		log.info("seat : admin");
		int hour=LocalTime.now().getHour();
		Date today = new Date();
		model.addAttribute("current", service.getCurrentTime());
		model.addAttribute("today",today);
		model.addAttribute("hour",hour);
		model.addAttribute("list",rservice.getRevList(cri));
		model.addAttribute("page", new PageDTO(rservice.getRevCount(),cri));
	}
	
}
