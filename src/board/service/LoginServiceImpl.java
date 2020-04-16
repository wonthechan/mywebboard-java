package board.service;

import board.dao.LoginDao;
import board.dao.LoginDaoImpl;
import board.dto.UserDto;

public class LoginServiceImpl implements LoginService {

	LoginDao loginDao = new LoginDaoImpl();
	
	@Override
	public UserDto login(String userEmail, String userPassword) {
		UserDto userDto = loginDao.login(userEmail); // 패스워드도 쿼리로 날려서 인증 확인할 수도 있음
		if (userDto != null && userDto.getUserPassword().equals(userPassword)) {
			return userDto;
		} else {
			return null;
		}
	}
}
