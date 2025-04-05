class NoteCircle {
  String name;
  int midi;
  float x, y;

  NoteCircle(String name, int midi) {
    this.name = name;
    this.midi = midi;
    this.x = 0;
    this.y = 0;
  }

  void updatePosition(float tf, int index, int totalCount, float centerX, float centerY) {
    float dist = sqrt(index / (float)totalCount) * height * 0.45;
    float ang = TWO_PI * tf * index;
    x = dist * cos(ang) + width / 2;
    y = dist * sin(ang) + height / 2;

    x = lerp(x, centerX, (totalCount - index) / (totalCount * 5.0));
    y = lerp(y, centerY, (totalCount - index) / (totalCount * 5.0));
  }

  void display() {
    fill(255, 200);  // white-ish
    circle(x, y, 8);
  }
}
