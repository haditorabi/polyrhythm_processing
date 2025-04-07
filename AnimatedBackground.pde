class AnimatedBackground {
  PImage img;
  float hueShift = 0;
  float saturation = 1.0;
  float angle = 0;
  float hueSpeed = 0.02;
  float rotationSpeed = 0.0001;
  float scaledSize;

  AnimatedBackground(String imagePath) {
    img = loadImage(imagePath);
    img.loadPixels();
    
    // Compute diagonal so it always fills screen even when rotated
    float diagonal = dist(0, 0, width, height);
    scaledSize = diagonal * 1.1; // extra padding to avoid borders
  }

  void update() {
    hueShift = (hueShift + hueSpeed) % 255;
    saturation = 0.5 + 0.5 * sin(frameCount * 0.01);
    angle += rotationSpeed;
  }

  void display() {
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(angle);
    tint(hueShift, saturation * 255, 255);
    imageMode(CENTER);
    image(img, 0, 0, scaledSize, scaledSize);  // Scaled to always cover screen
    popMatrix();
    noTint();
  }
}
