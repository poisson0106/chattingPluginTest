package com.chattingplugin.pojo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PersonalOfflineMsg {
	public PersonalOfflineMsg(){
		owner = null;
		toSendMsg = new HashMap<String,List<String>>();
	}
	
	private String owner;
	private Map<String,List<String>> toSendMsg;
	
	
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public Map<String, List<String>> getToSendMsg() {
		return toSendMsg;
	}
	public void setToSendMsg(Map<String, List<String>> toSendMsg) {
		this.toSendMsg = toSendMsg;
	}
	
}
