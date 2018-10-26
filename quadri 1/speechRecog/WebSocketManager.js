/*----------------------------------------*\
  form - webSocket.js
  @author Evrard Vincent (vincent@ogre.be)
  @Date:   2018-10-24 10:02:32
  @Last Modified time: 2018-10-24 10:53:03
\*----------------------------------------*/
class WebSocketManager{
	constructor(_address = "p5websocket", _port = 1337){
		if (!("WebSocket" in window)){
			alert("WebSocket NOT supported by your Browser!");
		}
		this.address = _address;
		this.port = _port;
		this.reconnector = undefined;
		this.isConnected = false;
		this.connect();
		this.toSendAccumulator = "";
	}
	connect(){
		console.log("try to connect...");
		this.ws = new WebSocket("ws://localhost:"+this.port+"/"+this.address);
		this.ws.onclose = event => this.closeHandler(event);
		this.ws.onopen = event => this.openHandler(event);
		this.ws.onmessage = event => console.log(event);
	}
	closeHandler(){
		this.reconnector = setTimeout(()=>this.connect(), 1000)
		this.isConnected = false;
	}
	openHandler(){
		console.log("WebSocket opened");
		this.isConnected = true;
		clearTimeout(this.reconnector);
		this.reconnector = undefined;
		this.send("");
	}
	send(data){
		this.toSendAccumulator += ""+data;
		if(this.isConnected){
			console.log(this.toSendAccumulator);
			this.ws.send(this.toSendAccumulator);
			this.toSendAccumulator = "";
		}
	}
}