package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/delete.do")
public class DeleteController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		회원제 게시판이므로 삭제시 작성자 본인인지 확인해야한다. 먼저
		로그인이 된 상태인지 확인한다. */
		//request 내장객체를 통해 session 내장객체를 얻어옴
		HttpSession session = req.getSession();
		//session 영역에 회원 인증번호가 저장되었는지 확인
		if(session.getAttribute("UserId") == null) {
			JSFunction.alertLocation(resp,
					"로그인 후 이용해주세요.", "../06Session/LoginForm.jsp");
			return;
		}
		
		//로그인이 된 상태라면 게시물을 삭제한다.
		String idx = req.getParameter("idx");
		MVCBoardDAO dao = new MVCBoardDAO();
		//작성자 본인인지 확인하기 위해 게시물 열람을 위한 메서드 호출
		MVCBoardDTO dto = dao.selectView(idx);
		
		/*DB에 등록된 작성자 아이디와 session영역에 저장된 아이디가
		일치하는지 확인한다. 즉 로그인한 사용자가 작성자가 맞는지 확인한 후
		일치하지 않으면 경고창을 띄우고, 뒤로 이동한다. */
		if(!dto.getId().equals(session.getAttribute("UserId")
				.toString())) {
			JSFunction.alertBack(resp, 
					"작성자 본인만 삭제할 수 있습니다.");
			return;
		}
		
		//작성자가 확인되었다면 게시물을 삭제한다.
		int result = dao.deletePost(idx);
		//DB 자원 해제
		dao.close();
		//게시물 삭제에 성공했다면..
		if (result == 1) { // 게시물 삭제 성공 시 첨부파일도 삭제
			//첨부파일도 함께 삭제한다. 저장된 파일명을 얻어온 후
			String saveFileName = dto.getSfile();
			//파일을 물리적으로 삭제한다.
			FileUtil.deleteFile(req, "/Uploads", saveFileName);
		}
		//삭제후에는 목록으로 이동한다.
		JSFunction.alertLocation(resp, "삭제되었습니다.", 
				"../mvcboard/list.do");
		
	}
}
