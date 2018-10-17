import java.util.ArrayList;

PImage img;
int capacity = 600*2 + 600*2;
ArrayList distances = new ArrayList(capacity);
ArrayList angles = new ArrayList(capacity);

void setup() {
  size(600, 600);
  img = loadImage("space.jpg");

  for (int y = 0; y < height * 2; y++) {
    float sqy = (y - height) * (y - height);
    for (int x = 0; x < width * 2; x++) {
      float sqx = (x - width) * (x - width);
      distances.add(floor(32 * img.height / sqrt(sqx + sqy)) % height);
      angles.add(round(width * atan2(y - height, x - width) / PI));
    }
  }
}

void draw() {
  background(0);
  loadPixels();

  float time = millis() * 0.001;
  float shiftx = floor(img.width * time);
  float shifty = floor(img.height * 0.5 * time);
  float centerx = width / 2 + floor(width / 4 * sin(time / 0.4));
  float centery = height / 2 + floor(height / 4 * sin(time / 0.2));
  int stride = width * 2;
  int destOfs = 0;

  for (int y = 0; y < height; y++) {
    int srcOfs = int(y * stride + centerx + centery * stride);
    for (int x = 0; x < width; x++) {
      int u = ((int)distances.get(srcOfs) + (int)shiftx) & 0xff;
      int v = ((int)angles.get(srcOfs) + (int)shifty) % img.height;
      while (v < 0) {
        v += img.height;
      } //<>//
      srcOfs++; //<>//
      int pixOfs = (u + (v << 8));
      pixels[destOfs++] = img.pixels[pixOfs++];
    }
  }

  updatePixels();
}
