package com.chattingplugin.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.chattingplugin.pojo.UserInfo;
import com.chattingplugin.service.LoginService;

@Controller
public class LoginController {
	@Autowired
	LoginService loginService;
	
	@Autowired
	ModelAndView mv;
	
	@RequestMapping(value="loginOneUser", method=RequestMethod.POST)
	public ModelAndView loginOneUser(HttpServletRequest request) throws Exception{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserInfo thisuser = loginService.checkPasswordService(username);
		if(password.equals(thisuser.getPassword())){
			request.getSession().setAttribute("thisuser", thisuser);
			request.getSession().setAttribute("username", username);
		}
		mv.addObject("friendlist", thisuser.getMyfriendlist().split(","));
		mv.setViewName("MainInterface");
		return mv;
	}
}
