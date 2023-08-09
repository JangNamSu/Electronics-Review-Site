package com.human.util;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileDataUtil {
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@RequestMapping(value="download", method=RequestMethod.GET)
	@ResponseBody // 리턴타입이 view가 아니라 객체이다.. 컨트롤러가 view가 아닌 직접 데이터 전송
	public FileSystemResource download(@RequestParam("filename") String filename,
			HttpServletResponse re) throws Exception{
		File file = new File(uploadPath+"/"+filename);
		re.setContentType("application/download); utf-8");
		re.setHeader("Content-disposition", "attachment; filename=" + filename);
		
		return new FileSystemResource(file);
	}
	
	public String fileUpload(MultipartFile[] file) throws Exception{ // 프로필사진
		// 1. 컨트롤러가 받은 첨부파일을 내가 원하는 곳에(servlet_context uplodadPath로 지정한 곳) 저장
		// 2. 파일을 유니크하게 재 정의 함..
		
		String saveName;
		
		String orName =file[0].getOriginalFilename();
		UUID uid=UUID.randomUUID(); // 랜덤문자
		saveName = uid+"."+orName.split("\\.")[orName.split("\\.").length-1];
		
		byte[] fileData = file[0].getBytes(); // 첨부파일 byte[] 에 저장
		File target = new File(uploadPath, saveName); // 폴더 위치에 파일 생성
		FileCopyUtils.copy(fileData, target); // 바이트 복사
		
		return saveName;
		

	}
	
	public String[] memoFileUpload(MultipartFile[] file) throws Exception{ // 게시글 사진
		
		String[] saveName = new String[file.length];
		
		for(int i=0; i<saveName.length; i++) {
			if(file[i].getOriginalFilename() != null) {
				if(file[i].getOriginalFilename() !="") {
					String orName =file[i].getOriginalFilename();
					UUID uid=UUID.randomUUID(); // 랜덤문자
					saveName[i] = uid+"."+orName.split("\\.")[orName.split("\\.").length-1];
					
					byte[] fileData = file[i].getBytes(); // 첨부파일 byte[] 에 저장
					File target = new File(uploadPath, saveName[i]); // 폴더 위치에 파일 생성
					FileCopyUtils.copy(fileData, target); // 바이트 복사
				}
			}
		}
		return saveName;
	}
	
}
