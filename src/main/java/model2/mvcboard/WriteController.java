package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

/*
글쓰기를 위한 컨트롤러는 페이지로 진입하기 위한 doGet()과 쓰기처리를 위한
doPost()를 한꺼번에 정의해야한다. */
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
	/*
	글쓰기 페이지에 진입하는것은 버튼을 클릭하여 이동하게 되므로
	GET방식의 요청이다. */
	@Override
	protected void doGet(HttpServletRequest req,
			HttpServletResponse resp)
					throws ServletException, IOException {
		//로그인 확인을 위해 session내장객체를 얻어온다.
		HttpSession session = req.getSession();
		
		//session영역에 회원인증에 관련된 속성이 없다면 로그인 페이지로
		//이동한다.
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.",
					"../06Session/LoginForm.jsp");
			//Java코드가 더이상 실행되지 않도록 중지한다.
			return;
		}
		//로그인이 완료된 상태라면 쓰기페이지를 포워드한다.
		req.getRequestDispatcher("/14MVCBoard/Write.jsp")
		.forward(req, resp);
			}
	/*
	글쓰기 처리는 POST방식의 요청이다.
	*/
	@Override
	protected void doPost(HttpServletRequest req,
			HttpServletResponse resp)
					throws ServletException, IOException {
		/*
		로그인 확인. session은 일정 시간이 지나면 자동으로 소멸되므로
		확인이 필요하다. */
		HttpSession session = req.getSession();
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.",
					"../06Session/LoginForm.jsp");
			return;
		}
		
		//파일 업로드를 위한 물리적경로 확인
		String saveDirectory = req.getServletContext()
				.getRealPath("/Uploads");
		
		// 파일 업로드 처리
		String originalFileName = "";
		try {
			//작성폼에서 전송한 파일을 업로드 처리
			originalFileName = FileUtil.uploadFile(req,
					saveDirectory);
		}
		catch (Exception e) {
			//업로드에 문제가 있다면 경고창을 띄우고 작성페이지로 이동
			JSFunction.alertLocation(resp, "파일 업로드 오류입니다.",
					"../mvcboard/write.do");
			return;
		}
		// 폼값을 DTO인스턴스에 저장
		MVCBoardDTO dto = new MVCBoardDTO();
		//작성자 아이디는 session영역에 저장된 데이터 사용
		dto.setId(session.getAttribute("UserId").toString());
		//제목, 내용은 사용자가 입력한 값을 사용
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		
		//첨부한 파일이 있다면 파일명을 변경
		if (originalFileName != "") {
			// 파일명 변경
			String savedFileName = FileUtil
					.renameFile(saveDirectory, originalFileName);
			//업로드된 파일의 정보를 DTO인스턴스에 저장
			dto.setOfile(originalFileName); //원본 파일명
			dto.setSfile(savedFileName); //서버에 저장된 파일명
		}
		
		//endsWith는 문자열의 메서드로 문자열이 특정 문자로 끝나는지 확인해주는 기능
		
		String fileType;
		
		if(dto.getSfile().endsWith("png") || dto.getSfile().endsWith("gif")
				|| dto.getSfile().endsWith("jpg")) {
		}
		else if(dto.getSfile().endsWith("mp3") || dto.getSfile().endsWith("wav")) {
			
		}
		else if(dto.getSfile().endsWith("mp4") || dto.getSfile().endsWith("avi")
				|| dto.getSfile().endsWith("wmv")) {
			
		}
		else {
		
		}
		
		
		//DAO 인스턴스 생성 및 커넥션풀을 통한 연결
		MVCBoardDAO dao = new MVCBoardDAO();
		//insert 쿼리문 실행
		int result = dao.insertWrite(dto);
		//자원반납
		dao.close();
		
		if (result == 1) {
			//글쓰기에 성공하면 목록으로 이동
			resp.sendRedirect("../mvcboard/list.do");
		}
		else {
			//실패라면 쓰기페이지로 이동
			JSFunction.alertLocation(resp, "글쓰기에 실패했습니다.",
					"../mvcboard/write.do");
		}
	}
}
