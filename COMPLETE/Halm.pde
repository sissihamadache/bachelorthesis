class Halm{
  ArrayList history;
  //Leaf lone, ltwo, lthree;
  int rand;
  color from;
  color to;
  boolean finished;
  float x,x1,x2,x3,y,y2,y3,y4;
  float timer;
  ArrayList rnd; 
  float _x,_y,_z;
  float r,th=0,step=.1,epi=200;
  float m = 1,n1=-1,n2=0,n3=0;
  float b=1,a=1;
  int counter1, counter2;
  PVector last, two;
  Halm(float x_, float y_){
    x = x_;
    y = y_;
    finished=false;
    from = color(0,random(100,200), 0);
    to = color(0, random(50,100), 0);
    x1=random(x-50,x+50);
    x2=random(x-50,x+50);
    x3=random(x-50,x+50);
    y2=random(y-100,y);
    y3=random(y-200,y-100);
    y4=random(y-300,y-300);
    history = new ArrayList();
    rnd = new ArrayList();
    rand = (int) random(10);
    m=int(random(3,40));
    n1=random(.5);
    n2=random(6.);
    epi=random(100,200);
    step=random(.05,10);
  }
  
  void finish(){
    float len = history.size()-1;
    PVector one = (PVector) history.get((int)len/4);
    two = (PVector) history.get((int)len/2);
    PVector three = (PVector) history.get((int)len*3/4);
    int steps = 10;
    beginShape();
    pushStyle();
    for (int j = 0; j <= steps; j++) {
      float t = j / float(steps);      
      stroke(lerpColor(from, to, t));
      float x_ = bezierPoint(x,x1,x2,x3, t);
      float y_ = bezierPoint(y,y2,y3,y4, t);  
      float z = bezierPoint(0,0,0,0,t);      
      vertex(x_, y_, z);
      PVector act = new PVector(x_,y_,z);
      rnd.add(act);
    }
    endShape();
  }
  
  void star(){
    float s = (frameCount/1000.0)%1;
    float e1 = bezierPoint(x,x1,x2,x3,s);
    float e2 = bezierPoint(y,y2,y3,y4,s);
    PVector p = new PVector(e1,e2,0);
    history.add(p);
    pushStyle();fill(0); 
    ellipse(e1,e2,20,20);
    for(int i=0; i<history.size()-2;i++){
      PVector q1 = (PVector) history.get(i);
      PVector q2 = (PVector) history.get(i+1);
      stroke(0,100,10);
      if(q1.dist(q2) <= 50)
        line(q1.x,q1.y,q2.x,q2.y);
      else{
        last = (PVector) history.get(history.size()-2);
        finished=true;
        break;} 
    }
    popStyle();
    PVector f = (PVector) history.get(history.size()-1);
  }
/*  
  void drawBluete(){
    stroke(0,35);
    noFill();
    translate(last.x,last.y);
    beginShape();
    for(int i=1; i < 2; i++) {
      r = epi*pow(((pow(abs(cos(m*th/4)/a),n2))+(pow(abs(sin(m*th/4)/b),n3))),(-1/n1)); 
      th = th + step;
      x = r*cos(th);
      y = r*sin(th);
      curveVertex(x,y);
      //println("m: "+m+" "+"n1: "+n1+" "+"n2: "+n2+" "+"theta: "+th+" "+"step: "+step);
    }
    endShape();
  }
  
  void drawHeart(float x , float y)
{
     pushMatrix();
     //scale(-1,1,1);
     translate(-x,-y);
     rotate(radians(90));
     //rotateY(radians(315));
     translate(x,y);
     stroke(0,150,5);
     fill(0,150,5);
     beginShape();
       vertex(x, y);
       bezierVertex(x, x-55, x+40, x-55, x, x-10); //You (Right)
       vertex(x, y);
       bezierVertex(x, x-55, x-40, x-55, x, x-10); //Me (Left)
     endShape();
     beginShape();
       vertex(x, y);
       bezierVertex(x, x-55, x+40, x-55, x, x-10); //You (Right)
       vertex(x, y);
       bezierVertex(x, x-55, x-40, x-55, x, x-10); //Me (Left)
     endShape();
     popMatrix();
}

void rightHeart(float x , float y)
{
     pushMatrix();
     scale(-1,1,1);
     //translate(0,-x,-y);
     rotate(radians(90));
     rotateY(radians(315));
     //translate(0,x,y);
     stroke(0,150,5);
     fill(0,150,5);
     beginShape();
     vertex(x, y);
     bezierVertex(x, x-55, x+40, x-55, x, x-10); //You (Right)
     vertex(x, y);
     bezierVertex(x, x-55, x-40, x-55, x, x-10); //Me (Left)
     endShape();
     beginShape();
     vertex(x, y);
     bezierVertex(x, x-55, x+40, x-55, x, x-10); //You (Right)
     vertex(x, y);
     bezierVertex(x, x-55, x-40, x-55, x, x-10); //Me (Left)
     endShape();
     popMatrix();
}*/
}

