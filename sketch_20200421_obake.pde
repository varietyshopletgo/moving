import ddf.minim.*;

Minim minim;
AudioPlayer player;

/* make atom */
PImage myImage;
int i,j;
int imgSize = 100;
float etp;
color[][] clr = new color[imgSize][imgSize];
boolean[][] bln = new boolean[imgSize][imgSize];

float[][] pharseA = new float[imgSize][imgSize];
float[][] pharseW = new float[imgSize][imgSize];
float[][] pharseH = new float[imgSize][imgSize];
float[][] pharseSP = new float[imgSize][imgSize];
float[][] maxW = new float[imgSize][imgSize];
float[][] maxH = new float[imgSize][imgSize];

/* done once */
void setup(){
  /* make world */
  size(800,600);
  blendMode(SCREEN); 
  colorMode(HSB);
  //noStroke();
  
  minim = new Minim(this);
  player = minim.loadFile("data/not_a_distopia.mp3");
  player.play();
  
  /* drow OBAKE once */
  myImage = loadImage("seirei.png");
  background(0,0,100,100);
  image(myImage,0,0,imgSize,imgSize);
  
  /* pickup ALL Pixcels */
  for(i=0;i<imgSize;i++){
    for(j=0;j<imgSize;j++){
      clr[i][j] = get(i,j);
      
      bln[i][j] = true;
      if(hue(clr[i][j])==0 && saturation(clr[i][j])==0 && brightness(clr[i][j])==100){
        clr[i][j] = color(0,0,100,0);
        bln[i][j] = false;
      }
    }
  }

  /* setup ALL Pixcels */
  for(i=0;i<imgSize;i++){
    for(j=0;j<imgSize;j++){
      if(bln[i][j]){
        pharseA[i][j] = random(0,1);
        pharseW[i][j] = random(0,1);
        pharseH[i][j] = random(0,1);
        pharseSP[i][j] = random(-0.01,0.01);
        maxW[i][j] = random(100,1000);
        maxH[i][j] = random(100,1000);
      }
    }
  }
  
  
  etp = 1.0;

  /* reset the screen */
  background(0,0,100,100);
}

void draw(){
  /* reset the screen */
  background(0,0,0);
  

  /* controler */
  if (mousePressed == true) {
    if(etp>0.001){
      etp *= 0.8;
    }
  } else {
    if(etp<1){
      etp *= 1.5;
    }else{
      etp = 1;
    }
  }
  
   float radiusL=player.left.level() * 100;
   float radiusR=player.left.level() * 1000;
   
  /* draw ALL Pixcels */
  for(i=0;i<imgSize;i++){
    for(j=0;j<imgSize;j++){
      if(bln[i][j]){
        fill(100,100,100);
        if (mousePressed == true){
        ellipse (i*3 +250 + sin(TWO_PI * (pharseA[i][j]+pharseW[i][j]))*maxW[i][j]*etp , j*3 +150+ cos(TWO_PI * (pharseA[i][j]+pharseH[i][j]))*maxH[i][j]*etp, radiusL, radiusL);       
            }else{ 
          ellipse (i*3 + 250 + sin(TWO_PI * (pharseA[i][j]+pharseW[i][j]))*maxW[i][j]*etp , j*3 +150+ cos(TWO_PI * (pharseA[i][j]+pharseH[i][j]))*maxH[i][j]*etp, radiusR, radiusR);
         }
      }
      
      /* move pharses */
      pharseA[i][j] += pharseSP[i][j];
    }
  }
}

void stop() { //stop関数
  player.close();
  minim.stop();
  super.stop();
}
