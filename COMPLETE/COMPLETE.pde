/////////////////////////INFO//////////////////////////////
//PRESS A FOR 3D SHAPED PLANT ; B FOR 2D ; C FOR 1D
//UNCOMMENT THE LAST LINE IN SETUP FOR 3D VIEW
//=======================================IF YOU'VE PRESSED A:
//GENERATE BUGS BY CLICKING;
//KILL THEM BY CLICKING ON THEM AGAIN
//RIGHT CLICK THEM TO DESTROY THEIR PATH
//PRESS F TO CHANGE THE FLOWER TYPE
//PRESS P TO STOP THE BUGS FROM MOVING
//PRESS R TO IMPORT TO PRINTABLE FILE
//=======================================IF YOU'VE PRESSED B:
//GENERATE LEAVES BY KLICKING
//=======================================IF YOU'VE PRESSED C:
//CREATE STRAWS BY CLICKING 


import peasy.*;
import java.io.*;
import java.awt.Color;
import processing.opengl.*;
import java.util.*;
import nervoussystem.obj.*;
//////////////////////////////////////////////PREPARATION
///////////////////////////////GENERAL
int t;
PeasyCam cam;
boolean record;
boolean changeFlower;
///////////////////////////////HALM
int count=1; int lcount=1;
Halm halm;
ArrayList halme;
///////////////////////////////CIRCLE
color col;
color c = color(0,100,5);
color d = color(0,200,10);
ArrayList poses;
ArrayList circleLeaves;
float radius = 100;
boolean loop = true;
float angle = -35; 
int circleLeafCount=0;
///////////////////////////////PLANT
int index;
Plant planty;
boolean go=true,once=true;
color bug = color(165,142,142);
final color first= color(0,100,0);
final color sec = color(255,180,0);
final color thrd = color(200,80,0);
final color four = color(105,180,0);
final color five = color(50,50,0);
final color six = color(100,100,0);
//////////////////////////////////////////////
void setup() {
  size(500,500,P3D);
  smooth(4);
  background(0);
  frameRate(120);
  /////////////////////////////////////HALM
  ///////////////////////////////////CIRCLE
  halm = new Halm(width/2,height-100);
  halme = new ArrayList();
  poses = new ArrayList();
  circleLeaves = new ArrayList();
  halme.add(halm);
  float x = cos(TWO_PI*-35/360)*radius;
  float y = sin(TWO_PI*-35/360)*radius;
  PVector first = new PVector(x,y);
  poses.add(first);
  for(int i=0; i<150; i++)
    circleLeaves.add(new circleLeaf(0,0));
    
  ///////////////////////////////////PLANT
  planty = new Plant();
  planty.init();
  
  ////////////////////////////////////CAM
  println("Press A to create spherical plant, B to make a wreath and C to grow a flower");

  //cam = new PeasyCam(this, 0, 0, 0, 30);
}

void menu1(){  
  if(once){
  println("PLANT");
  once=false;}
  background(0);
  if(go){
    planty.update();
    planty.render();
  }
}
void menu2(){
  if(once){
  println("HALM");
  once=false;}
  background(255);
    for(int i=0; i<count; i++){
      Halm act = (Halm) halme.get(i);
      if (act.finished==false)
        act.star();
      else{
        act.finish();
      }
    }
}
void menu3(){
  if(once){
  println("CIRCLE");
  once=false;}
  background(0);
  float xcoord = cos(angle*TWO_PI/360)*radius; //+random(-0.5,0.5); // here we calculate the x-position of the point
  float ycoord = sin(angle*TWO_PI/360)*radius; // here we calculate the y-position of the point
  float kopfx = cos((angle+4.5)*TWO_PI/360)*radius; //+random(-0.5,0.5); // here we calculate the x-position of the point
  float kopfy = sin((angle+4.5)*TWO_PI/360)*radius; // here we calculate the y-position of the point
  float blattx = cos((angle-8)*TWO_PI/360)*radius; //+random(-0.5,0.5); // here we calculate the x-position of the point
  float blatty = sin((angle-8)*TWO_PI/360)*radius; // here we calculate the y-position of the point
  PVector pos = new PVector(xcoord,ycoord);
  poses.add(pos);
  translate(width/2, height/2); 
  pushMatrix(); translate(0,0,5);
  fill(0); noStroke(); ellipse(0,0,100,100); popMatrix();
  noFill();
  
  angle = angle + 1; 
  if (mousePressed && (mouseButton == LEFT)) {
      circleLeaf mom = (circleLeaf) circleLeaves.get(frameCount%150);
      mom.x = blattx; mom.y = blatty;
  }/*
  if (mousePressed && (mouseButton == RIGHT)) {
      flower moms = (flower) flowers.get(frameCount%150);
      moms.posx = blattx; moms.posy = blatty;
  }*/

  stroke(0, 100, 5);
  strokeWeight(1);
  for(int i=1; i<poses.size()-1; i++){
    PVector one = (PVector) poses.get(i-1);
    PVector two = (PVector) poses.get(i);
    col = lerpColor(c,d,0.5);
    stroke(col);
    line(one.x,one.y,two.x,two.y);
  }
  fill(255); stroke(255);
  ellipse(xcoord,ycoord,10,10);
  ellipse(kopfx,kopfy,4,4);
  for(int j=2; j<circleLeaves.size()-1; j++){
      circleLeaf leaf = (circleLeaf) circleLeaves.get(j);
      leaf.draw();
      /*flower flower = (flower) flowers.get(j);
      flower.draw(); */
   }
}
////////////////////////////////////////////MENUE
void draw(){
  ambientLight(102, 102, 102);
  pointLight(220, 220, 220, 550, 600, 560);
  pointLight(220, 180, 180, -450, 0, 100);
  pointLight(180, 180, 220, 450, 400, 700);
  if(t==1) menu1();
  if(t==2) menu3();
  if(t==3) menu2();
  
}

void mouseClicked(){
  if(t==3){
    if ( mouseButton == LEFT ){
      Halm h = new Halm(mouseX,mouseY);
      halme.add(h);
      count++;
    }
  }
  if(t==1){
    loadPixels();
    int hey=0;
    final color c = pixels[mouseY*width + mouseX];
    if(c==sec) hey=1; else if(c==thrd) hey=2; 
    else if(c==four) hey=3; else if(c==five) hey=4;
    else if(c==six) hey=5;
    Path dummy = (Path) planty.paths.get(hey);
    dummy.dead = true;
    if(mouseButton==RIGHT)
      planty.paths.remove(hey);   
  }
}

void keyReleased(){
  if(key=='a')
    t=1;
  if(key=='b')
    t=2;
  if(key=='c')
    t=3;
  if(t==1){
    if(key=='p'){
      if(go)
        go=false;
      else 
        go=true;
    }
    if(key=='f'){
      if(changeFlower)
        changeFlower=false;
      else 
        changeFlower=true;
    }
    if(key==' '){
      planty.addPath(index);
      if(index<6)
        index++;
      else
        index=0;
    }
  }
  
  if (key == 'r') {
    record = true;
  }
} 
