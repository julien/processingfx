PImage img;

void setup() {
  size(600, 600);
  img = createImage(width, height, RGB);
}

void draw() {
  img.loadPixels();

  float time = millis() * 0.002;
  float cx1 = sin(time / 2) * width / 3 + width / 2;
  float cy1 = sin(time / 4) * height / 3 + height / 2;
  float cx2 = cos(time / 3) * width / 3 + width / 2;
  float cy2 = cos(time) * height / 3 + height / 2;
  int destOfs = 0;

  for (int y = 0; y < height; y++) {
    float dy1 = (y - cy1) * (y - cy1);
    float dy2 = (y - cy2) * (y - cy2);
    for (int x = 0; x < width; x++) {
      float dx1 = (x - cx1) * (x - cx1);
      float dx2 = (x - cx2) * (x - cx2);
      int dist = (int)sqrt(dx1 + dy1) ^ (int)sqrt(dx2 + dy2);
      int shade = ((dist >> 4) & 1) * 255; //<>//
      
      img.pixels[destOfs++] = shade; //<>//
    }
  }
 
  img.updatePixels();
  image(img, 0, 0);
}
