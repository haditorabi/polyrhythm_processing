MidiSender midi;

void setup() {
  midi = new MidiSender("ProcessingToDAW");  // Use your virtual port name
}

void draw() {
  if (frameCount % 60 == 0) {
    midi.sendNote("C4", 100, 200);  // Middle C, velocity 100, hold for 200ms
  }
}
