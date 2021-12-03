
/*  Fireworks based on
 
    Daniel Shiffman
    http://codingtra.in
    http://patreon.com/codingtrain
 
 */


ArrayList<Firework> fireworks;
PVector gravity = new PVector(0, 0.2);


void firework() {
  
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
  
}


class Rocket {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  boolean seed = false;

  float hu;

  Rocket(float x, float y, float h) {
    hu = h;

    acceleration = new PVector(0, 0);
    velocity = new PVector(0, random(-12, -5));
    location =  new PVector(x, y);
    seed = true;
    lifespan = 255.0;
  }

  Rocket(PVector l, float h) {
    hu = h;
    acceleration = new PVector(0, 0);
    velocity = PVector.random2D();
    velocity.mult(random(4, 8));
    location = l.copy();
    lifespan = 255.0;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void run() {
    update();
    display();
  }

  boolean explode() {

      return true;
  }

  // Method to update location
  void update() {

    velocity.add(acceleration);
    location.add(velocity);
    if (!seed) {
      lifespan -= 5.0;
      velocity.mult(0.95);
    }
    acceleration.mult(0);
  }

  // Method to display
  void display() {
    stroke(hu, 255, 255, lifespan);
    if (seed) {
      strokeWeight(4);
    } else {
      strokeWeight(2);
    }
    point(location.x, location.y);
    //ellipse(location.x, location.y, 12, 12);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}


class Firework {

  ArrayList<Rocket> rockets;    // An arraylist for all the particles
  Rocket firework;
  float hu;

  Firework(float x, float y) {
    hu = random(255);
    firework = new Rocket(x, y, hu);
    rockets = new ArrayList<Rocket>();   // Initialize the arraylist
  }
  
  boolean done() {
    if (firework == null && rockets.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  void run() {
    if (firework != null) {
      fill(hu,255,255);
      firework.applyForce(gravity);
      firework.update();
      firework.display();

      if (firework.explode()) {
        for (int i = 0; i < 100; i++) {
          rockets.add(new Rocket(firework.location, hu));    // Add "num" amount of particles to the arraylist
        }
        firework = null;
      }
    }

    for (int i = rockets.size()-1; i >= 0; i--) {
      Rocket r = rockets.get(i);
      r.applyForce(gravity);
      r.run();
      if (r.isDead()) {
        rockets.remove(i);
      }
    }
  }


  // A method to test if the particle system still has particles
  boolean dead() {
    if (rockets.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }
}
