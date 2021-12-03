
/* GUI Setup

    Contains functions required to construct the GUI.
    Control the screen mode, handling of missing users
    and event counters here.

*/


color bg;                          // set color for background
boolean fullScreen = true;         // set to true for full screen mode, false for 600/600
int[] count = new int[3];          // set counters for main events
boolean updateCounter = true;      // reuquire counter update on first event


// Initial association of Visual/Audio controls to Users index
int v = 0;
int a = 1;
boolean userSwap = false;


// Image imports for event counters
PImage highfiveImg;
PImage hugImg;
PImage kissImg;
PImage swapImg;


public void settings() {
  
  if (fullScreen) {
    fullScreen(P3D);
  } else {
    size(600, 600, P3D);
  };
  smooth(4);
  bg = color(0,0,0);
    
};


void setupGUI() {

  // Draw initial background
  background(bg);
  
  // Load images for counter/events
  highfiveImg = loadImage("highFive.png");
  hugImg = loadImage("hug.png");
  kissImg = loadImage("kiss.png");
  swapImg = loadImage("swop.png");
  
  // Set counters to 0
  for (int i=0; i < 3; i++) {
    count[i] = 0;
  }
  
};


// Handle user availability
public boolean checkForUsers() {
  
  fill(#FFFFFF);
  textSize(90);
  textAlign(CENTER);
  
  if (Users[0] == null && Users[1] == null) {

    text("Ready to play?", width/2, height/2, 7);
    return false;
    
  } else if (Users[0] == null || Users[1] == null) {
    
    text("Looking for Player 2...", width/2, height/2, 7);
    return false;
    
  } else {
    
    if (userSwap) {
      v = 1;
      a = 0;
    } else {
      v = 0;
      a = 1;
    }
    
    return true;
    
  }
  
}; 


void updateCounters() {

  float boxh = 80;            // Set height of counter box
  float boxw = 125;           // Set width of counter box
  float br = 8;               // Set border radius of counter box
  
  for (int i = 0; i < count.length; i++) {
  
    // Draw rectangle background
    fill(0,0,150, 100);
    noStroke();
    rect(width-boxw+br, height/2-boxh/2+boxh-(boxh+10)*i, boxw, boxh, br);
    
    // Draw count
    fill(0,0,255);
    textSize(40);
    textAlign(RIGHT);
    text(str(count[i]), width-br*3,(height/2+12)+boxh-(boxh+10)*i, 6);
    
    // Draw icon
    if (i==2) {
      image(highfiveImg, width-boxw+br+10,(height/2-12)+boxh-(boxh+10)*i, 30, 30);
    } else if (i==1) {
      image(hugImg, width-boxw+br+10,(height/2-12)+boxh-(boxh+10)*i, 30, 30);
    } else if (i==0) {
      image(kissImg, width-boxw+br+10,(height/2-12)+boxh-(boxh+10)*i, 30, 30);
    }
  }

};


void highFive() {
   
  // trigger Fireworks
  fireworks.add(new Firework(width/2, height/3));
    
};


void hug() {

  // trigger hug overlay
  fill(0, 0, 255);
  noStroke();
  rect(0, 0, width, height);
  image(swapImg, width/2-(width/5)/2,height/2-(width/5)/2, width/5, width/5);
  
  // swap users
  userSwap = !userSwap;
  
};


void kiss() {

  // trigger kiss overlay
  fill(0, 255, 255);
  noStroke();
  rect(0, 0, width, height);
  image(kissImg, width/2-(width/4)/2,height/2-(height/4)/2, width/4, height/4);
  
};
