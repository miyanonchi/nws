import java.util.*;

static int NUMS = 30, r = 500;
Node[] nodes;
Random rand;

void setup() {
  //fullScreen(P3D, 2); // SPAN: all screen
  size(1200, 1200, P3D);
  pixelDensity(displayDensity());
  frameRate(30);
  blendMode(ADD);
  imageMode(CENTER);

  //camera(width/5.0, height/3.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  camera(0, 0, (height/2.0) / tan(PI*30.0 / 180.0), 0, 0, 0, 0, 1, 0);

  rand = new Random();

  nodes = new Node[NUMS];
  float delta = TWO_PI / NUMS;
  for (int i = 0; i < NUMS; ++i) {
    float x = r * cos(i * delta);
    float y = r * sin(i * delta);
    float z = 0;
    nodes[i] = new Node("Node" + i, new Position(x, y, z));
  }
  
  for (int i = 0; i < NUMS * 10; ++i) {
    int j = rand.nextInt(NUMS);
    int k = rand.nextInt(NUMS);
    if (j != k) nodes[j].connect(nodes[k]);
  }
  
  translate(width / 2, height / 2, 0);
}

void draw() {
  //pushMatrix();
  background(0, 64);
  //translate(width / 2, height / 2, 0);

  for (int i = 0; i < NUMS; ++i) {
    nodes[i].draw();
  }

  //popMatrix();
}

void mouseClicked() {
  String msg = mouseX + ", " + mouseY;
  
  System.out.println("\nI sent: " + msg);
  
  Packet p = new Packet(msg);
  int i = rand.nextInt(nodes.length - 1);
  Node from = nodes[i];
  Node to   = nodes[i + 1];
  
  p.setFrom(from);
  p.setTo(to);
  
  from.send(p);
}