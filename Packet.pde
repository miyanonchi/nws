import java.nio.charset.StandardCharsets;

class Packet {
  private long sentAt;
  private byte[] data;
  private int ttl;
  private Node from, to;

  Packet(String data) {
    this.data = data.getBytes(StandardCharsets.UTF_8);
    this.ttl = 64;
    this.sentAt = System.currentTimeMillis();
  }
  
  public long getSentAt() {
    return this.sentAt;
  }

  public Node getFrom() {
    return this.from;
  }

  public void setFrom(Node n) {
    this.from = n;
  }

  public Node getTo() {
    return this.to;
  }
  
  public void setTo(Node n) {
    this.to = n;
  }

  public int getTtl(){
    return this.ttl;
  }

  public int decTtl() {
    return --this.ttl;
  }
  
  public String getData() {
    return new String(this.data);
  }
}