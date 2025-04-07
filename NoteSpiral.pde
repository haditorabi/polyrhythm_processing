MidiSender midi;

class NoteSpiral {
  ArrayList<NoteCircle> circles;
  float tf = 10;
  float rotationAngle = 0;
  LineToTop line;  // Declare the LineToTop object
  Piano piano;

  NoteSpiral() {
    AllowedNotes map = new AllowedNotes();
    circles = map.getNoteCircles();
    piano = new Piano(); 
    midi = new MidiSender("ProcessingToDAW", piano);
    // Initialize the LineToTop object with the center of the spiral
    line = new LineToTop(width / 2, (height-120) / 2);
  }

  void updateAndDraw() {
    tf += 0.0001;
    rotationAngle += 0.0005;  // Gradually increment the rotation angle for smooth rotation

    float centerX = width / 2;
    float centerY = (height-120) / 2;
    float threshold = 8;  // How close to center x to count as a collision



    // Apply rotation to the entire spiral set (all circles will rotate together)
    for (int i = 0; i < circles.size(); i++) {
      NoteCircle c = circles.get(i);
      c.updatePosition(tf, i, circles.size(), centerX, centerY, rotationAngle);
      c.display();
      if (abs(c.x - width/2) < threshold && abs(c.y) < height/2 && !c.hasPlayed) {
        midi.sendNote(c.midi, 100, 1400);
        c.hasPlayed = true; 
        c.triggerGlow();
      }
      
      if (abs(c.x - width/2) >= threshold) {
        c.hasPlayed = false;  
      }

    }
    // Set the color of the line and draw it
    line.setLineColor(color(255));
    line.setThickness(2);  // Set thickness inside the class
    line.drawLine();  // Draw the line
    piano.draw();
    midi.update();  // Handles delayed note-offs

  }
}
