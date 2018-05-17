import java.util.*;

class Link {
  private int bandSpeed, lineLength;
  private Node node1, node2;
  private List<Packet> packets;

  Link(Node node1, Node node2) {
    packets = new LinkedList<Packet>();
    this.node1 = node1;
    this.node2 = node2;
    this.bandSpeed = 100; // Mbps
    this.lineLength = node1.distance(node2);
  }
  
  public void send(Packet p) {
    packets.add(p);
  }
  
  public void draw() {
    stroke(255, 32);
    strokeWeight(1);

    line(node1.pos.x, node1.pos.y, node1.pos.z
       , node2.pos.x, node2.pos.y, node2.pos.z);
    
    strokeWeight(5);
    stroke(255, 0, 0);
    
    long now = System.currentTimeMillis();
    for (Packet p: packets) {
      long delta = (long)(now - p.getSentAt());
      float percentage = (float)(delta / lineLength);

      float x = linearInterpolate(node1.pos.x, node2.pos.x, percentage);
      float y = linearInterpolate(node1.pos.y, node2.pos.y, percentage);
      float z = linearInterpolate(node1.pos.z, node2.pos.z, percentage);

      point(x, y, z - 1);

      System.out.println(
        percentage + "% "
        + x + ", " + y + ", " + z
      );
      
      if (100 < percentage) {
        packets.remove(p);
        this.node2.recieve(this, p);
      }
    }
  }
  
  public Node otherSide(Node n) {
    if (node1 == n) {
      return node2;
    } else if (node2 == n) {
      return node1;
    } else {
      return null;
    }
  }
  
  protected float linearInterpolate(float x0, float x1, float p) {
    return min(x0, x1) + (p / 100.0) * (max(x0, x1) - min(x0, x1));
  }
}