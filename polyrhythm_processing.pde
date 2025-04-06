
PImage bgImage;
NoteSpiral spiral;
boolean isPaused = true;
ArrayList<PianoKey> pianoKeys = new ArrayList<PianoKey>();

void setup() {
  size(1200, 800);
  background(0);
  noStroke();
  colorMode(HSB);
  bgImage = loadImage("gradient.jpeg"); 
  buildPiano();
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
  for (PianoKey key : pianoKeys) {
    key.draw();
  }
}
void buildPiano() {
  pianoKeys.clear();

  String[] noteNames = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};

  // Count total white keys from A0 (21) to C8 (108)
  int whiteKeyCount = 0;
  for (int midi = 21; midi <= 108; midi++) {
    String name = noteNames[midi % 12];
    if (!name.contains("#")) whiteKeyCount++;
  }

  float whiteKeyWidth = width / (float)whiteKeyCount;
  float whiteKeyHeight = 120;
  float blackKeyWidth = whiteKeyWidth * 0.6;
  float blackKeyHeight = whiteKeyHeight * 0.6;

  float currentX = 0;

  // First, create white keys left to right
  for (int midi = 21; midi <= 108; midi++) {
    String note = noteNames[midi % 12];
    if (!note.contains("#")) {
      pianoKeys.add(new PianoKey(midi, false, currentX, height - whiteKeyHeight, whiteKeyWidth, whiteKeyHeight));
      currentX += whiteKeyWidth;
    }
  }

  // Then, overlay black keys based on white key positions
  for (int i = 0; i < pianoKeys.size() - 1; i++) {
    PianoKey left = pianoKeys.get(i);
    PianoKey right = pianoKeys.get(i + 1);
  
    int midiBetween = left.midi + 1;
    String note = noteNames[midiBetween % 12];

    // Only add black keys that exist on a real piano
    if (note.equals("C#") || note.equals("D#") || note.equals("F#") || note.equals("G#") || note.equals("A#")) {
      float bx = (left.x + right.x + left.w) / 2 - blackKeyWidth / 2;
      pianoKeys.add(new PianoKey(midiBetween, true, bx, height - whiteKeyHeight, blackKeyWidth, blackKeyHeight));
    }
  }
  // Optional: sort so white keys draw first, black keys on top
  Collections.sort(pianoKeys, (a, b) -> Boolean.compare(a.isBlack, b.isBlack));
}
