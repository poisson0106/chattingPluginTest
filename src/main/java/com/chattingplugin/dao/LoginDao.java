package com.chattingplugin.dao;

import com.chattingplugin.pojo.UserInfo;

public interface LoginDao {
	public UserInfo checkPasswordDao(String username);
}
