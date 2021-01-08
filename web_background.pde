ArrayList<Bob> bobs = new ArrayList<Bob>();
int bobCount = 100;
float distThreshold = 200;


class Bob {
  
  PVector pos;
  PVector dir;
  float speed;
  
  Bob(float _x, float _y, float _angle, float _speed) {
    this.pos = new PVector(_x, _y);
    
    this.dir = new PVector(sin(radians(_angle)), cos(radians(_angle)));
    this.dir.normalize();
    
    this.speed = _speed;
  }
  
  void move() {
    this.pos.x += this.dir.x*this.speed;
    this.pos.y += this.dir.y*this.speed;
  }
  
  void keepInBounds() {
    if (this.pos.x < 0) {
      this.pos.x = 0;
      this.dir.x *= -1;
    } else if (this.pos.x > width) {
      this.pos.x = width;
      this.dir.x *= -1;
    }
    
    if (this.pos.y < 0) {
      this.pos.y = 0;
      this.dir.y *= -1;
    } else if (this.pos.y > height) {
      this.pos.y = height;
      this.dir.y *= -1;
    }
  }
  
  void drawPoint() {
    noStroke();
    fill(15, 126, 124);
    ellipse(this.pos.x, this.pos.y, 10, 10);
  }
  
  void drawFill() {
    ArrayList<Bob> proximityBobs = new ArrayList<Bob>();
    
    for (Bob otherBob : bobs) {
      if (this == otherBob) {
        continue;
      }
      
      float distance = dist(this.pos.x, this.pos.y, otherBob.pos.x, otherBob.pos.y);
      if (distance < distThreshold) {
        proximityBobs.add(otherBob);
      }
    }
    
    if (proximityBobs.size() > 2 && proximityBobs.size() < 8) {
      stroke(170);
      for (Bob otherBob : proximityBobs){
        line(this.pos.x, this.pos.y, otherBob.pos.x, otherBob.pos.y);
      }
    }
  }
}
    
void setup() {
  fullScreen();
  background(15);
  
  for (int i = 0; i < bobCount; i++) {
    bobs.add(new Bob(random(0.0, width), 
                     random(0.0, height), 
                     random(0.0, 360.0), 
                     random(0.5, 2.0)));
  }
}


void draw() {
  background(15);
  
  for (Bob bob : bobs) {
    bob.move();
    bob.keepInBounds();
    bob.drawFill();

    bob.drawPoint();
  }
}

void keyPressed(){
   save(minute() + second() + "bg.png"); 
}
