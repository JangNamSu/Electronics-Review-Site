package com.human.electronics;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.human.VO.M_CommentVO;
import com.human.VO.M_likeVO;
import com.human.VO.MemberVO;
import com.human.VO.MemoVO;
import com.human.VO.PageVO;
import com.human.service.EletronicsServiceImpl;
import com.human.util.FileDataUtil;

@Controller
public class HomeController {
	
	@Inject
	EletronicsServiceImpl elesrv;
	
	@Inject
	FileDataUtil filedatautil;
	
	@RequestMapping(value = "/", method = RequestMethod.GET) // 메인화면요청
	public String home(Locale locale, Model model) {
//		model.addAttribute("serverTime", formattedDate );
		return "home";
	}
	
	@RequestMapping(value = "/sing_up_form", method = RequestMethod.GET) // 회원 가입 폼요청
	public String sing_up_form(Locale locale, Model model) {

		return "sing_up_form";
	}
	
	@RequestMapping(value = "/sing_up_save", method = RequestMethod.POST) // 회원 가입 갱신 요청
	public String sing_up_save(Locale locale, Model model,
			@ModelAttribute("")MemberVO mvo, MultipartFile[] file) throws Exception{
		
		if(file[0].getOriginalFilename() != "") { // 파일을 선택했을때만 프로필 사진 변경가능
			String name = filedatautil.fileUpload(file);
			mvo.setM_pro(name);
		}

		System.out.println("프로필사진명은 : "+mvo.getM_pro());
		
		elesrv.insertOne(mvo);
		return "home";
	}
	
	@RequestMapping(value = "/write_form", method = RequestMethod.GET) // 게시글 쓰기 폼요청
	public String write_form(Locale locale, Model model, HttpSession session) {
		// 게시글을 쓰려면 member id를 참조해야함
		// 로그인한 정보를 model.addAttribute를 통해서 write_form 으로 값을 넘겨주고 
		// write_save 요청시 파라미터 값으로 받고 이때 매핑하여 DB작업을 한다?
		
		String nowUserId = (String) session.getAttribute("nowUser");
		
		if(nowUserId == null) {
//			System.out.println("로그인을 해야함");
			return "redirect:/"; // 홈으로 리다이렉트
		}else {
//			System.out.println(nowUserId+" 으로 게시글 작성 진입");
			model.addAttribute("userId",nowUserId);
			return "write_form";
		}
		
	}
	
	@RequestMapping(value = "/write_save", method = RequestMethod.POST) // 게시글 작성 갱신 요청
	public String write_save(Locale locale, Model model,@ModelAttribute("")MemoVO vo,
			MultipartFile[] MemoFile)
	throws Exception{
		
		String[] newName = filedatautil.memoFileUpload(MemoFile);
		int sqNum = elesrv.memoNum(); // 글 작성번호
		vo.setM_num(sqNum);
		System.out.println("시퀀스번호(작성글번호) "+sqNum);
		for(int i=0; i<newName.length; i++) {
			System.out.println("newName값은 "+newName[i]);
		}
		elesrv.memoInsertOne(vo); //게시글 작성
		elesrv.picInsert(sqNum, newName); // 게시글 사진 등록
	
		return "home";
	}
	
	@RequestMapping(value = "/list_view", method = RequestMethod.GET) // 게시글 전체보기
	public String list_view(Locale locale, Model model, @ModelAttribute("")PageVO pagevo)
	throws Exception{
		
		if(pagevo.getPage() == null) {
			pagevo.setPage(1);
			System.out.println(pagevo.getPage()+"로 페이지 번호 설정1");
		}else {
			System.out.println(pagevo.getPage()+"로 페이지 번호 설정2");
		}
		// 페이지 정보를 계산하기 위해서 3가지 정보.. 1. page 2. perpageNum(초기값) 3. totalCount
		// totalCount를 알아야 한다.. select count(*) from schedule
		
//		select count(*) from memo;
		int tcnt = elesrv.totalCount(pagevo.getSearch_word()); 
		System.out.println("검색어는: "+pagevo.getSearch_word());
		System.out.println(tcnt+"건 가져옴");
		pagevo.setTotalCount(tcnt);
		pagevo.calcPage();
		
		List<MemoVO> allList = elesrv.memoSelectAll(pagevo);
		
//		model.addAttribute("memoList", elesrv.memoSelectAll());
		model.addAttribute("memoList", allList);
		model.addAttribute("pageVO",pagevo);
		
		return "list_view";
	}
	
