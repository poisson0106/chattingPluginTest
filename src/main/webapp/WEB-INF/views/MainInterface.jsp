<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chatting</title>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/bubble.css">
</head>
<body>
	<div class="container-fluid">
		<div class="row" style="margin-top: 2%">
			<div class="col-sm-3">
				<div class="col-sm-11 col-sm-offset-1">
					<div class="panel panel-success">
						<div class="panel-heading">
							<h1>${thisuser.username }</h1>
							<h3 class="panel-title">Online</h3>
						</div>
						<div class="panel-body" style="height:500px">
							<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
								<div class="panel panel-default">
									<div class="panel-heading" role="tab" id="headingOne">
										<h4 class="panel-title">
											<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne"> Friend List </a>
										</h4>
									</div>
									<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">

										<div class="list-group" style="margin-bottom:0px;">
											<c:forEach var="item" items="${friendlist}">
												<a href="#" class="list-group-item friendlist" value="${item }">${item }<span class="badge" style="display:none" id="${item }">0</span></a>
											</c:forEach>
										</div>

									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading" role="tab" id="headingTwo">
										<h4 class="panel-title">
											<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"> Collapsible Group Item #2 </a>
										</h4>
									</div>
									<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
										<div class="panel-body">Anim pariatur cliche
											reprehenderit, enim eiusmod high life accusamus terry
											richardson ad squid. 3 wolf moon officia aute, non cupidatat
											skateboard dolor brunch. Food truck quinoa nesciunt laborum
											eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on
											it squid single-origin coffee nulla assumenda shoreditch et.
											Nihil anim keffiyeh helvetica, craft beer labore wes anderson
											cred nesciunt sapiente ea proident. Ad vegan excepteur
											butcher vice lomo. Leggings occaecat craft beer
											farm-to-table, raw denim aesthetic synth nesciunt you
											probably haven't heard of them accusamus labore sustainable
											VHS.</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Message frame part -->
			<div class="col-sm-8">
				<div class="panel panel-success" style="display:none" id="msgwin">
  					<div class="panel-heading">
    					<h1 id="to"></h1>
    					<h5 id="status" style="display:none">User is on typing....</h5>
  					</div>
  					<div class="panel-body">
  						<div class="col-sm-12">
  							<div style="background:white;height:400px;border: 1px solid rgb(204, 204, 204);">
  								<div class="chatWrapper">
									<ul id="chat" style="list-style:none;" class="chatHistory">
										
									</ul>
								</div>
  							</div>
    					</div>
          				<div class="col-sm-9" style="margin-top:5px;">
    						<textarea class="form-control" id="msg" style="height:100px;"></textarea>
    					</div>
    					<div class="col-sm-3 text-center" style="margin-top:5px;">
    						<button type="button" class="btn btn-success btn-lg btn-block" style="height:100px" id="send">Send</button>
    					</div>
  					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var isStop = true;
var len = 0;
var inputListener;
var messageList;



$(function(){
	/* $('.textarea').wysihtml5({
	    toolbar: {
	      "icon": true,
	      "font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
	      "emphasis": false, //Italics, bold, etc. Default true
	      "lists": false, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
	      "html": false, //Button which allows you to edit the generated HTML. Default false
	      "link": false, //Button to insert a link. Default true
	      "image": false, //Button to insert an image. Default true,
	      "color": true, //Button to change color of font  
	      "blockquote": false, //Blockquote  
	      "size": "xs" //default: none, other options are xs, sm, lg
	    }
	  }); */
	
	$(".friendlist").click(function(){
		var msg;
		$(".chatHistory").html("");
		$("#msgwin").css("display","inherit");
		$("#to").html($(this).attr("value"));
		if($(this).children("span").css("display")=="block"){
			for(j=0;j<messageList.length;j++){
				if(messageList[j].key==$(this).attr("value")){
					msg = messageList[j].val;
					var msgAry = msg.split(",");
					for(k=0;k<msgAry.length;k++){
						var apdinfo="<li><div class='userSay'><div class='inlineText'>"+msgAry[k]+"</div></div></li>"
                    	$(".chatHistory").append(apdinfo);
					}
					messageList[j].val = "";
					$(this).children("span").css("display","none");
					$(this).children("span").html("0");
				}
			}
		}
	});
	  
	
});

