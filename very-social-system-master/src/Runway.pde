/* Runway Setup

>> ADD DESCRIPTION HERE <<

*/

import com.runwayml.*;          // Import Runway library
RunwayHTTP runway;              // Create Runway instance
JSONObject data;                // Create JSONObject to store raw data
User[] Users = new User[2];     // Create array to hold User objects
long prevTimeUser1 = 0;         // Store millis for received data User 1
long prevTimeUser0 = 0;         // Store millis for received data User 0
int timeOut = 1500;             // Milliseconds before reseting a player

//Set connections for drawing skeletons
int[][] connections = {
  {ModelUtils.POSE_NOSE_INDEX, ModelUtils.POSE_LEFT_EYE_INDEX}, 
  {ModelUtils.POSE_LEFT_EYE_INDEX, ModelUtils.POSE_LEFT_EAR_INDEX}, 
  {ModelUtils.POSE_NOSE_INDEX, ModelUtils.POSE_RIGHT_EYE_INDEX}, 
  {ModelUtils.POSE_RIGHT_EYE_INDEX, ModelUtils.POSE_RIGHT_EAR_INDEX}, 
  {ModelUtils.POSE_RIGHT_SHOULDER_INDEX, ModelUtils.POSE_RIGHT_ELBOW_INDEX},  
  {ModelUtils.POSE_RIGHT_ELBOW_INDEX, ModelUtils.POSE_RIGHT_WRIST_INDEX}, 
  {ModelUtils.POSE_RIGHT_SHOULDER_INDEX, ModelUtils.POSE_LEFT_SHOULDER_INDEX},
  {ModelUtils.POSE_LEFT_SHOULDER_INDEX, ModelUtils.POSE_LEFT_ELBOW_INDEX}, 
  {ModelUtils.POSE_LEFT_ELBOW_INDEX, ModelUtils.POSE_LEFT_WRIST_INDEX},
  {ModelUtils.POSE_LEFT_SHOULDER_INDEX, ModelUtils.POSE_LEFT_HIP_INDEX},
  {ModelUtils.POSE_RIGHT_SHOULDER_INDEX, ModelUtils.POSE_RIGHT_HIP_INDEX},
  {ModelUtils.POSE_RIGHT_HIP_INDEX, ModelUtils.POSE_RIGHT_KNEE_INDEX}, 
  {ModelUtils.POSE_RIGHT_KNEE_INDEX, ModelUtils.POSE_RIGHT_ANKLE_INDEX},
  {ModelUtils.POSE_RIGHT_HIP_INDEX, ModelUtils.POSE_LEFT_HIP_INDEX},
  {ModelUtils.POSE_LEFT_HIP_INDEX, ModelUtils.POSE_LEFT_KNEE_INDEX}, 
  {ModelUtils.POSE_LEFT_KNEE_INDEX, ModelUtils.POSE_LEFT_ANKLE_INDEX}
};


//Initiate new Runway instance
void initRunway() {   
  
  runway = new RunwayHTTP(this);

};


//Update data when new runwayData is available 
void runwayDataEvent(JSONObject runwayData) {
  
  //Fetch
  updateUsers(runwayData);
  data = runwayData;
  //Post
  //postRunwayOSC();
  
};


//Error handling
public void runwayErrorEvent(String error) {

  println(error);

};


//Update Users array
void updateUsers(JSONObject data) {

  if (data != null) {  
    JSONArray users = data.getJSONArray("poses");
    
    if (users.size() < 2) {
      if (prevTimeUser1 <= millis()-timeOut){
        Users[1] = null;
      }
    } else {
        prevTimeUser1 = millis();
    };
    
    if (users.size() < 1) {
      if (prevTimeUser0 <= millis()-timeOut) {
        Users[0] = null;
      };
    } else {
        prevTimeUser0 = millis();
    };
    
    for (int u = 0; u < users.size(); u++) {
      
      JSONArray keypoints = users.getJSONArray(u);
      Users[u] = new User(keypoints);
      
    };
    
  } else {   
    
      Users[0] = null;
      Users[1] = null;
 
  };
  
};
  

void drawPoseNetParts(JSONObject data) {
  //If user is detected
  if (data != null) {  
    JSONArray users = data.getJSONArray("poses");
    for (int u = 0; u < users.size(); u++) {
      JSONArray keypoints = users.getJSONArray(u);
      //Find keypoint coordinates for selected user
      for (int i = 0; i < connections.length; i++) {
        JSONArray startPart = keypoints.getJSONArray(connections[i][0]);
        JSONArray endPart   = keypoints.getJSONArray(connections[i][1]);
        //Extract floats from JSON array and scale normalized value to sketch size
        float startX = startPart.getFloat(0) * width;
        float startY = startPart.getFloat(1) * height;
        float endX   = endPart.getFloat(0) * width;
        float endY   = endPart.getFloat(1) * height;
        //Connect keypoints by lines
        stroke(255);
        strokeWeight(3);
        line(startX, startY, endX, endY);
      }
    }
  }
};