	@RequestMapping(value = "/list_datail", method = RequestMethod.GET) // 게시글 상세보기
	public String list_datail(Locale locale, Model model,@RequestParam("viewNum")int num,
			HttpSession session) throws Exception{
		// select * from memo where m_num = 4; 
		
//		String nowUserId = (String) session.getAttribute("nowUser");
		
		String writeId = elesrv.memoWriteId(num); // 작성자 아이디
		
//		System.out.println("작성자 정보 "+mvo.getM_id());
		
		model.addAttribute("memoDatail",elesrv.memoDatailView(num));
		model.addAttribute("writeIdM_pro",elesrv.m_pro(writeId));
		model.addAttribute("memoNumPic",elesrv.memoNumPic(num));
		model.addAttribute("nowUserId",(String) session.getAttribute("nowUser")); // 현재 접속중인 아이디
		model.addAttribute("commentAll",elesrv.listAllComment(num));
		return "list_datail";
	}
	
	@RequestMapping(value = "/commentAdd", method = RequestMethod.GET) // 댓글등록 갱신요청
	public String commentAdd(Locale locale, Model model,@ModelAttribute("")M_CommentVO vo,
			@RequestParam("m_num")String memoNum)throws Exception {
		
//		vo.setM_id((String) session.getAttribute("nowUser")); // 현재 접속중인 아이디 세터로 셋팅
		System.out.println("댓글내용: "+vo.getM_c_con());
		System.out.println("댓글작성자 아이디: "+vo.getM_id());
		System.out.println("글번호: "+vo.getM_num());
		
		elesrv.commentAdd(vo);
		
		return "redirect:/list_datail?viewNum="+memoNum; // 파라미터로 받은 게시글 번호로 redirect
	}
	
	@RequestMapping(value = "/commentDel", method = RequestMethod.GET) // 댓글삭제
	public String commentDel(Locale locale,Model model,@RequestParam("delNum")int delComment
			,@RequestParam("m_num")String memoNum)throws Exception {
		
		System.out.println("삭제한 댓글번호: "+delComment);
		elesrv.commentDel(delComment);
		
		return "redirect:/list_datail?viewNum="+memoNum; // 파라미터로 받은 게시글 번호로 redirect
	}
	
	@RequestMapping(value = "/commentMod", method = RequestMethod.GET) // 댓글수정
	public String commentMod(Locale locale, Model model,@RequestParam("modNum")int modNum,
			@RequestParam("m_num")String memoNum,
			@RequestParam("inputModComment")String inputModComment)throws Exception{
		
//		System.out.println(inputModComment);
		elesrv.commentMod(modNum, inputModComment);
		
		return "redirect:/list_datail?viewNum="+memoNum; // 파라미터로 받은 게시글 번호로 redirect
	}
	
	@RequestMapping(value = "/myMemoList", method = RequestMethod.GET) // 내 게시물 리스트보기
	public String myMemoList(Locale locale, Model model,@RequestParam("nowUser")String nowUser) throws Exception{
		// select * from memo where m_id = 'test33';
		
		model.addAttribute("myMemoList",elesrv.myMemoSelect(nowUser));
		
		return "myMemo_list_view";
	}
	
	@RequestMapping(value = "/myMemoMod_form", method = RequestMethod.GET) // 내 게시물 수정 화면 요청
	public String myMemoMod_form(Locale locale, Model model,@RequestParam("modNum")int num) throws Exception{
		// select * from memo where m_id = 'test33';
		
		model.addAttribute("myMemoList",elesrv.memoDatailView(num));
		model.addAttribute("memoNumPic",elesrv.memoNumPic(num));
		return "myMemo_mod_form";
	}
	
	@RequestMapping(value = "/myMemoDelPic", method = RequestMethod.GET) //내 게시물 수정하기 사진 삭제
	public String delPic(Locale locale, Model model,@RequestParam("pname")String pname
			,@RequestParam("m_num")int num) throws Exception{
		// select * from memo where m_id = 'test33';
		
		System.out.println(pname);
		
		elesrv.picDel(pname);
		
		return "redirect:/myMemoMod_form?modNum="+num;
	}
	
	@RequestMapping(value = "/myMemoMod_save", method = RequestMethod.POST) //내 게시물 수정하기 갱신요청
	public String myMemoMod_save(Locale locale, Model model,
			MultipartFile[] MemoFile,@ModelAttribute("")MemoVO vo) throws Exception{
		// update memo set m_title= '제목수정테스트123' ,m_con = "수정내용테스트" where m_num = 188;
		
		elesrv.myMemoMod(vo);
		
		String[] newName = filedatautil.memoFileUpload(MemoFile);
		elesrv.picInsert(vo.getM_num(), newName);

		return "redirect:/myMemoList?nowUser="+vo.getM_id();
	}
	
	@RequestMapping(value = "/myMemoDel", method = RequestMethod.GET) // 내 게시물 삭제하기
	public String myMemoDel(Locale locale, Model model,
			@RequestParam("DelNum")int num,@RequestParam("m_id")String id)
					throws Exception{
		// delete from memo where m_num = 190;
		// 게시물 삭제 전에 모든 자식 레코드 삭제해야함 게시물에 사진이 있으면 전부다 삭제먼저 해야함
		elesrv.MemoNumdelPic(num);
		elesrv.selMemoCommentDel(num);
		elesrv.myMemoDel(num);
		
		if(id.equals("admin")) {
			return "redirect:/list_view";
		}else {
			return "redirect:/myMemoList?nowUser="+id;
		}
	}
	
