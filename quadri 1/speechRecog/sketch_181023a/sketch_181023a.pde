import websockets.*;
WebsocketServer socket;

ArrayList<Text> txtList;
ArrayList<Text> txtTmpList;

void setup() {
  size(800, 600);
  txtList = new ArrayList<Text>();
  txtTmpList = new ArrayList<Text>();
  socket = new WebsocketServer(this, 1337, "/p5websocket");
}
void draw() {
  background(0);
  for (Text t : txtList) {
    t.draw();
  }
  for (Text t : txtTmpList) {
    txtList.add(t);
  }
  for (int i = txtList.size()-1; i>=0; i --) {
    if (txtList.get(i).hasToKill()) {
      txtList.remove(txtList.get(i));
    }
  }
  txtTmpList.clear();
}

void webSocketServerEvent(String msg) {
  txtTmpList.add(new Text(msg));
  println(msg);
}

void mouseReleased() {
  txtTmpList.add(new Text("test", mouseX, mouseY));
}

class Text {
  float size;
  String txt;
  PVector position;
  PVector speed;
  float opacity = 255;
  
  Text(String txt) {
    this(txt, random(width), random(height) );
  }
  
  Text(String txt, float x, float y) {
    this.txt = txt;
    position = new PVector(x, y);
    speed = new PVector(random(-1, 1), random(-1, 1));
    size = random(10, 30);
  }
  
  boolean hasToKill() {
    return opacity <= 0;
  }
  
  void draw() {
    textAlign(CENTER, CENTER);
    textSize(size);
    fill(255, opacity);
    text(txt, position.x, position.y);
    position.add(speed);
    size *= 1.01;
    opacity -= 2;
  }
}