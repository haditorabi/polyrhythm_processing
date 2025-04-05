class NoteCircle {
  String name;
  int midi;
  float x, y;
  float size;       // Variable for size of the circle
  color noteColor;  // Variable for the color of the circle

  // Constructor
  NoteCircle(String name, int midi) {
    this.name = name;
    this.midi = midi;
    this.x = 0;
    this.y = 0;
    this.size = 8;  // Default size
    this.noteColor = color(255, 200);  // Default color (white-ish)
  }

  // Method to update the position based on the spiral layout
  void updatePosition(float tf, int index, int totalCount, float centerX, float centerY) {
    float dist = sqrt(index / (float)totalCount) * height * 0.45;
    float ang = TWO_PI * tf * index;
    x = dist * cos(ang) + width / 2;
    y = dist * sin(ang) + height / 2;

    x = lerp(x, centerX, (totalCount - index) / (totalCount * 5.0));
    y = lerp(y, centerY, (totalCount - index) / (totalCount * 5.0));
  }

  // Setter for size
  void setSize(float newSize) {
    this.size = newSize;
  }

  // Setter for color
  void setColor(color newColor) {
    this.noteColor = newColor;
  }

  // Method to display the circle and the note name
  void display() {
    fill(noteColor);  // Set the fill color
    circle(x, y, size);  // Draw the circle
    fill(255);  // White for text
    textAlign(CENTER, CENTER);
    text(name, x, y - size / 2 - 10);  // Display the note name above the circle
  }
}
