package model2.mvcboard;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//어노테이션으로 매핑 처리
@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	
	/*
	service() 메서드
		서블릿의 수명주기 함수에서 요청을 먼저 받아 GET 혹은 
		POST방식인지 판단하여 분기하는 함수로 2가지 방식의 
		요청을 모두 처리할 수 있다.
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//게시물 레코드를 저장하기 위한 DTO 인스턴스
		MVCBoardDAO dao = new MVCBoardDAO();
		//파라미터로 전달된 일련번호 받기
		String idx = req.getParameter("idx");
		//게시물의 조회수를 증가
		dao.updateVisitCount(idx);
		//일련번호에 해당하는 게시물 인출
		MVCBoardDTO dto = dao.selectView(idx);
		dao.close();
		
		/*
		DTO 인스턴스에 저장된 내용 부분을 <br> 태그로 줄바꿈 처리
		후 다시 setter로 저장한다. */
		dto.setContent(dto.getContent()
				.replaceAll("\r\n", "<br/>"));
		
		
		//request영역에 저장한 후 View로 포워드한다.
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/14MVCBoard/View.jsp")
			.forward(req, resp);
		
	}
}
