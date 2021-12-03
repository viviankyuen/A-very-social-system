
/*  Particle Class
 
    Contains the props for a single particle.
    
    Change values to alternate natural movement
    of the individual particles.
 
 */


class Particle {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color c;
  
  Particle(PVector l, color d) {
    
    acceleration = new PVector(0, 0, -0.1);
    velocity = new PVector(0, 0.1, -0.1);
    position = l.get();
    lifespan = 255.0;
    c = d;
    
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 3.0;
  }
  
  void display() {
  
    strokeWeight(dotSize+((1-(lifespan/255))*5));
    stroke(c, lifespan);
    point(position.x, position.y, position.z);
    
  }
  
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  } 

};
