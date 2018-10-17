float angle = 0;
PImage img;

void setup() {
  size(600, 600);
  img = loadImage("2ndreal.jpg");
}

void draw() {
  loadPixels();

  float c = cos(angle * PI/180);
  float s = sin(angle * PI/180);

  angle += 1.25;
  angle %= 360;

  int destOfs = 0;

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int u = floor((x * c - y * s) * (s + 1)) & 0xff;
      int v = floor((x * s + y * c) * (s + 1)) % img.height;
      while (v < 0) {
        v += img.height;
      }
      int srcOfs = (int(u) + (int(v) << 8));
      pixels[destOfs++] = img.pixels[srcOfs++];
    }
  }

  updatePixels();
}
