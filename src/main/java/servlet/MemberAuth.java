package servlet;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import membership.MemberDAO;
import membership.MemberDTO;

public class MemberAuth extends HttpServlet{
	
	//서블릿에서 멤버변수 선언
	MemberDAO dao;
	
	/*
	클라이언트가 최초로 요청했을때 서블릿 객체가 생성되는데 이때 최초
	한번만 호출되는 init()에서 DB연결 처리를 한다. */
	@Override
	public void init() throws ServletException {
		/*
		서블릿 내에서 application 내장객체를 얻어온다. 모델2 방식에서는
		서블릿이 먼저 요청을 받기 때문에 모델1 방식과 같이 JSP에서 매개변수로
		내장객체를 전달할 수 없다. 따라서 각 내장객체를 얻어올 수 있는
		메서드가 존재한다.*/
		ServletContext application = this.getServletContext();
		
		//web.xml에 저장된 컨텍스트 파라미터를 읽어온다.
		String driver = application.getInitParameter("OracleDriver");
		String connectUrl = application.getInitParameter("OracleURL");
		String oId = application.getInitParameter("OracleId");
		String oPass = application.getInitParameter("OraclePwd");
		
		//DB접속정보를 통해 연결한다.
		dao = new MemberDAO(driver, connectUrl, oId, oPass);
	}
	/*
	service()는 서블릿 수명주기에서 get/post방식 모두를 처리할 수 있다. */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		//서블릿 초기화 파라미터를 얻어온다.
		String admin_id = this.getInitParameter("admin_id");
		
		//파라미터로 전달된 회원정보를 얻어온다.
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		//회원인증을 위한 메서드를 호출한다. 일치하는 정보가 있다면 
		//회원레코드를 DTO에 저장한 후 반환한다.
		MemberDTO memberDTO = dao.getMemberDTO(id, pass);
		
		String memberName = memberDTO.getName();
		//인증 여부에 따라 각 메세지를 request 영역에 저장한다.
		if(memberName != null) {
			req.setAttribute("authMessage", memberName + " 회원님 방가방가^^*");
		}
		else {
			if (admin_id.equals(id))
				req.setAttribute("authMessage", admin_id + "는 최고 관리자입니다.");
			else
				req.setAttribute("authMessage", "귀하는 회원이 아닙니다.");
		}
		//앞에서 판단한 인증정보는 request영역에 저장후 JSP로 포워드한다.
		req.getRequestDispatcher("/12Servlet/MemberAuth.jsp").forward(req, resp);
	}
	
	//서블릿을 종료하면 DAO도 같이 자원해제한다.
	@Override
	public void destroy() {
		dao.close();
	}
}
