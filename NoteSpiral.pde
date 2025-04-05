class NoteSpiral {
  ArrayList<NoteCircle> circles;
  float tf = 10;
  float rotationAngle = 0;
  LineToTop line;  // Declare the LineToTop object

  NoteSpiral() {
    AllowedNotes map = new AllowedNotes();
    circles = map.getNoteCircles();

    // Initialize the LineToTop object with the center of the spiral
    line = new LineToTop(width / 2, height / 2);
  }

  void updateAndDraw() {
    tf += 0.00001;
    rotationAngle += 0.001;  // Gradually increment the rotation angle for smooth rotation

    float centerX = width / 2;
    float centerY = height / 2;

    // Apply rotation to the entire spiral set (all circles will rotate together)
    for (int i = 0; i < circles.size(); i++) {
      NoteCircle c = circles.get(i);
      c.updatePosition(tf, i, circles.size(), centerX, centerY, rotationAngle);
      c.display();
    }

    // Set the color of the line and draw it
    line.setLineColor(color(255));
    line.setThickness(2);  // Set thickness inside the class
    line.drawLine();  // Draw the line
  }
}
