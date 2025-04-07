class NoteCircle {
  String name;
  int midi;
  float x, y;
  float size;       // Variable for size of the circle
  color noteColor;  // Variable for the color of the circle
  boolean hasPlayed = false;
  // Constructor
  NoteCircle(String name, int midi) {
    this.name = name;
    this.midi = midi;
    this.x = 0;
    this.y = 0;
    this.size = 8;  // Default size
    this.noteColor = color(255, 200);  // Default color (white-ish)
  }

  // Update position based on the spiral layout and apply rotation to the entire set around its center
  void updatePosition(float tf, int index, int totalCount, float centerX, float centerY, float rotationAngle) {
    float dist = sqrt(index / (float)totalCount) * (height-120) * 0.45;
    float ang = TWO_PI * tf * index;

    // Calculate the initial position based on the spiral geometry (without rotation)
    float baseX = dist * cos(ang) + centerX;
    float baseY = dist * sin(ang) + centerY;

    // Apply rotation to the entire set (rotate around the center)
    float rotatedX = cos(rotationAngle) * (baseX - centerX) - sin(rotationAngle) * (baseY - centerY) + centerX;
    float rotatedY = sin(rotationAngle) * (baseX - centerX) + cos(rotationAngle) * (baseY - centerY) + centerY;

    // Smooth the position of each circle (lerp to smooth the movement)
    x = rotatedX; // Directly assign rotatedX to x
    y = rotatedY; // Directly assign rotatedY to y
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
    textSize(11);
    text(name, x, y - size / 2 - 10);  // Display the note name above the circle
  }
}