	@RequestMapping(value = "/myInfo", method = RequestMethod.GET) // 내 정보 조회하기
	public String myInfo(Locale locale, Model model,@RequestParam("nowUser")String nowUser)
	throws Exception{
		//select * from member where m_id= 'test33';
		
		model.addAttribute("myInfo",elesrv.myInfo(nowUser));
		
		return "myInfo";
	}
	
	
	
	@RequestMapping(value = "/myInfoMod_form", method = RequestMethod.GET) // 내 정보 수정하기 폼요청
	public String myInfoMod_form(Locale locale, Model model,@RequestParam("nowUser")String nowUser)
	throws Exception{
		
		model.addAttribute("myInfo",elesrv.myInfo(nowUser));
		
		return "myInfoMod_form";
	}
	
	
	
	@RequestMapping(value = "/myInfoMod_save", method = RequestMethod.POST) // 내 정보 수정하기 갱신요청
	public String myInfoMod_save(Locale locale, Model model,@ModelAttribute("")MemberVO vo,
			MultipartFile[] file)
	throws Exception{
		// update set m_pass = '', m_pro='' where m_id = ?;
		
		if(file[0].getOriginalFilename() != "") { // 파일을 선택했을때만 프로필 사진 변경가능
			String name = filedatautil.fileUpload(file);
			vo.setM_pro(name);
		}
		
		elesrv.myInfoMod(vo);
		
		return "redirect:/myInfo?nowUser="+vo.getM_id();
	}
	
	@RequestMapping(value = "/myInfoDel_m_pro", method = RequestMethod.GET) // 내 정보 수정하기  프로필 사진 삭제
	public String myInfoMod_save(Locale locale, Model model,
			@RequestParam("m_id")String id) throws Exception{
//		update member set m_pro= null where m_id='test08';
		
		System.out.println(id);
		
		elesrv.myInfoDel_m_pro(id);
		
		return "redirect:/myInfoMod_form?nowUser="+id;
	}
	
	@RequestMapping(value = "/allMemberInfo", method = RequestMethod.GET) // 회원정보보기
	public String allMemberInfo(Locale locale, Model model) throws Exception{
//		select * from member;
		model.addAttribute("allMemberInfo",elesrv.allMemberInfo());
		
		return "allMemberInfo";
	}
	
	@RequestMapping(value = "/selMemberDel", method = RequestMethod.GET) // (관리자)선택한 회원 삭제 or 회원탈퇴
	public String selMemberDel(Locale locale, Model model,@RequestParam("m_id")String id,
			HttpSession session) throws Exception{
//		delete from member where m_id='test99';
//		delete from memo where m_id='test99';
//		delete from m_commnet where m_id='test99';
//		자식 레코드(등록한 댓글 삭제) -> 자식 레코드(등록한 게시글 삭제) -> 계정 삭제  회원탈퇴  순서대로 삭제해야함  
		elesrv.myCommentAllDel(id);
		elesrv.myMemoAllDel(id);
		elesrv.myInfoDel_m_pro(id);
		elesrv.selMemberDel(id);
		
		if(!session.getAttribute("nowUser").equals("admin")) {
			session.invalidate();
		}else {
		}	
		
		return "redirect:/allMemberInfo";
	}
	
	@RequestMapping(value = "/memoLike", method = RequestMethod.GET) // 게시글 추천 기능
	public String memoLike(Locale locale, Model model,@RequestParam("m_num")int num
			,@RequestParam("userId")String id, @ModelAttribute("")M_likeVO vo) throws Exception{
//		update memo set m_like=m_like+1 where m_num = ?;
//		select * from m_like where m_num = 187 and m_id = 'test33';
		
		vo.setM_id(id); // 아이디 세터로 셋팅
		
		int like_chk = elesrv.likeChk(vo);
		
		if(like_chk == 0) {
			System.out.println("테스트1");
			elesrv.likeAdd(vo);	// 추천 
			elesrv.memoLike(num); // 추천수 증가
			return "redirect:/list_datail?viewNum="+num;
		}else {
			System.out.println("테스트2");
//			elesrv.likeChkCancel(vo);
			elesrv.memoLikeDel(num); // 추천수 감소
			elesrv.likeDel(vo);
			return "redirect:/list_datail?viewNum="+num;
		}
	}
	
	// 아이디 중복체크 비동기 방식
	@ResponseBody
	@RequestMapping(value = "idcheck" ,method = RequestMethod.GET)
	public int checkId(@RequestParam("id") String id) throws Exception {
//		select count(*) from member where m_id='test33';
		int cnt = elesrv.checkId(id);
		
		return cnt;
	}
	
}
