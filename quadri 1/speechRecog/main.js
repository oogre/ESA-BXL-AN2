/*----------------------------------------*\
  form - main.js
  @author Evrard Vincent (vincent@ogre.be)
  @Date:   2018-10-24 10:02:58
  @Last Modified time: 2018-10-26 15:58:11
\*----------------------------------------*/
setInterval(function(){
    window.location.reload()
}, 15000);

//let wsMan = new WebSocketManager();
let sr = new SpeechRecognition();

sr.onResultHandler(function(data){
	console.log(data);
});