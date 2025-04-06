
PImage bgImage;
NoteSpiral spiral;
boolean isPaused = true;

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
