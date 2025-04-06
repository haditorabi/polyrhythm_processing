class PianoKey {
  int midi;
  boolean isBlack;
  float x, y, w, h;
  boolean active = false;

  PianoKey(int midi, boolean isBlack, float x, float y, float w, float h) {
    this.midi = midi;
    this.isBlack = isBlack;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw() {
    if (isBlack) {
      fill(active ? color(255, 0, 0) : 0);
      noStroke();
      rect(x, y, w, h);
    } else {
      fill(active ? color(255, 150, 150) : 255);
      stroke(0);
      rect(x, y, w, h);
      noStroke();
    }
  }
}
