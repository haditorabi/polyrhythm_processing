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

  void display() {
    if (active) {
      fill(isBlack ? 100 : 180);  // Gray out active keys
    } else {
      fill(isBlack ? 0 : 255);
    }
    stroke(0);
    rect(x, y, w, h);
    noStroke();
  }

  void setActive(boolean a) {
    this.active = a;
  }
}
