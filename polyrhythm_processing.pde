//MidiSender midi;

//void setup() {
//  midi = new MidiSender("ProcessingToDAW");  // Use your virtual port name
//}

//void draw() {
//  if (frameCount % 60 == 0) {
//    midi.sendNote("C5", 100, 200);  // Middle C, velocity 100, hold for 200ms
//  }
//}
AllowedNotes noteMap;
ArrayList<NoteCircle> circles;
float tf = 0;

void setup() {
  size(1200, 800);
  background(0);
  noStroke();
  colorMode(HSB);

  noteMap = new AllowedNotes();
  circles = noteMap.getNoteCircles();
}

void draw() {
  background(0);
  tf += 0.00001;

  float centerX = width / 2;
  float centerY = height / 2;

  for (int i = 0; i < circles.size(); i++) {
    NoteCircle c = circles.get(i);
    c.updatePosition(tf, i, circles.size(), centerX, centerY);
    c.display();
  }
}