//Socket Part
$(function(){
	var socket;
	
	//Store part of unread message sent when user is online
	messageList = new Array();
	
	function addToMsgList(nMsg,receiver){
		var flag = false;
		var i=0;
		for(i;i<messageList.length;i++){
			if(messageList[i].key==receiver){
				flag = true;
				break;
			}
		}
		if(flag)
			messageList[i].val = messageList[i].val + "," + nMsg;
		else{
			var tmp = {"key":receiver,"val":nMsg};
			messageList[messageList.length] = tmp;
		}
	}
	
	function connect() {
        if ('WebSocket' in window){
        	console.log('Websocket supported');
        	socket = new WebSocket('ws://localhost:8080/chattingplugin/websocket');
        	//socket = new WebSocket('ws://9.123.200.55:8080/chattingplugin/websocket');
        	console.log('Connection attempted');
        	socket.onopen = function(){
        		console.log('Connection open!');
            }
            socket.onclose = function(){
            	console.log('Disconnecting connection');
            }
            socket.onmessage = function (evt)
            {
            	Notification.requestPermission(function (status) {
            	    // This allows to use Notification.permission with Chrome/Safari
            	    if (Notification.permission !== status) {
            	      Notification.permission = status;
            	    }
            	});
            	var received_msg = evt.data;
            	var json_ary = JSON.parse(received_msg);
            	if (window.Notification && Notification.permission === "granted") {
            		//System Notification Part
            		if(json_ary.olnotify!=null){
            			var n = new Notification("System Notification",{"tag":"System Notification:","body":json_ary.olnotify});
              	      	setTimeout(function(){n.close();},2000);
              	      	return true;
            		}
            		else if(json_ary.status!=null){
            			//Typing Status description
            			if(json_ary.status=="OnTyping"){
            				$("#status").css("display","inherit");
            			}
            			else if(json_ary.status=="StopTyping"){
            				$("#status").css("display","none");
            			}
            			return true;
            		}
            		
            		
          	      	var n = new Notification("From: "+ json_ary.to,{"tag":"From: "+ json_ary.to,"body":json_ary.to+" send you a message"});
          	      	setTimeout(function(){n.close();},2000);
          		}
            	
            	//Judge if the dialog window is open and if current window is same as message from
            	if(json_ary.message!=null){
            		if($("#msgwin").css("display")=="none"){
                		$("#msgwin").css("display","inherit");
                		$("#to").html(json_ary.from);
                		var apdinfo="<li><div class='userSay'><div class='inlineText'>"+json_ary.message+"</div></div></li>"
                    	$(".chatHistory").append(apdinfo);
                	}
            		else if($("#msgwin").css("display")=="block"&&$("#to").html()!=json_ary.from){
            			addToMsgList(json_ary.message,json_ary.from);
            			var unreadnum=parseInt($("#"+json_ary.from).html())+1;
            			$("#"+json_ary.from).html(unreadnum);
            			$("#"+json_ary.from).css("display","inherit");
            		}
            		else{
            			var apdinfo="<li><div class='userSay'><div class='inlineText'>"+json_ary.message+"</div></div></li>"
                    	$(".chatHistory").append(apdinfo);	
            		}
            	}
            }
        }
        else {
        	console.log('Websocket not supported');
        }
    }
	
	function sendMessage(msg) {
        waitForSocketConnection(socket, function() {
        	socket.send(msg);
        });
    };


	function waitForSocketConnection(nsocket, callback){
        setTimeout(
            function(){
                if (nsocket.readyState === 1) {
                    if(callback !== undefined){
                        callback();
                    }
                    return;
                } else {
                    waitForSocketConnection(nsocket,callback);
                }
            }, 5);
    };
    
    //Establish connect
    connect();
    
	
	$("#send").click(function(){
		var sendDate = new Date();
		var message = $("#msg").val();
		var name = "${username}"
	    message = JSON.stringify({ 'message': message , 'to' : $("#to").html(), 'from' : name});
	    sendMessage(message);
	    var apdinfo="<li class='author'><div class='author userSay'><div class='inlineText'>"+$("#msg").val()+"</div></div></li>"
	    $(".chatHistory").append(apdinfo);
	    $("#msg").val("");
	});
	
	
	// on inputing part
	
	function isInputting(){
		var nowLen = $("#msg").val().length;
		if(nowLen!=len){
			if(isStop){
				//From stop to begin the typing, send a socket to show on typing
				var hbeat = JSON.stringify({'to' : $("#to").html(), 'status' : "OnTyping"});
				sendMessage(hbeat);
				len = nowLen;
				isStop = false;
			}
			else
				//Is still typing, needn't send any socket
				len = nowLen;
				return true;
		}
		else{
			//Stop typing, send a socket to show stop typing and let isStop is true
			if($("#status").css("display")=="none")
				return true;
			else{
				var hbeat = JSON.stringify({'to' : $("#to").html(), 'status' : "StopTyping"});
				sendMessage(hbeat);
				isStop = true;
			}
		}
	}
	
	$("#msg").focus(function(){
		inputListener = setInterval(isInputting,2000);
		//isInputting();
	});
	
	$("#msg").blur(function(){
		inputListener = clearInterval(inputListener);
	});
	
});
</script>
</html>