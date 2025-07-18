package fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

//파일업로드와 관련된 기능을 메서드로 정의한 유틸리티 클래스
public class FileUtil {

	//파일 업로드 처리(request내장객체, 파일을 저장할 경로)
	public static String uploadFile(HttpServletRequest req,
			String sDirectory) 
					throws ServletException, IOException {
		
		/*
		파일 첨부를 위한 <input>태그의 name속성값을 이용해서 Part
		인스턴스를 생성한다. 이를 통해 첨부파일을 서버에 저장할 수
		있다.
		 */
		Part part = req.getPart("ofile");
		
		/*
		Part인스턴스에서 헤더값을 얻어온다. 이를 통해 원본파일명을
		알 수 있다. */
		String partHeader = part.getHeader("content-disposition");
		System.out.println("partHeader = "+ partHeader);
		
		/*
		헤더값을 통해 얻어온 문자열에서 "filename="을 구분자로 
		Split한다. 그러면 String 타입의 배열로 반환된다. */
		String[] phArr = partHeader.split("filename=");
		/*
		얻어온 배열에서 1번 인덱스의 값을 아래와 같이 처리해서 
		파일명을 파싱한다. 더블쿼테이션을 제거해야 하므로 이스케이프
		시퀀스를 추가하여 replace함수를 실행해야 한다. */
		String originalFilename = phArr[1].trim().replace("\"", "");
		
		/*
		전송된 파일이 있는 경우라면 서버의 디렉토리에 파일을 
		저장한다.
		File.separator : 운영체제(OS)마다 경로를 표시하는 기호가
			다르므로, 해당 OS에 맞는 구분기호를 자동으로 
			추가해준다. */
		if (!originalFilename.isEmpty()) {
			part.write(sDirectory+ File.separator + originalFilename);
		}
		//원본파일명을 반환한다.
		return originalFilename;
	}
	
	//파일명 변경
	/*
	서버에 저장된 파일명을 변경한다. 파일명이 한글인 경우 
	웹브루저에서 깨짐 현상이 발생될 수 있으므로, 영문 혹은 
	숫자 조합으로 변경하는 것이 안전하다. */
	public static String renameFile(String sDirectory, 
			String fileName) {
		
		/*
		파일명에서 확장자를 잘라내기 위해 뒤에서부터 .의 위치를
		찾는다. 파일명에는 2개 이상의 .을 사용할 수 있기 때문이다. */
		String ext = fileName.substring(fileName.lastIndexOf("."));
		/*
		날짜와 시간을 이용해 파일명으로 사용할 문자열을 생성한다.
		"년월일_시분초999"와 같은 형태가 된다. */
		String now = new SimpleDateFormat("yyyyMMdd_HmsS")
				.format(new Date());
		//생성한 파일명과 확장자를 연결한다.
		String newFileName = now + ext;
		
		//원본파일명과 새로운파일명을 이용해 File인스턴스를 생성
		File oldFile = new File(sDirectory + File.separator + fileName);
		File newFile = new File(sDirectory + File.separator + newFileName);
		//파일명 변경
		oldFile.renameTo(newFile);
		
		//변경된 파일명 반환
		return newFileName;
	}
	
	
	//매개변수로 디렉토리경로, 원본파일명, 저장된파일명 3개가 전달됨
	public static void download(HttpServletRequest req, HttpServletResponse resp,
            String directory, String sfileName, String ofileName) {
        
		//디렉토리의 물리적 경로 얻어오기
		String sDirectory = req.getServletContext().getRealPath(directory);
        try {
            // 파일을 찾아 입력 스트림 생성
            File file = new File(sDirectory, sfileName);
            InputStream iStream = new FileInputStream(file);

            // 한글 파일명 깨짐 방지
            String client = req.getHeader("User-Agent");
            if (client.indexOf("WOW64") == -1) {
                ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
            }
            else {
                ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
            }

            // 파일 다운로드용 응답 헤더 설정
            resp.reset();
            resp.setContentType("application/octet-stream");
            /* 서버에 저장된 파일을 다운로드시 원본파일명으로 
            변경한다. 파일명이 한글인 경우 깨짐 현상
            
             */
            resp.setHeader("Content-Disposition",
                           "attachment; filename=\"" + ofileName + "\"");
            resp.setHeader("Content-Length", "" + file.length() );

            //out.clear();  // 출력 스트림 초기화

            // response 내장 객체로부터 새로운 출력 스트림 생성
            OutputStream oStream = resp.getOutputStream();

            // 출력 스트림에 파일 내용 출력
            byte b[] = new byte[(int)file.length()];
            int readBuffer = 0;
            while ( (readBuffer = iStream.read(b)) > 0 ) {
                oStream.write(b, 0, readBuffer);
            }

            // 입/출력 스트림 닫음
            iStream.close();
            oStream.close();
        }
        catch (FileNotFoundException e) {
            System.out.println("파일을 찾을 수 없습니다.");
            e.printStackTrace();
        }
        catch (Exception e) {
            System.out.println("예외가 발생하였습니다.");
            e.printStackTrace();
        }
    }

	
	//첨부파일 삭제
	public static void deleteFile(HttpServletRequest req,
			String directory, String filename) {
		//디렉토리의 물리적 경로
		String sDirectory = req.getServletContext()
				.getRealPath(directory);
		//파일의 경로를 통해서 File인스턴스 생성
		File file = new File(sDirectory + File.separator + 
				filename);
		//해당 위치에 파일이 존재하면 삭제한다.
		if (file.exists()) {
			file.delete();
		}
	}
	
	
}
