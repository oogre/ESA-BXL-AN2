/*----------------------------------------*\
  form - speechRecognition.js
  @author Evrard Vincent (vincent@ogre.be)
  @Date:   2018-10-24 10:02:48
  @Last Modified time: 2018-10-24 13:19:13
\*----------------------------------------*/
class SpeechRecognition{
	constructor(){
		this.recognition = new webkitSpeechRecognition();
		this.recognition.continuous = true;
		this.recognition.interimResults = true;
		this.recognition.lang = "fr-BE";
		this.recognition.onresult = event => this.resultHandler(event.results[event.results.length-1][0].transcript);
		this.recognition.start();
		this.recognition.onend = event => {
			this.recognition.start();
		};
		this.onResultActions = [];
	}
	resultHandler(transcript){
		for(let action of this.onResultActions){
			action(transcript)
		}
	}
	onResultHandler(fnc){
		if(typeof fnc != "function")throw new Error("onResultHandler take a function as first parameter");
		this.onResultActions.push(fnc);
	}
}
