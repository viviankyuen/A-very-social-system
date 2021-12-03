
/* OSC Setup
 
    Contains functions to handle OSC communication.
    Mainly used for Wekinator. Initially set up to 
    handle communication between two computers.
 
 */


import oscP5.*;
import netP5.*;


// Initiate new OSC connection 
OscP5 oscP5;
NetAddress remoteLocation;


// Declare ports for listening and sending
int oscListen = 9876;
int oscSend = 9877;



void initOSC() {
  
  oscP5 = new OscP5(this, oscListen);
  remoteLocation = new NetAddress("169.254.103.87", oscSend);
  
};


void oscEvent(OscMessage inbound) {

  float m = inbound.get(0).floatValue();

  print(m);

  if ( m == 2.0) { 
    highFive();
    if (updateCounter) {
      count[2] +=1;
      updateCounter = !updateCounter;
    }
  } else if ( m == 3.0) {
    hug();
    if (updateCounter) {
      count[1] +=1;
      updateCounter = !updateCounter;
    }
  } else if ( m == 4.0) {
    kiss();
    if (updateCounter) {
      count[0] +=1;
      updateCounter = !updateCounter;
    }
  } else {
    updateCounter = true;
  }
  
};

void postRunwayOSC() {
  
  OscMessage msg = new OscMessage("/wek/inputs/");

  for (int u = 0; u < Users.length; u++) {

    msg.add(Users[u].wristLeftX);
    msg.add(Users[u].wristLeftY);
    msg.add(Users[u].wristRightX);
    msg.add(Users[u].wristRightY);
    msg.add(Users[u].noseX);
    msg.add(Users[u].noseY);
    
  }

  msg.add(userDistance());
  
  oscP5.send(msg, remoteLocation);
  
}
