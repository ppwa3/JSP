package membership;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

/*
DAO(Data Access Object)
: 실제 데이터베이스에 접근하여 기본적인 CRUD 작업을 하기위한 객체.
DB접속 및 select와 같은 쿼리문을 실행한 후 결과를 반환하는 기능을
수행한다. 
*/

//JDBC를 위한 클래스를 상속하여 DB에 연결한다.
public class MemberDAO extends JDBConnect{
	//생성자1
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	//생성자2
	public MemberDAO(ServletContext application) {
		super(application);
	}
	/*
	사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 select한 후
	존재하는 회원정보인 경우 DTO객체에 인출한 레코드를 저장한 후 반환한다. */
	public MemberDTO getMemberDTO(String uid, String upass) {
		
		//회원인증을 위한 쿼리문 실행 후 레코드 저장을 위한 인스턴스 생성
		MemberDTO dto = new MemberDTO();
		//인파라미터가 있는 select쿼리문 작성
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			//쿼리문 실행을 위해 객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리문 실행 후 ResultSet객체 반환
			rs = psmt.executeQuery();
			//반환된 ResultSet객체에 정보가 저장되어 있다면..
			if (rs.next()) {
				//DTO 객체에 각 컬럼의 값을 저장한다.
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		//회원정보를 저장한 DTO객체를 반환한다.
		return dto;
	}
}
