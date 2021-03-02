package ino.web.freeBoard.controller;

import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	@ResponseBody
	public ModelAndView main(@RequestParam HashMap<String, Object> info){
		
		int page = 0;
		if(info.get("page") == null){
			page = 1;
		} else if(info.get("page") != null){
			page = Integer.parseInt((String)info.get("page"));
		}
		int index1 = (page - 1) * 10 + 1;
		int index2 = index1 + 9;
		
		info.put("index1", index1);
		info.put("index2", index2);
		
		int pageStart, pageEnd;
		
		pageStart = page / 10;
		if(pageStart%10 != 0){
			pageStart = pageStart - 1;
		}
		pageStart = (pageStart * 10) + 1;
		pageEnd = pageStart + 9;
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object> list = freeBoardService.freeBoardList(info);
		Map<String, Object> codeList = freeBoardService.codeList();
		
		if(pageEnd > (Integer)list.get("pageCnt")){
			pageEnd = (Integer)list.get("pageCnt");
		}
		
		list.put("pageStart", pageStart);
		list.put("pageEnd", pageEnd);
		
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		mav.addObject("codeList",codeList);
		return mav;
	}
	
	@RequestMapping("/ajaxSearch.ino")
	@ResponseBody
	public Map<String, Object> ajaxSearch(@RequestParam HashMap<String, Object> info){
		int page = 1;
		if(info.get("page") == null){
			page = 1;
		} else if(info.get("page") != null){
			page = Integer.parseInt((String)info.get("page"));
		}
//		System.out.println(page);
		int index1 = (page - 1) * 10 + 1;
		int index2 = index1 + 9;
		
//		System.out.println(index1);
//		System.out.println(index2);
		
		info.put("index1", index1);
		info.put("index2", index2);
		
		int pageStart, pageEnd;
		
		pageStart = page / 10;
		if(pageStart%10 != 0){
			pageStart = pageStart - 1;
		}
		pageStart = (pageStart * 10) + 1;
		pageEnd = pageStart + 9;
		
		Map<String, Object> list = freeBoardService.freeBoardList(info);
		
		if(pageEnd > (Integer)list.get("pageCnt")){
			if((Integer)list.get("pageCnt") == 0){
				pageEnd = 1;
			}else{
				pageEnd = (Integer)list.get("pageCnt");
			}
		}
		System.out.println("pageEnd : "+pageEnd);
		list.put("pageStart", pageStart);
		list.put("pageEnd", pageEnd);
		
//		System.out.println(list.get("dtoList"));
		return list;
	}

	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}

	@RequestMapping("/freeBoardInsertPro.ino")
	@ResponseBody
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		freeBoardService.freeBoardInsertPro(dto);
		int num=freeBoardService.getNewNum();
		System.out.println(num);
		Map<String, Object> map= new HashMap<>();
		map.put("num", num);
		return map;
	}

	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request){
		int num=Integer.parseInt(request.getParameter("num"));
		ModelAndView mav = new ModelAndView();
		FreeBoardDto dto=freeBoardService.getDetailByNum(num);
		
		mav.setViewName("freeBoardDetail");
		mav.addObject("freeBoardDto",dto);
		return mav;
		/*return new ModelAndView("freeBoardDetail", "freeBoardDto", null);*/
	}

	@RequestMapping(value="/freeBoardModify.ino", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		int number=freeBoardService.freeBoardModify(dto);
		Map<String, Object> map = new HashMap<>();
		if(number==1){
			map.put("key", number);	
			return map;
		}else{
			map.put("key", number);
			return map;
		}
	}
	
	/*@RequestMapping(value="/freeBoardModify.ino", method=RequestMethod.POST)
	public ModelAndView freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		ModelAndView mav = new ModelAndView();
		freeBoardService.freeBoardModify(dto);
		mav.setViewName("freeBoardDetail");
		mav.addObject("11");
		return mav;
	}*/

	@RequestMapping("/freeBoardDelete.ino")
	public String FreeBoardDelete(int num){
		freeBoardService.FreeBoardDelete(num);
		return "redirect:/main.ino";
	}
	
	@RequestMapping("/delete.ino")
	@ResponseBody
	public int delete(@RequestParam Map<String, Object> val){
		int reTurn = 1;
		try {
			int cnt = Integer.parseInt((String)val.get("CNT"));
			String id = (String)val.get("VAL");
			String[] strArray = id.split(",");
			for (int i = 0; i < cnt; i++) {
				int num = Integer.parseInt(strArray[i]);
				freeBoardService.FreeBoardDelete(num);
				reTurn = cnt;
			}
		} catch (Exception e) {
			System.out.println("오류발생");
			reTurn = 0;
		}
		return reTurn;
	}
	
	@RequestMapping("/delete1.ino")
	@ResponseBody
	public int delete1(@RequestParam Map<String, Object> val){
		int reTurn;
		try {
			int cnt = Integer.parseInt((String)val.get("CNT"));
			String id = (String)val.get("VAL");
			String[] strArray = id.split(",");
			List<Object> list= new ArrayList<Object>();
			for(int i = 0; i < cnt; i++){
				list.add(strArray[i]);
			}
			System.out.println("list : "+list);
			freeBoardService.FreeBoardDelete1(list);
			reTurn = 1;
		} catch (Exception e) {
			System.out.println("오류발생");
			reTurn = 0;
		}
		return reTurn;
	}
	
	@RequestMapping("/list.ino")
	@ResponseBody
	public void main_page(@RequestParam HashMap<String, Object> info){
		int page = 0;
		int index1 = 0;
		int index2 = 0;
		if(info.get("page") == null){
			page = 1;
			index1 = page;
		} else if(info.get("page") != null){
			page = Integer.parseInt((String)info.get("page"));
		}
		index2 = page * 10;
		info.put("index1", index1);
		info.put("index2", index2);
		
		Map<String, Object> list = freeBoardService.freeBoardList(info);
	}
}