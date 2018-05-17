import java.util.*;

class Node {
  private Random rand;
  private String name;
  private Position pos;
  private List<Link> links;

  Node(String name, Position p) {
    this.rand = new Random();
    this.name = name;
    this.links = new LinkedList<Link>();
    this.pos = p;
  }

  public int distance(Node n) {
    return (int)Math.sqrt(
        (this.pos.x - n.pos.x) * (this.pos.x - n.pos.x)
      + (this.pos.y - n.pos.y) * (this.pos.y - n.pos.y)
      + (this.pos.z - n.pos.z) * (this.pos.z - n.pos.z)
    );
  }

  public void connect(Node n) {
    Link link = new Link(this, n);

    this.links.add(link);
    //n.links.add(link);
  }

  public void recieve(Link from, Packet p) {
    if (links.size() == 0 || p.decTtl() == 0) {
      System.out.println("Packet destroyed.");
      p = null;
      return;
    }

    if (p.getTo() == this) {
      System.out.println("I recieved: " + p.getData());
      p = null;
      return;
    }

    System.out.println("packet passed from "
      + from.otherSide(this).getName()
      + " to "
      + this.getName()
      + ", ttl: " + p.getTtl()
      );

    links.get(rand.nextInt(links.size())).send(p);
  }

  public String getName() {
    return this.name;
  }

  public void send(Packet p) {
    if (links.size() == 0) {
      System.out.println("Packet destroyed.");
      p = null;
      return;
    }

    links.get(rand.nextInt(links.size())).send(p);
  }

  public void draw() {
    stroke(255, 128);
    strokeWeight(10);

    point(pos.x, pos.y, pos.z);

    for (Link l : links) {
      l.draw();
    }
  }
}