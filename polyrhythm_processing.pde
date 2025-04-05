//MidiSender midi;

//void setup() {
//  midi = new MidiSender("ProcessingToDAW");  // Use your virtual port name
//}

//void draw() {
//  if (frameCount % 60 == 0) {
//    midi.sendNote("C5", 100, 200);  // Middle C, velocity 100, hold for 200ms
//  }
//}
NoteSpiral spiral;

void setup() {
  size(1200, 800);
  background(0);
  noStroke();
  colorMode(HSB);

  spiral = new NoteSpiral();
}

void draw() {
  background(0);
  spiral.updateAndDraw();
}
