package board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.dto.UserDto;
import board.service.LoginService;
import board.service.LoginServiceImpl;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	LoginService service = new LoginServiceImpl();

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userEmail = request.getParameter("userEmail");
		String userPassword = request.getParameter("userPassword");

		UserDto userDto = service.login(userEmail, userPassword);
		if (userDto != null) { // 로그인 성공한 경우
			HttpSession session = request.getSession();	// 현재 세션을 가져와서
			session.setAttribute("userDto", userDto);	// 사용자 정보를 기억하기 위한 세션 set
			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/board/board.jsp");
			dispatcher.forward(request, response);			// sendRedirect()와 마찬가지로 분기하는 역할 (그렇지만 클라이언트로 응답이 가지 않고 서버내에서 리다이렉트)
		} else { // 로그인 인증에 실패한 경우 (존재하지 않는 ID이거나 PW가 맞지 않는 경우)
			response.sendRedirect("/html/loginFail.html"); // 새로운 주소로 분기. (클라이언트로 응답이 가고 브라우저가 리다이렉트)
		}
	}
}
