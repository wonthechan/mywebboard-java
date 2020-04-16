package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ResponseHTMLServlet")
public class ResponseHTMLServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
        PrintWriter writer = response.getWriter();
        writer.append("<html>");
        writer.append("<body>");
        writer.append("<h1>주요 검색 Site!</h1>");
        writer.append("<hr>");
        writer.append("<a href='http://google.com'>구글</a><br>");
        writer.append("<a href='http://daum.net'>찌게를</a><br>");
        writer.append("<a href='http://naver.com'>밥도</a>");
        writer.append("</body>");
        writer.append("</html>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
