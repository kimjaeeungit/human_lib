package shop.j980108.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import shop.j980108.domain.Criteria;
import shop.j980108.domain.LoansVo;
import shop.j980108.domain.PageDTO;
import shop.j980108.domain.SmsVo;
import shop.j980108.service.LoansService;
import shop.j980108.service.MemberService;
import shop.j980108.service.PossessionService;

/**
 * @author 박인영
 * @date 2021-10-26 ~ 
 * @name 대출 Controller
 */
@Controller
@Log4j
@RequestMapping("/loans")
@AllArgsConstructor
public class LoansController {
	
	private LoansService loansService;
	private PossessionService possessionService;
	private MemberService memberService;
	//★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	/** 대출 예약 by Member <br>
	 * - 필수 파라메터 : #{bkno}, #{id} <br>
	 * (1) 회원만 대출예약이 가능하다. <br>
	 * X (2) 패널티를 받지 않는 회원만 대출예약이 가능하다. <br> "대출 연체건으로 YYYY/MM/DD까지 대출예약이 불가능합니다" <br>
	 * (3) 현재 대출/대출예약 중인 도서수의 합계가 5권을 초과할 수 없다. <br>
	 * (4) 대출가능 도서만 대출예약이 가능하다. <br> "해당 도서는 현재 대출예약이 불가능한 도서입니다." <br>
	 * (5) 대출예약시 대출테이블에 튜플이 추가된다. <br>
	 * (6) 소장도서의 상태가 0(대출가능)에서 1(대출예약중)로 변경된다. <br>
	 * (7) 회원의 대출중도서수 합계가 1 증가한다. <br>
	 * X (8) 대출예약 확인문자가 발송된다. <br>
	 * X (9) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	//@PreAuthorize("isAuthenticated()")
	@ResponseBody 
	@PostMapping(value="reserveLoans", produces ="application/text; charset=utf8")
	public String reserveLoans(@RequestBody LoansVo loans) {
		if(memberService.findMemberByID(loans.getId()).getLoansCnt() >= 5)
			return "이미 회원님이 대출 또는 대출예약된 도서가 최대 대출 가능 권수인 5권입니다. 반납 또는 대출예약취소 후 이용해주세요";
		if(possessionService.getPossession(loans.getBkno()).getStatus() != 0)
			return "해당 도서의 상태가 변경되어 대출이 불가능합니다.";
		loansService.reserveLoans(loans);
		return "대출예약이 완료되었습니다.";
	}

