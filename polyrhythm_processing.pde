//MidiSender midi;

//void setup() {
//  midi = new MidiSender("ProcessingToDAW");  // Use your virtual port name
//}

//void draw() {
//  if (frameCount % 60 == 0) {
//    midi.sendNote("C5", 100, 200);  // Middle C, velocity 100, hold for 200ms
//  }
//}
PImage bgImage;
NoteSpiral spiral;
boolean isPaused = false;

void setup() {
  size(1200, 800);
  background(0);
  noStroke();
  colorMode(HSB);
  bgImage = loadImage("gradient.jpeg"); 
  spiral = new NoteSpiral();
}
void keyPressed() {
  if (key == ' ') {
    isPaused = !isPaused;
    println("⏯ Paused: " + isPaused);
  }
}
void draw() {
  if (!isPaused) {
    background(bgImage);
    spiral.updateAndDraw();
  } else {
    // Optional: overlay a pause indicator
    fill(255, 200);
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Paused", width / 2, height / 1.23);
  }

}
