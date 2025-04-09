MidiSender midi;
PShader metaballShader;
Theme theme;
PGraphics shaderBuffer;

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
    // Load shaders
    metaballShader = loadShader("frag.glsl", "vert.glsl");
    // Select random theme
    theme = getRandomTheme();
    shaderBuffer = createGraphics(width, height, P3D);

  }

  void updateAndDraw() {
    background(unhex(theme.background.substring(1) + "FF"));
    float[] dataCircles = new float[circles.size() * 3];
    float[] dataCirclesColors = new float[circles.size() * 3];

    tf += 0.0001;
    rotationAngle += 0.0005;  // Gradually increment the rotation angle for smooth rotation

    float centerX = width / 2;
    float centerY = (height-120) / 2;
    float threshold = 8;  // How close to center x to count as a collision



    // Apply rotation to the entire spiral set (all circles will rotate together)
    for (int i = 0; i < circles.size(); i++) {
      NoteCircle c = circles.get(i);
      c.updatePosition(tf, i, circles.size(), centerX, centerY, rotationAngle);
      if (abs(c.x - width/2) < threshold && abs(c.y) < height/2 && !c.hasPlayed) {
        midi.sendNote(c.midi, 100, 1400);
        c.hasPlayed = true; 
        //c.triggerGlow();
      }
      
      if (abs(c.x - width/2) >= threshold) {
        c.hasPlayed = false;  
      }
    }
    for (int i = 0; i < circles.size(); i++) {      
      // Fill position and radius data
      NoteCircle c = circles.get(i);
      dataCircles[i * 3] = c.x;
      dataCircles[i * 3 + 1] = c.y;
      dataCircles[i * 3 + 2] = 20;
      
      // Fill color data
      dataCirclesColors[i * 3] = hexToRGB(theme.colors[0])[0];
      dataCirclesColors[i * 3 + 1] = hexToRGB(theme.colors[0])[1];
      dataCirclesColors[i * 3 + 2] = hexToRGB(theme.colors[0])[2];
    }
    line.setLineColor(color(255));
    line.setThickness(2);  // Set thickness inside the class

    metaballShader.set("metaballs", dataCircles, 3);
    metaballShader.set("metaballColors", dataCirclesColors, 3);
    metaballShader.set("WIDTH", (float)width);
    metaballShader.set("HEIGHT", (float)height);
    shaderBuffer.beginDraw();
    shaderBuffer.background(unhex(theme.background.substring(1) + "FF"));
    shaderBuffer.shader(metaballShader);
    shaderBuffer.rect(0, 0, width, height);
    shaderBuffer.resetShader();
    piano.draw(shaderBuffer);
    line.draw(shaderBuffer);  // Draw the line
    shaderBuffer.endDraw();
    image(shaderBuffer, 0, 0, width, height);
    
    midi.update();  // Handles delayed note-offs

  }
}
Theme getRandomTheme() {
  Theme[] themes = {
    new Theme("Night Sky", new String[]{"#45217C", "#0799F2", "#FFFFFF"}, "#150832"),
    //new Theme("Fireball", new String[]{"#581845", "#900C3F", "#C70039", "#FF5733", "#FFC30F"}, "#1A0633"),
    //new Theme("Oceania", new String[]{"#77C39C", "#2F5E36", "#55ABA5", "#2D7063", "#3F6829", "#44A872", "#215964", "#CDEDAE"}, "#162A25"),
    //new Theme("Plankton", new String[]{"#BCE784", "#5DD39E", "#348AA7", "#525174", "#513B56"}, "#051A0A"),
    //new Theme("Fireflies", new String[]{"#B7F0AD", "#D2FF96", "#EDDF7A", "#E8D33F", "#D17B0F"}, "#141115"),
    //new Theme("Green Planet", new String[]{"#91CB3E", "#4F772D", "#31572C", "#CEFF1A"}, "#1A181B"),
    //new Theme("Red Planet", new String[]{"#813405", "#D1462F", "#E4572E", "#EE964B"}, "#2F100F"),
    //new Theme("Autumn", new String[]{"#D62828", "#F77F00", "#FCBF49", "#EAE2B7"}, "#003049"),
    //new Theme("Icefire", new String[]{"#0067B2", "#066DE0", "#3AC5FF", "#81FFFA"}, "#321016"),
    //new Theme("Parrot", new String[]{"#1BE7FF", "#6EEB83", "#E4FF1A", "#E8AA14", "#FF5714"}, "#161032"),
    //new Theme("Velvet", new String[]{"#38040E", "#640D14", "#800E13", "#AD2831"}, "#190225"),
    //new Theme("Dreamland", new String[]{"#E8FFF1", "#BAFFE9", "#DF89F9", "#472CAA", "#47AA2C", "#2406FC"}, "#172211"),
    //new Theme("Desertscape", new String[]{"#3A4A4A", "#FEED5A", "#DA9D3B", "#7E4F3E", "#E3AF80"}, "#322D12"),
    //new Theme("Magma", new String[]{"#3A0300", "#5D0D02", "#EB4700", "#FF9F01", "#CD5201"}, "#161032"),
    //new Theme("Magma", new String[]{"#3A0300", "#5D0D02", "#EB4700", "#FF9F01", "#CD5201"}, "#351812"),
    //new Theme("Amethyst", new String[]{"#7B66DE", "#9381E4", "#AB9DEA", "#C3B9F0", "#DBD5F6"}, "#2D1534"),
    //new Theme("OpenProcessing", new String[]{"#73C1E8", "#73494A", "#F54949"}, "#333333"),
    //new Theme("Steelheart", new String[]{"#5C504A", "#4B3D3C", "#413535", "#30323D", "#3B3E4D"}, "#161022"),
    //new Theme("Goldrush", new String[]{"#151515", "#E6E9F1", "#EDB009", "#939496", "#717372"}, "#150A28"),
    //new Theme("Lava", new String[]{"#990000", "#D81515", "#EA2C2C", "#FFE500", "#FFED2D"}, "#151218"),
    //new Theme("Dragonfly", new String[]{"#01BAEF", "#79CC33", "#757575", "#FDFDFD"}, "#002947"),
    //new Theme("Dragonfruit", new String[]{"#B41059", "#EFF7F7", "#FEA4D0", "#91C66C", "#77B802"}, "#0A0808"),
    //new Theme("Royalty", new String[]{"#8E371C", "#E58434", "#DDAC39", "#8A036F", "#231616"}, "#120612"),
    //new Theme("Cotton Candy", new String[]{"#9E9CF6", "#A6F7B7", "#F4B966", "#C9DEE5", "#CADA8A", "#E2C26E"}, "#2D1273"),
    //new Theme("Android", new String[]{"#5c5c5c", "#a8a8a8", "#e3e3e3", "#82d43b", "#b7ff87"}, "#212121"),
    //new Theme("Wildwood", new String[]{"#7a5d52", "#007525", "#2dc039", "#60573c", "#249fbd"}, "#442710")
  };
  
  return themes[(int)random(themes.length)];
}

// Helper function to convert hex color to RGB float array
float[] hexToRGB(String hex) {
  float[] rgb = new float[3];
  rgb[0] = unhex(hex.substring(1, 3)) / 255.0;
  rgb[1] = unhex(hex.substring(3, 5)) / 255.0;
  rgb[2] = unhex(hex.substring(5, 7)) / 255.0;
  return rgb;
}
