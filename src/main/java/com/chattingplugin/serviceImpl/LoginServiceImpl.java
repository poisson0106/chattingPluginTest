package com.chattingplugin.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chattingplugin.dao.LoginDao;
import com.chattingplugin.pojo.UserInfo;
import com.chattingplugin.service.LoginService;

@Service
public class LoginServiceImpl implements LoginService {
	@Autowired
	LoginDao loginDao;
	
	@Override
	public UserInfo checkPasswordService(String username) {
		return loginDao.checkPasswordDao(username);
	}

}
