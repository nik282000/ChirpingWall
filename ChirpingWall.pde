//Chirping Wall

int frameTime = 0;
float maxFrames = sqrt(sq(1280 * 2) + sq(720 * 2));
String fName;
float ix = 40;
float iy = 200;
float[] px = new float[16];
float[] py = new float[16];
float[] pd = new float[16];

void setup(){
  size(1280,720);
}

void draw(){
  background(255); //start the frame blank
  wall();
  clap(ix, iy, 3, 0);
  drawPoint(ix, iy, 10);
  for(int i = 0; i < 16; i = i + 1){
    clap(px[i], py[i], 2, pd[i]);
  }
  
  //makeImage();
  
  frameTime = frameTime + 1;    //next frame
  if(frameTime >= maxFrames){   //end of animation control
    exit();
  }
  
}

void drawPoint(float x, float y, float thickness){
  if(x > 0 && x <= width && y > 0 && y <= height){
    strokeWeight(thickness);
    point(x, y);
  }
  strokeWeight(1);
}

void drawLine(float x, float y, float x2, float y2, float thickness){
  if(x > 0 && x <= width && y > 0 && y <= height && x2 > 0 && x <= width && y2 > 0 && y <= height){
     strokeWeight(thickness);
     line(x, y, x2, y2);
  }
}

void drawArc(float x, float y, float thickness, float radius){
  for(float a = 0; a <= 360; a = a + 1){
    //drawPoint(x + (cos(a / (180 / PI)) * radius), y + (sin(a / (180 / PI)) * radius), thickness);
    drawLine(x + (cos(a / (180 / PI)) * radius), y + (sin(a / (180 / PI)) * radius), x + (cos((a - 1) / (180 / PI)) * radius), y + (sin((a - 1) / (180 / PI)) * radius), thickness);
  }
}

void makeImage(){
  fName = (nf(frameTime, 4) + ".png");
  save(fName);
}

void clap(float x, float y, float thickness, float iTime){ //start a growing arc at x,y and frame iTime
  if(frameTime >= iTime){
    drawArc(x, y, thickness, frameTime - iTime);
  }
}

void wall(){
  int x = 0;
  int y = 720;
  strokeWeight(3);
  for(int i = 0; i <= 15; i = i + 1){
    line(x, y, x + 40, y - 40);
    px[i] = x + 40;
    py[i] = y - 40;
    pd[i] = sqrt(sq(px[i] - ix) + sq(py[i] - iy));
    line(x + 40, y - 40, x + 80, y);
    x = x + 80;
    }
}