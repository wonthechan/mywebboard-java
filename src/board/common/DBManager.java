package board.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBManager {
	public static Connection getConnection() {
		Connection con = null;
		try { // 더이상 드라이버를 직접 로드시키지 않음. 톰캣이 관리하는 자원을 lookup()을 통해 땡겨올뿐.
			Context context = (Context) new InitialContext().lookup("java:comp/env/"); // 컨테이너(톰캣)의 context.xml을 찾는다.
			DataSource datasource = (DataSource) context.lookup("jdbc/mysql"); // DataSource가 커넥션풀
			con = datasource.getConnection(); // 자원 요청하여 커넥션풀에서 커넥션 가져오는 과정
		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;
	}

	public static void releaseConnection(ResultSet rs, PreparedStatement pstmt, Connection con) {

		try {
			if (rs != null) {
				rs.close();			// 커넥션풀에서 땡겨온 자원을 close하는 경우 (JDBC에서 하던 close와 다르다. 반납하는 개념)
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