	/** 대출 예약 취소 by Member <br>
	 * - 필수 파라메터 : 대출번호 lno, 도서번호 bkno, 아이디 id <br>
	 * - 사용자가 대출 예약 후 예약을 취소할 수 있다. <br>
	 * X (1) 대출예약 당사자만 취소가 가능하다. (jsp에서 처리) <br>
	 * (2) 대출예약일과 대출만기일에만 해당 대출의 상태가 0(대출 예약 신청) 또는 4(예약확정)이 아니면
	 * 		(예. 대출만기일이 지나 자동 취소 되거나 관리자가 도서상태(분실, 훼손 등)로 인해 먼저 취소한 경우) 취소할 수 없다. <br>
	 * (3) 대출 상태가 0(대출 예약 신청)에서 1(예약 사용자 취소)로 변경된다. <br>
	 * (4) 소장도서의 상태가 2(대출예약중)에서 0(대출가능)으로 변경된다. <br>
	 * (5) 회원의 대출중 도서수 합계가 1 감소한다. <br>
	 * X (6) 대출예약 사용자취소 문자가 발송된다. <br>
	 * X (7) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@ResponseBody
	@PostMapping(value="cancelLoansReservationByMember", produces ="application/text; charset=utf8")
	public String cancelLoansReservationByMember(@RequestBody LoansVo loans) {
		int status = loansService.findLoansByLno(loans.getLno()).getStatus();
		if(!(status == 0 || status == 4))
			return "대출 상태가 변경되어 대출예약 취소를 할 수 없습니다.";
		loansService.cancelLoansReservationByMember(loans);
		return "대출예약 취소가 완료되었습니다.";
	}
	//★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	/** 대출 예약 취소 by Task <br>
	 * - 필수 파라메터 : #{lno}, #{bkno}, #{id}, #{status == 2} <br>
	 * - 사용자가 대출만기일까지 대출하지 않으면 만기일 도서관 영업 종료 시간에 자동으로 예약이 취소된다. <br>
	 * X (1) 해당 대출의 상태가 0(대출 예약 신청) 또는 4(예약확정)이 아니면(예. 회원이 먼저 예약을 취소한 경우) 취소할 수 없다. <br>
	 * (2) 대출 상태가 0(대출 예약 신청) 또는 4(예약확정)에서 2(예약 자동 취소)로 변경된다. <br>
	 * (3) 소장도서의 상태가 2(대출예약중)에서 0(대출가능)으로 변경된다. <br>
	 * (4) 회원의 대출중 도서수 합계가 1 감소한다. <br>
	 * X (5) 대출예약 자동 취소 문자가 발송된다. <br>
	 * X (6) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@PostMapping("cancelLoansReservationByTask")
	public @ResponseBody void cancelLoansReservationByTask(@RequestBody LoansVo loans) {
		loansService.cancelLoansReservationByTask(loans);
	}

	/** 대출 예약 취소 by Manager <br>
	 * - 필수 파라메터 : 대출번호 lno, 도서번호 bkno, 아이디 id <br>
	 * - 관리자가 도서 픽업 중 도서 상태(분실, 훼손 등)를 확인 후 대출 예약을 취소할 수 있다. <br>
	 * (1) 관리자만 해당 페이지에 접근할 수 있다. (jsp에서 처리) <br>
	 * (2) 해당 대출의 상태가 0(대출 예약 신청)이 아니면(예. 회원이 먼저 예약을 취소한 경우) 취소할 수 없다. <br>
	 * (3) 대출 상태가 0(대출 예약 신청)에서 3(예약 관리자 취소)로 변경된다. <br>
	 * (4) 소장도서의 상태가 2(대출예약중)에서 3(대출불가)으로 변경된다. <br>
	 * (5) 회원의 대출중 도서수 합계가 1 감소한다. <br>
	 * X (6) 대출예약 관리자 취소 문자가 발송된다. <br>
	 * X (7) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@ResponseBody
	@PostMapping(value="cancelLoansReservationByManager", produces ="application/text; charset=utf8")
	public String cancelLoansReservationByManager(@RequestBody LoansVo loans) {
		if(loansService.findLoansByLno(loans.getLno()).getStatus() != 0)
			return "대출 상태가 변경되어 대출예약 취소를 할 수 없습니다.";
		loansService.cancelLoansReservationByManager(loans);
		return "대출예약이 취소되었습니다.";
	}

	/** 대출 예약 확정 by Manager <br> 
	 * - 필수 파라메터 : 대출번호 lno <br>
	 * - 관리자가 대출 예약 신청이 들어온 소장도서를 픽업하여 대출 예약을 확정한다. <br>
	 * (1) 관리자만 대출 예약을 확정할 수 있다. (jsp에서 처리) <br>
	 * (2) 해당 대출의 상태가 0(대출 예약 신청)이 아니면(예. 회원이 먼저 예약을 취소한 경우) 확정할 수 없다. <br>
	 * (3) 대출의 상태가 0(대출 예약 신청)에서 4(예약확정)로 변경된다. <br>
	 * X (4) 대출예약 확정 안내 문자가 발송된다. <br>
	 * X (5) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@ResponseBody
	@PostMapping(value="acceptLoans", produces ="application/text; charset=utf8")
	public String acceptLoans(@RequestBody LoansVo loans) {
		if(loansService.findLoansByLno(loans.getLno()).getStatus() != 0)
			return "대출 상태가 변경되어 대출예약 확정을 할 수 없습니다.";
		loansService.acceptLoans(loans);
		return "대출예약이 확정되었습니다.";
	}

	/** 대출 완료 by manager <br> 
	 * - 필수 파라메터 : 대출번호 lno, 도서번호 bkno <br>
	 * - 사용자가 대출만기일 이내에 도서관에서 대출을 완료한다. <br>
	 * (1) 관리자만 대출 완료처리를 할 수 있다. (jsp에서 처리) <br>
	 * X (2) 패널티를 받지 않은 회원만 대출이 가능하다. <br>
	 * (3) 대출의 상태가 4(예약확정)에서 5(대출)로 변경된다. <br>
	 * (4) 소장 도서의 상태가 1(대출예약중)에서 2(대출중)으로 변경된다. <br>
	 * X (5) 대출 후 반납예정일에 대한 안내 문자가 발송된다. <br>
	 * X (6) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@ResponseBody 
	@PostMapping(value="completeLoans", produces ="application/text; charset=utf8")
	public String completeLoans(@RequestBody LoansVo loans) {
		loansService.completeLoans(loans);
		return "대출이 완료되었습니다.";
	}
	
	/** 현장 대출 by Manager */
	@GetMapping("loans")
	public void loans() {}
	//★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	/** 현장 대출 by Manager <br>
	 * - 필수 파라메터 : #{bkno}, #{id} <br>
	 * - 사용자는 대출 예약 없이도 도서관에서 직접 대출을 할 수 있다. <br>
	 * X (1) 관리자만 현장 대출을 처리할 수 있다. <br>
	 * X (2) 가입한 회원의 대출만 처리가 가능하다. <br>
	 * X (3) 패널티를 받지 않은 회원만 대출이 가능하다. <br>
	 * X (4) 현재 대출/대출예약 중인 도서수의 합계가 5권을 초과할 수 없다.	 <br>
	 * (5) 대출테이블에 튜플이 추가된다. <br>
	 * (6) 소장도서의 상태가 0(대출가능)에서 2(대출중)로 변경된다. <br>
	 * (7) 회원의 대출중도서수 합계가 1 증가한다. <br>
	 * X (8) 대출 후 반납예정일에 대한 안내 문자가 발송된다.	 <br>
	 * X (9) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@PostMapping("loans")
	@ResponseBody 
	public void loans(@RequestBody LoansVo loans) {
		loansService.loans(loans);
	}
	//★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	/** 대출 연체 처리 by Task <br>
	 * - 필수 파라메터 : X <br>
	 * - 사용자가 반납예정일 이내에 반납처리 하지 않으면 일정 시간에 연체처리 된다. <br>
	 * (1) 매일 9시 전날 반납예정일이었던 대출 건 중 반납처리 되지 않은 건들의 상태를 5(대출)에서 6(연체)로 변경된다. <br>
	 * (2) 해당 회원에게 연체되었음을 안내하고 반납을 독촉하는 문자를 발송한다. <br>
	 * X (3) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 * */
	@PostMapping("checkLoansOverdue")
	@ResponseBody 
	public List<SmsVo> checkLoansOverdue() {
		return loansService.checkLoansOverdue();
	}

