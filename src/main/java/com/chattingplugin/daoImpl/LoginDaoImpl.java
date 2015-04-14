package com.chattingplugin.daoImpl;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.chattingplugin.dao.LoginDao;
import com.chattingplugin.pojo.UserInfo;

public class LoginDaoImpl extends SqlSessionDaoSupport implements LoginDao {

	@Override
	public UserInfo checkPasswordDao(String username) {
		return this.getSqlSession().selectOne("getUserInfo",username);
	}

}
