package com.chattingplugin.service;

import com.chattingplugin.pojo.UserInfo;

public interface LoginService {
	public UserInfo checkPasswordService(String username);
}
