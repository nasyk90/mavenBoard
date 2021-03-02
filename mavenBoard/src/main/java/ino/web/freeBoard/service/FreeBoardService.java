package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public Map<String, Object> freeBoardList(HashMap<String, Object> info){
		List<Map<String, Object>> dto = sqlSessionTemplate.selectList("freeBoardGetList",info);
		
		int record = sqlSessionTemplate.selectOne("freeBoardGetListCnt",info);
		int pageCnt = record/10;
		if(pageCnt%10 != 0){
			pageCnt++;
		}
		System.out.println("pageCnt : "+ pageCnt);
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("pageCnt", pageCnt);
		returnMap.put("dtoList", dto);
		
		
		return returnMap;
	}


	public void freeBoardInsertPro(FreeBoardDto dto){
		sqlSessionTemplate.insert("freeBoardInsertPro",dto); // insert(mapper이름, parameter값)
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	public int freeBoardModify(FreeBoardDto dto){
		int cnt = 0;
		try {
			/*System.out.println("222222222222222222222222");*/
			cnt = sqlSessionTemplate.update("freeBoardModify", dto);
			/*System.out.println("33333333333333333333333");*/
			return cnt;
		} catch (Exception e) {
			return 0;
		}
	}
	
	public void FreeBoardDelete (int num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);
	}
	
	public void FreeBoardDelete1 (List<Object> list) {
		System.out.println("delete1 : list = "+list);
		sqlSessionTemplate.delete("freeBoardDelete1", list);
	}

	public int freeBoardRecord(){
		int page_cnt = sqlSessionTemplate.selectOne("pageCnt");
		return page_cnt;
	}
	
	public Map<String, Object> codeList(){
		List<Map<String, Object>> dtoA = sqlSessionTemplate.selectList("codeListA");
		List<Map<String, Object>> dtoB = sqlSessionTemplate.selectList("codeListB");
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("codeListA", dtoA);
		returnMap.put("codeListB", dtoB);
		
		return returnMap;
	}
	

}
