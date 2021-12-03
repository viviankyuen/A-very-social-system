//import processing.sound.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim;
AudioSample shortBeat1;
AudioSample shortBeat2;
AudioSample shortSnare1;
AudioSample shortSnare2;
AudioSample acid1;
AudioSample acid2;
AudioSample dood;

long prevBeat, prevSnare, prevAcid, prevDood = 0;

int beatFreq = 500;
int snareFreq = beatFreq*4-10;
int acidFreq = beatFreq*12+20;
long doodFreq = beatFreq*2+5;


void setupAudioControls() {

  // Initialize minim and load sound files
  minim = new Minim(this);
  shortBeat1 = minim.loadSample("Shortbeat1.wav", 2048);
  shortBeat2 = minim.loadSample("Shortbeat2.wav", 2048);
  shortSnare1 = minim.loadSample("Shortsnare1.wav", 2048);
  shortSnare2 = minim.loadSample("Shortsnare2.wav", 2048);
  acid1 = minim.loadSample("Acid1.wav", 2048);
  acid2 = minim.loadSample("Acid2.wav", 2048);
  dood = minim.loadSample("Dood.wav", 2048);
}

void updateAudio() {

  beatFreq = floor(map(Users[a].rightElbow(), shoulderMov, - shoulderMov, 700, 500));
  int diversity = floor(map(Users[a].leftWrist(), -wristMov, wristMov, 0, 5));
  

  if (diversity == 0) {

    if (prevBeat < millis() - beatFreq) {
      shortBeat1.trigger();
      prevBeat = millis();
    }
  } else if (diversity == 1) {

    if (prevBeat < millis() - beatFreq) {
      shortBeat1.trigger();
      prevBeat = millis();
    }

    if (prevSnare < millis() - snareFreq) {

      shortSnare1.trigger();
      prevSnare = millis();
    }
  } else if (diversity == 2) {

    if (prevBeat < millis() - beatFreq) {
      shortBeat1.trigger();
      prevBeat = millis();
    }

    if (prevSnare < millis() - snareFreq) {

      shortSnare1.trigger();
      prevSnare = millis();
    }

    if (prevSnare < millis() - snareFreq/2) {

      shortSnare2.trigger();
      prevSnare = millis();
    }
  } else if (diversity == 3) {

    if (prevBeat < millis() - beatFreq) {
      shortBeat1.trigger();
      prevBeat = millis();
    }

    if (prevSnare < millis() - snareFreq) {

      shortSnare1.trigger();
      prevSnare = millis();
    }

    if (prevSnare < millis() - snareFreq/2) {

      shortSnare2.trigger();
      prevSnare = millis();
    }

    if (prevDood < millis() - doodFreq) {

      dood.trigger();
      prevDood = millis();
    }
  } else if (diversity == 4) {

    if (prevBeat < millis() - beatFreq) {
      shortBeat1.trigger();
      prevBeat = millis();
    }

    if (prevSnare < millis() - snareFreq) {

      shortSnare1.trigger();
      prevSnare = millis();
    }

    if (prevSnare < millis() - snareFreq/2) {

      shortSnare2.trigger();
      prevSnare = millis();
    }

    if (prevDood < millis() - doodFreq) {

      dood.trigger();
      prevDood = millis();
    }

    if (prevAcid < millis() - acidFreq) {

      acid1.trigger();
      prevAcid = millis();
    }
  }
}

 // Map mouseY from 0.2 to 1.0 for amplitude - Volume
 // Ex. http://code.compartmental.net/minim/gain_class_gain.html 
 // MAP TO DISTANCE B/T U1 AND U2 
 //gain = new Gain(0.f); // Starting Gain at 0 db; no change in amp
 //float amplitude = map(mouseX, 0, width, 6, 0); // 6 = 2x original volume
 //gain.setValue(amplitude);




/* 
 // Map mouseY from 0.2 to 1.0 for amplitude - Volume
 // Ex. http://code.compartmental.net/minim/gain_class_gain.html 
 // MAP TO DISTANCE B/T U1 AND U2 
 gain = new Gain(0.f); // Starting Gain at 0 db; no change in amp
 float amplitude = map(mouseX, 0, width, 6, 0); // 6 = 2x original volume
 gain.setValue(amplitude);
 
 // Map mouseY from -1.0 to 1.0 for left to right panning
 // MAP TO LEFT ARM - HORIZONTAL MOVEMENT
 // FIND AN AUDIOFILE THAT SUPPORTS PANNING
 float panning = map(mouseX, 0, width, -1.0, 1.0);
 audiofile.pan(panning);
 
 //Map mouseX from 0.5 to 3.0 for playback speed. (1 = orignal playback speed)
 // MAP TO lEFT ARM - VERTICAL MOVEMENT
 float playbackSpeed = map(mouseY, 0, height, 0.5, 2.0);
 audiofile.rate(playbackSpeed);
 
 // Change the roomsize of the reverb - Pedal effect
 // MAP TO RIGHT ARM - HORIZONTAL MOVEMENT
 float roomSize = map(mouseX, 0, width, 0, 1.0);
 reverb.room(roomSize);
 
 // Change the high frequency dampening parameter
 // MAP TO RIGHT ARM - VERICAL MOVEMENT
 float damping = map(mouseY, 0, height, 0, 1.0);
 reverb.damp(damping);
 
/* // Change the wet/dry relation of the effect - Effect of the sound processed 
 // MAP TO LEFT + RIGHT/ OR USE AS ANOTHER EFFECT IF PANNING DOESN'T WORK
 float effectStrength = map(mouseY, 0, height, 0, 1.0);
 reverb.wet(effectStrength);*/
