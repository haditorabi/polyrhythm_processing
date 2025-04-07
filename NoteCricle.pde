class NoteCircle {
  String name;
  int midi;
  float x, y;
  float size;
  color noteColor;
  boolean hasPlayed = false;

  // 🌟 Glow properties
  float glowAlpha = 2;
  float glowMaxAlpha = 255;
  float glowDecayRate = 2.0;
  float glowSizeMultiplier = 1.8;
  color glowColor = color(#FFFFFF);
  int glowRays = 8;
  float glowPulse = 3.0;

  NoteCircle(String name, int midi) {
    this.name = name;
    this.midi = midi;
    this.size = 8;
    this.noteColor = color(255, 200);
  }

  void updatePosition(float tf, int index, int totalCount, float centerX, float centerY, float rotationAngle) {
    float dist = sqrt(index / (float)totalCount) * (height - 120) * 0.45;
    float ang = TWO_PI * tf * index;

    float baseX = dist * cos(ang) + centerX;
    float baseY = dist * sin(ang) + centerY;

    float rotatedX = cos(rotationAngle) * (baseX - centerX) - sin(rotationAngle) * (baseY - centerY) + centerX;
    float rotatedY = sin(rotationAngle) * (baseX - centerX) + cos(rotationAngle) * (baseY - centerY) + centerY;

    x = rotatedX;
    y = rotatedY;
  }

  void triggerGlow() {
    glowAlpha = glowMaxAlpha;
    hasPlayed = true;
  }

  void display() {
    if (glowAlpha > 0) {
      drawGlow();
      glowAlpha -= glowDecayRate;
      glowAlpha = max(glowAlpha, 0);
    }

    // Base note circle
    fill(noteColor);
    noStroke();
    circle(x, y, size);

    // Label
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(11);
    text(name, x, y - size / 2 - 10);
  }

  void drawGlow() {
    pushStyle();
    noStroke();

    float glowSize = size * glowSizeMultiplier;
    float alpha = glowAlpha;

    // 1. Glowing halo
    for (int i = 0; i < 3; i++) {
      float ringSize = glowSize * (1.0 + 0.2 * i);
      fill(glowColor, alpha * (0.3 - 0.08 * i));
      ellipse(x, y, ringSize, ringSize);
    }

    // 2. Spark rays
    pushMatrix();
    translate(x, y);
    stroke(glowColor, alpha * 0.25);
    strokeWeight(1.5);
    for (int i = 0; i < glowRays; i++) {
      float angle = TWO_PI * i / glowRays + random(-0.02, 0.02);
      float len = size * glowSizeMultiplier * random(0.9, 1.3);
      line(0, 0, cos(angle) * len, sin(angle) * len);
    }
    popMatrix();

    popStyle();
  }

  // Optional tuning
  void setGlowColor(color c) {
    glowColor = c;
  }

  void setGlowFadeRate(float rate) {
    glowDecayRate = rate;
  }

  void setGlowSizeMultiplier(float mult) {
    glowSizeMultiplier = mult;
  }

  void setGlowIntensity(float maxAlpha) {
    glowMaxAlpha = maxAlpha;
  }

  void setGlowRays(int rays) {
    glowRays = rays;
  }
}