	/** 도서 반납 by Manager <br>
	 * - 필수 파라메터 : 대출번호 lno, 도서번호 bkno, 아이디 id <br>
	 * - 사용자가 도서관에 도서를 반납하면 관리자가 반납처리를 한다. <br>
	 * (1) 관리자만 도서 반납을 처리할 수 있다. (jsp에서 처리) <br>
	 * (2) 대출 상태가 5(대출) 또는 6(연체)에서 7(반납)로 변경된다. <br>
	 * (3) 소장 도서의 상태가 0(대출가능)으로 변경된다. <br>
	 * (4) 회원의 대출중도서수 합계가 1 감소한다. <br>
	 * X (5) 연체되었다면 연체일수만큼 패널티가 부과된다. <br>
	 * X (6) 도서 반납이 완료되었음을 안내하는 문자를 발송한다. <br>
	 * X (7) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@ResponseBody
	@PostMapping(value="returnLoans", produces ="application/text; charset=utf8")
	public String returnLoans(@RequestBody LoansVo loans) {
		loansService.returnLoans(loans);
		return "반납 처리가 완료되었습니다.";
	}

	/** 도서 영구미반납 by Manager <br>
	 * - 필수 파라메터 : 대출번호 lno, 도서번호 bkno, 아이디 id <br>
	 * - 사용자가 도서관에 도서를 반납할 수 없음을 알렸을 때 (분실, 훼손 등) 관리자가 관련 처리를 한다. <br>
	 * (1) 관리자만 도서 영구미반납을 처리할 수 있다. (jsp에서 처리) <br>
	 * (2) 대출 상태가 5(대출) 또는 6(연체)에서 8(영구미반납)로 변경된다. <br>
	 * (3) 소장 도서의 상태가 3(대출불가(분실, 훼손 등)으로 변경된다. <br>
	 * (4) 회원의 대출중도서수 합계가 1 감소한다. <br>
	 * X (5) 연체되었다면 연체일수만큼 패널티가 부과된다. <br>
	 * X (6) 도서 반납이 완료되었음을 안내하는 문자를 발송한다. <br>
	 * X (7) 문자발송 성공시 문자 테이블에 튜플이 추가된다.
	 */
	@ResponseBody
	@PostMapping(value="notReturnLoans", produces ="application/text; charset=utf8")
	public String notReturnLoans(@RequestBody LoansVo loans) {
		loansService.notReturnLoans(loans);
		return "영구 미반납 처리가 완료되었습니다.";
		
	}

	/** 대출 예약 현황 리스트 by Member <br>
	 * - 필수 파라메터 : 아이디 id <br>
	 * - 사용자는 본인이 예약한 현황을 조회할 수 있다. <br>
	 * - 대출 상태가 0(예약신청)인 건과 4(예약확정)인 건을 함께 조회한다.
	 */
	@GetMapping("listLoansReservationForMember")
	public void listLoansReservationForMember(Model model, Principal principal) {
		model.addAttribute("list", loansService.listLoansReservationForMember(principal.getName())); 
	}

