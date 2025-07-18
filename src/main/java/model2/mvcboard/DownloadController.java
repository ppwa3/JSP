package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//어노테이션으로 매핑처리
//컨트롤러
@WebServlet("/mvcboard/download.do")
public class DownloadController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//다운로드 링크를 클릭했을때 전달된 파라미터 받아오기
		String ofile = req.getParameter("ofile"); // 원본 파일명
		String sfile = req.getParameter("sfile"); // 저장된 파일명
		String idx = req.getParameter("idx"); // 게시물 일련번호
		
		//다운로드를 위한 유틸리티 메서드 호출
		FileUtil.download(req, resp, "/Uploads", sfile, ofile);
		
		//다운로드 횟수 증가
		MVCBoardDAO dao = new MVCBoardDAO();
		dao.downCountPlus(idx);
		dao.close();
	}
}
