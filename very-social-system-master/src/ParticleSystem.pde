class ParticleSystem {

  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector position) {
  
    origin = position.get();
    particles = new ArrayList<Particle>();
     
  }
  
  void addParticle(float x, float y, float z, color c) {
    particles.add(new Particle(new PVector(x, y, z), c));
  }
  
  void run() {
  
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
    
  }
};