	/** 대출 예약 신청 현황 리스트 by Manager <br>
	 * - 선택 파라메터 : 페이지번호 pageNum, 보여줄 대출갯수 amount <br>
	 * - 관리자는 사용자들이 대출 예약 신청한 현황을 조회할 수 있다. <br>
	 * - 대출 상태가 0(예약신청)인 건이 조회된다. <br>
	 * - 관리자는 해당 화면을 이용하여 확정(픽업) 및 대출취소(불가)를 처리한다. <br>
	 * - 관리자만 해당 페이지에 접근할 수 있다. (jsp에서 처리)
	 */
	@GetMapping("listLoansReservationRequest")
	public void listLoansReservationRequest(Model model, Criteria cri) {
		model.addAttribute("list", loansService.listLoansReservationForManager(cri, 0));
		model.addAttribute("page", new PageDTO(loansService.getLoansStatusTotalCount(0), cri));
	}

	/** 대출 예약 확정 현황 리스트 by Manager <br>
	 * - 선택 파라메터 : 페이지번호 pageNum, 보여줄 대출갯수 amount <br>
	 * - 관리자는 대출 예약 신청 건 중 확정(픽업)한 현황을 조회할 수 있다. <br>
	 * - 대출 상태가 4(예약확정)인 건이 조회된다. <br>
	 * - 관리자는 해당 조회 화면을 이용하여 대출 처리를 한다. <br>
	 * - 관리자만 해당 페이지에 접근할 수 있다. (jsp에서 처리)
	 */
	@GetMapping("listLoansReservationAccept")
	public void listLoansReservationAccept(Model model, Criteria cri) {
		model.addAttribute("list", loansService.listLoansReservationForManager(cri, 4));
		model.addAttribute("page", new PageDTO(loansService.getLoansStatusTotalCount(4), cri));
	}

	/** 대출중 리스트 by Member <br>
	 * - 필수 파라메터 : 아이디 id <br>
	 * - 사용자는 본인이 대출한 현황을 조회할 수 있다. <br>
	 * - 대출 상태가 5(대출)인 건과 6(연체)인 건을 함께 조회한다.
	 */
	@GetMapping("listLoansForMember")
	public void listLoansForMember(Model model, Principal principal) {
		model.addAttribute("list", loansService.listLoansForMember(principal.getName()));
	}

	/** 대출중 리스트 by Manager <br>
	 * - 선택 파라메터 : 페이지번호 pageNum, 보여줄 대출갯수 amount <br>
	 * - 관리자는 사용자들이 대출한 현황을 조회할 수 있다. <br>
	 * - 대출 상태가 5(대출)인 건과 6(연체)인 건을 함께 조회한다. <br>
	 * - 관리자만 해당 페이지에 접근할 수 있다. (jsp에서 처리)
	 */
	@GetMapping("listLoansForManager")
	public void listLoansForManager(Model model, Criteria cri) {
		model.addAttribute("list", loansService.listLoansForManager(cri));
		model.addAttribute("page", new PageDTO(loansService.getLoansDualStatusTotalCount(5, 6), cri));
	}

	/** 최근 반납 완료 리스트 by Member <br>
	 * - 필수 파라메터 : 아이디 id <br>
	 * - 선택 파라메터 : 페이지번호 pageNum, 보여줄 대출갯수 amount <br>
	 * - 사용자가 무인 반납기를 이용하여 반납할 경우 반납처리가 잘 되었는지 확인하기 위한 조회이다. <br>
	 * - 최근 일주일 간의 반납 완료된 건을 조회할 수 있다.
	 */
	@GetMapping("listReturnedLoansRecently")
	public void listReturnedLoansRecently(Model model, Criteria cri, String id) {
		model.addAttribute("list", loansService.listReturnedLoansRecently(cri, id));
		model.addAttribute("page", new PageDTO(loansService.getLoansDualStatusTotalCount(7, 8), cri));
	}

	/** 반납 완료 대출 리스트 by Member <br>
	 * - 필수 파라메터 : 아이디 id <br>
	 * - 선택 파라메터 : 페이지번호 pageNum, 보여줄 대출갯수 amount <br>
	 * - 사용자는 반납이 완료된 지난 대출 내역을 조회할 수 있다.
	 */
	@GetMapping("listReturnedLoans")
	public void listReturnedLoans(Model model, Criteria cri, Principal principal) {
		model.addAttribute("list", loansService.listReturnedLoans(cri, principal.getName()));
		model.addAttribute("page", new PageDTO(loansService.getLoansDualStatusTotalCount(7, 8), cri));
	}
	
}
