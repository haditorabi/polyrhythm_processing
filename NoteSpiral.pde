class NoteSpiral {
  ArrayList<NoteCircle> circles;
  float tf = 10;
  float rotationAngle = 0;  // This will control the smooth rotation of the entire spiral set

  NoteSpiral() {
    AllowedNotes map = new AllowedNotes();
    circles = map.getNoteCircles();
  }

  void updateAndDraw() {
    tf += 0.000001;
    rotationAngle += 0.01;  // Gradually increment the rotation angle for smooth rotation

    float centerX = width / 2;
    float centerY = height / 2;

    // Apply rotation to the entire spiral set (all circles will rotate together)
    for (int i = 0; i < circles.size(); i++) {
      NoteCircle c = circles.get(i);
      
      // Update position based on spiral layout and apply rotation to the entire set
      c.updatePosition(tf, i, circles.size(), centerX, centerY, rotationAngle);
      c.display();
    }
  }
}
