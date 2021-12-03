/* User Setup
 
 >> ADD DESCRIPTION HERE <<
 
 */

class User {
  float noseX, noseY, shoulderLeftX, shoulderLeftY, shoulderRightX, shoulderRightY, elbowLeftX, elbowLeftY, elbowRightX, elbowRightY, wristLeftX, wristLeftY, wristRightX, wristRightY, hipLeftX, hipLeftY, hipRightX, hipRightY, kneeLeftX, kneeLeftY, kneeRightX, kneeRightY;

  User (JSONArray keypoints) {

    //Import X and Y coordinates of keypoints
    noseX = keypoints.getJSONArray(ModelUtils.POSE_NOSE_INDEX).getFloat(0); 
    noseY = keypoints.getJSONArray(ModelUtils.POSE_NOSE_INDEX).getFloat(1);
    shoulderLeftX = keypoints.getJSONArray(ModelUtils.POSE_LEFT_SHOULDER_INDEX).getFloat(0);
    shoulderLeftY = keypoints.getJSONArray(ModelUtils.POSE_LEFT_SHOULDER_INDEX).getFloat(1);
    shoulderRightX = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_SHOULDER_INDEX).getFloat(0);
    shoulderRightY = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_SHOULDER_INDEX).getFloat(1);
    elbowLeftX = keypoints.getJSONArray(ModelUtils.POSE_LEFT_ELBOW_INDEX).getFloat(0);
    elbowLeftY = keypoints.getJSONArray(ModelUtils.POSE_LEFT_ELBOW_INDEX).getFloat(1);
    elbowRightX = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_ELBOW_INDEX).getFloat(0);
    elbowRightY = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_ELBOW_INDEX).getFloat(1);
    wristLeftX = keypoints.getJSONArray(ModelUtils.POSE_LEFT_WRIST_INDEX).getFloat(0);
    wristLeftY = keypoints.getJSONArray(ModelUtils.POSE_LEFT_WRIST_INDEX).getFloat(1);
    wristRightX = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_WRIST_INDEX).getFloat(0);
    wristRightY = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_WRIST_INDEX).getFloat(1);
    hipLeftX = keypoints.getJSONArray(ModelUtils.POSE_LEFT_HIP_INDEX).getFloat(0);
    hipLeftY = keypoints.getJSONArray(ModelUtils.POSE_LEFT_HIP_INDEX).getFloat(1);
    hipRightX = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_HIP_INDEX).getFloat(0);
    hipRightY = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_HIP_INDEX).getFloat(1);
    kneeLeftX = keypoints.getJSONArray(ModelUtils.POSE_LEFT_KNEE_INDEX).getFloat(0);
    kneeLeftY = keypoints.getJSONArray(ModelUtils.POSE_LEFT_KNEE_INDEX).getFloat(1);
    kneeRightX = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_KNEE_INDEX).getFloat(0);
    kneeRightY = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_KNEE_INDEX).getFloat(1);
  };

  public float rightWrist() {
    float deltaWristToElbow = (wristRightX - elbowRightX)*width;
    if (deltaWristToElbow > wristMov) {
      return wristMov;
    } else if (deltaWristToElbow < -(wristMov)) {
      return -(wristMov);
    } else {
      return deltaWristToElbow;
    }
  };

  public float leftWrist() {
    float deltaWristToElbow = (wristLeftX - elbowLeftX)*width;
    if (deltaWristToElbow > wristMov) {
      return wristMov;
    } else if (deltaWristToElbow < -(wristMov)) {
      return -(wristMov);
    } else {
      return deltaWristToElbow;
    }
  };

  public float rightElbow() {
    float deltaElbowToShoulder = (elbowRightY - shoulderRightY)*height;
    if (deltaElbowToShoulder > shoulderMov) {
      return shoulderMov;
    } else if (deltaElbowToShoulder < -(shoulderMov)) {
      return -(shoulderMov);
    } else {
      return deltaElbowToShoulder;
    }
  };

  public float leftElbow() {
    float deltaElbowToShoulder = (elbowLeftY - shoulderLeftY)*height;
    if (deltaElbowToShoulder > shoulderMov) {
      return shoulderMov;
    } else if (deltaElbowToShoulder < -(shoulderMov)) {
      return -(shoulderMov);
    } else {
      return deltaElbowToShoulder;
    }
  };
};


//Calculate the distance between users
public float userDistance() {
  if (Users[1] != null) {
    float[][] centerPoints = new float[2][2];

    for (int u = 0; u <= 1; u++) {
      float averageX, averageY = 0;
      averageX = (Users[u].shoulderLeftX + Users[u].shoulderRightX + Users[u].hipLeftX + Users[u].hipRightX)/4;
      averageY = (Users[u].shoulderLeftY + Users[u].shoulderRightY + Users[u].hipLeftY + Users[u].hipRightY)/4;
      centerPoints[u][0] = averageX*width;
      centerPoints[u][1] = averageY*height;
    };

    float userDistance = abs(sqrt(sq(centerPoints[1][0] - centerPoints[0][0])+sq(centerPoints[1][1] - centerPoints[0][1])));
    return userDistance;
  } else {
    return width-width/10;
  }
}; 
