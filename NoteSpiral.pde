class NoteSpiral {
  ArrayList<NoteCircle> circles;
  float tf = 10;
  NoteSpiral() {
    AllowedNotes map = new AllowedNotes();
    circles = map.getNoteCircles();
  }

  void updateAndDraw() {
    tf += 0.00001;

    float centerX = width / 2;
    float centerY = height / 2;

    for (int i = 0; i < circles.size(); i++) {
      NoteCircle c = circles.get(i);
      c.updatePosition(tf, i, circles.size(), centerX, centerY);
      c.display();
    }
  }
}
