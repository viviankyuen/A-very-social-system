
/*  Controls for Visuals User[v]
 
    Contains the main controls for User[v] in charge of
    steering the visual experience.
    
    Set values of particle grid and particles here to 
    compensate screen size.
 
 */


// Set up new ParticleSystem and origin tracking
ParticleSystem ps;
float[][] grid;
ArrayList originHistory;


// Defines values of grid
int cols, rows;
int scl = 50;
int w = 250;
int h = 250;
int noiseLimit = 50;
float wave;


// Initial props of particles
float xPos = width/2;
float yPos = height/2;
color c;
int dotSize = 30;


void setupVisualControls() {

  // Create gutter for particle layout
  cols = floor(w / scl);
  rows = floor(h/ scl);
  grid = new float[cols][rows];
  ps = new ParticleSystem(new PVector(width/2,height/2));
  
  // Setup list to store origin history of the particle system
  originHistory = new ArrayList();
  
  // Create a fireworks instance to be ready for highFive events
  fireworks = new ArrayList();
  
}


void updateVisuals() {
  
  // Check for new positions of User[v]
  if (Users[v] != null) {
    
    // Set x/y coordinates depending on wrist positions 
    xPos = map(Users[v].rightWrist(), -wristMov, wristMov, 0, width);
    yPos = map(Users[v].leftWrist(), -wristMov, wristMov, 0, height);
    
    // Set Hue depending on left elbow position
    // Set Saturation depending on user distance
    c = color(map(Users[v].leftElbow(), shoulderMov, -shoulderMov, 100, 255), map(userDistance(), 0, width-width/5, 255, 0 ), 255);
    
    // Set size of particles depending on right elbow position
    dotSize = floor(map(Users[v].rightElbow(), shoulderMov, - shoulderMov, 10, 30));
    
  }
  
  
  // Simulate constant wave movement
  float sinX = sin(radians(frameCount*3))*5;
  float sinY = sin(radians(frameCount*2))*5;
  
  
  // Handle origin list and find mean of origin list
  originHistory.add(new PVector(xPos, yPos));
  if (originHistory.size() > 20) {
    originHistory.remove(0);
  }
  PVector smoothPos = new PVector(0,0,0);
  for (int i = 0; i < originHistory.size(); i++) {
    smoothPos.add((PVector)(originHistory.get(i)));
  }
  smoothPos = smoothPos.div(originHistory.size());
  
  
  // Emmit new particles within grid at smoothed origin
  wave += 0.02;
  float xoff = wave;
  for (int y = 0; y < rows-1; y++) {
    float yoff = wave;
    for (int x = 0; x < cols; x++) {
      grid[x][y] = map(noise(xoff, yoff), 0, 1, -noiseLimit, noiseLimit);
      float morph = map(noise(xoff, yoff), 0, 1, -noiseLimit*3, noiseLimit*3);
      float newX = x * scl + sinX + morph + smoothPos.x;
      float newY = y * scl + sinY + morph + smoothPos.y;
      ps.addParticle( newX, newY, grid[x][y], c);
      yoff += .2;
    }
    xoff += .2;
  }
  
  ps.run();                // Update the ParticleSystem
  
  firework();              // Update fireworks if available
  
}
