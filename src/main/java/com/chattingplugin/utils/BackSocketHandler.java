package com.chattingplugin.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.chattingplugin.pojo.UserInfo;
import com.fasterxml.jackson.databind.ObjectMapper;

public class BackSocketHandler extends TextWebSocketHandler {
	public static Map<String,WebSocketSession> sessionList = new HashMap<String,WebSocketSession>();
	public static Map<String,List<String>> toSendMessageList = new HashMap<String,List<String>>();
	
	private ObjectMapper objectMapper;
	
	public ObjectMapper getObjectMapper() {
		return objectMapper;
	}

	public void setObjectMapper(ObjectMapper objectMapper) {
		this.objectMapper = objectMapper;
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
		System.out.println(session.getAttributes().get("username")+" is on");
		sessionList.put(session.getAttributes().get("username").toString(), session);
		UserInfo user = (UserInfo) session.getAttributes().get("thisuser");
		String[] friendList = user.getMyfriendlist().split(",");
		for(String tmp : friendList){
			WebSocketSession usersession = sessionList.get(tmp);
			if(usersession!=null && usersession.isOpen()){
				usersession.sendMessage(new TextMessage("{\"olnotify\" : \""+user.getUsername()+" is online\"}"));
			}
		}
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession session,
			TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
		System.out.println("begin send msg");
		Map<String,String> tmpMap = objectMapper.readValue(message.getPayload(), Map.class);
		WebSocketSession usersession = sessionList.get(tmpMap.get("to"));
		if(usersession!=null && usersession.isOpen()){
			usersession.sendMessage(message);
		}
		else{
			if(toSendMessageList.containsKey(tmpMap.get("to")))
				toSendMessageList.get(tmpMap.get("to")).add(","+tmpMap.get("from")+":"+tmpMap.get("message"));
			else{
				// To finish a function to let user who is offline can get information when user is online
				List<String> tmpStr = new ArrayList<String>();
				tmpStr.add(tmpMap.get("from")+":"+tmpMap.get("message"));
				toSendMessageList.put(tmpMap.get("to"), tmpStr);
			}
		}
	}

	@Override
	public void handleTransportError(WebSocketSession session,
			Throwable exception) throws Exception {
		// TODO Auto-generated method stub
		super.handleTransportError(session, exception);
		if (session.isOpen()){
			sessionList.remove(session.getAttributes().get("username").toString());
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session,
			CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		System.out.println(session.getAttributes().get("username")+" is down");
		if (session.isOpen()){
			sessionList.remove(session.getAttributes().get("username").toString());
		}
		UserInfo user = (UserInfo) session.getAttributes().get("thisuser");
		String[] friendList = user.getMyfriendlist().split(",");
		for(String tmp : friendList){
			WebSocketSession usersession = sessionList.get(tmp);
			if(usersession!=null && usersession.isOpen()){
				usersession.sendMessage(new TextMessage("{\"olnotify\" : \""+user.getUsername()+" is offline\"}"));
			}
		}
	}

}
