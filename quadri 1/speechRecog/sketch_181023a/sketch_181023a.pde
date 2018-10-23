import websockets.*;

WebsocketServer socket;
ArrayList<Text> alltxt;
ArrayList<Text> tmptxt;
void setup() {
  size(1400, 600);
  alltxt = new ArrayList<Text>();
  tmptxt = new ArrayList<Text>();
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  
}
void mouseReleased(){
tmptxt.add(new Text("test", mouseX, mouseY));
}
void draw() {
  background(0);
  for (Text t : alltxt) {
    t.draw();
  }
  for (Text t : tmptxt) {
    alltxt.add(t);
  }
  for (int i = alltxt.size()-1 ; i>=0 ; i --) {
    if (alltxt.get(i).hasToKill()) {
      alltxt.remove(alltxt.get(i));
    }
  }
  tmptxt.clear();
}

void webSocketServerEvent(String msg) {
  println(msg);
  tmptxt.add(new Text(msg));
}

class Text {
  PVector pos;
  float size;
  float c = 255;
  String txt;

  Text(String txt) {
    this(txt, random(width), random(height) );
  }
  Text(String txt, float x, float y) {
    this.txt = txt;
    pos = new PVector(x, y);
    size = random(10, 40);
  }
  boolean hasToKill() {
    return c <= 0;
  }
  void draw() {
    textAlign(CENTER, CENTER);
    textSize(size);
    fill(255, c);
    text(txt, pos.x, pos.y);
    pos.add(0, 1);
    size *= 1.01;
    c -= 2;
  }
}