
/*  src Setup
 
    Contains the setup and draw function of this pde file.
    Add in new functions or comment out existing ones to
    handle which functions are executed by the program.
    
    Set values of global variable depending on desired
    installation setting and depending on environment.
 
 */


float wristMov = 250;            // Control max. distance of wrist to elbow in px (depends on distance)
float shoulderMov = 250;         // Control max. distance of elbow to shoulder in px (depends on distance)


void setup() {

  // External connections
  initRunway();                  // Connect to Ruway ML
  initOSC();                     // OSC for Wekinator communication

  // Initiate GUI
  colorMode(HSB, 255);           // Set color mode to HSB on 255 scale
  settings();                    // Load screen settings from GUI
  setupGUI();                    // Initiate GUI

  // Initialise user controls
  setupVisualControls();
  setupAudioControls();
  
};


void draw() {

  background(bg);                 // Clear last screen

  drawPoseNetParts(data);         // Update user sceletons

  if (checkForUsers()) {          // If users are found

    updateVisuals();              // Update user controls
    updateAudio();                // Update user controls
    updateCounters();             // Update event counter
    postRunwayOSC();
    
  }
  
};


void keyPressed() { 

  if (key == 'k') {
  
    kiss();
    if (updateCounter) {
      count[0] +=1;
      updateCounter = !updateCounter;
    }
    
  } else if (key == 'h') {
  
    hug();
    if (updateCounter) {
      count[1] +=1;
      updateCounter = !updateCounter;
    }
    
  } else if (key == 'f') {
  
    highFive();
    if (updateCounter) {
      count[2] +=1;
      updateCounter = !updateCounter;
    }
    
  }
  
}
