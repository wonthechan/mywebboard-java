package board;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 * Servlet implementation class ServletLifeCycle
 */
@WebServlet("/ServletLifeCycle")
public class ServletLifeCycle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletLifeCycle() {
		System.out.println("ServletLifeCycle() call!!!");
	}

	@Override
	public void destroy() {
		System.out.println("destroy() call!!!");
	}

	@Override
	public ServletConfig getServletConfig() {
		System.out.println("getServletConfig() call!!!");
		return null;
	}

	@Override
	public String getServletInfo() {
		System.out.println("getServletConfig call!!!");
		return null;
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		System.out.println("init(ServletConfig config) call!!!");
	}

	@Override
	public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
		System.out.println("service(ServletRequest req, ServletResponse res) call!!!");
		res.getWriter().print("Console View!!!!");
	}

}
