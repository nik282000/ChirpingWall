//Chirping Wall Demo for Processing.org 3

int frameTime = 0;    //used to track animation frames
float maxFrames = sqrt(sq(1280 * 2) + sq(720 * 2));  //number of frames = twice the diagonal width of the image
                                                     //because the 'speed of sound' is 1px/frame
String fName;  //stores numbered file names for png export
float ix = 40;  //initial x location of clap
float iy = 200; //initial y location of clap
float[] px = new float[16];  //stores x location of peaks on the wall
float[] py = new float[16];  //stures y location of peaks on the wall
float[] pd = new float[16];  //stores distance from initial clap to each peak

void setup(){
  size(1280,720);
}

void draw(){
  background(255); //start the frame blank
  wall();          //draw the wall
  clap(ix, iy, 3, 0);  //start the inital clap at time 0
  drawPoint(ix, iy, 10);  //draw the initial clap location
  for(int i = 0; i < 16; i = i + 1){  //for all 16 peaks on the wall draw their echo
    clap(px[i], py[i], 2, pd[i]);
  }
  
  //makeImage();
  
  frameTime = frameTime + 1;    //next frame
  if(frameTime >= maxFrames){   //end of animation control
    exit();
  }
  
}

void drawPoint(float x, float y, float thickness){  //re-inventing the wheel, can't remember why
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

void drawArc(float x, float y, float thickness, float radius){  //draws an arc that doesn't extend past the edge of the screen.
  for(float a = 0; a <= 360; a = a + 1){  //making the increment smaller makes the arcs smoother but takes way more time to run
    //drawPoint(x + (cos(a / (180 / PI)) * radius), y + (sin(a / (180 / PI)) * radius), thickness);
    drawLine(x + (cos(a / (180 / PI)) * radius), y + (sin(a / (180 / PI)) * radius), x + (cos((a - 1) / (180 / PI)) * radius), y + (sin((a - 1) / (180 / PI)) * radius), thickness);
  }
}

void makeImage(){  //used to export images.
  fName = (nf(frameTime, 4) + ".png");
  save(fName);
}

void clap(float x, float y, float thickness, float iTime){ //start a growing arc at x,y and frame iTime
  if(frameTime >= iTime){    //no reverse echos before the initial clap arrives at a peak
    drawArc(x, y, thickness, frameTime - iTime);  //draw an arc that expands with every frame after it's initial time
  }
}

void wall(){  //draws a wall made of peaks, records location of the peaks and their distance from the initial clap in px[], py[] and pd[]
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
