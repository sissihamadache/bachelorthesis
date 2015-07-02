 
 
float circleLeafSizeMin = 10;
float circleLeafSizeMax = 20;

class circleLeaf{
  
float x,y;
float padding;
float l; 
float angle;
float dir;
color col;

  circleLeaf(float x,float y){
    x = x; 
    y = y;
    padding = random(0.2,1);
    //d = random(0.5);
    l =  random(circleLeafSizeMin, circleLeafSizeMax);
    angle = random(PI/6, PI/2);
    dir = random(-2,2);
  }

  void draw(){
    stroke(0,100,5); fill(0,150,3);
    drawcircleLeaf(padding, x, y, l, angle, dir);
  }
  void drawcircleLeaf(float padding, float x, float y, float l, float angle, float dir) {
    strokeWeight(l / 20);
   
    float angleAbstand = dir * PI/4; //random(PI/6, PI/2);
     
    /* the circleLeaf shouldn't start in the middle of the line / branch which means the first point of the circleLeaf needs to be re-calculated */
    x = x + cos(angle + angleAbstand) * padding;
    y = y + sin(angle + angleAbstand) * padding;
   
    /* calculate the peak of the circleLeaf */
    float endX = x + cos(angle + angleAbstand) * l;
    float endY = y + sin(angle + angleAbstand) * l;
   
    /* Calulating control points */
    float controlAngle = PI/5; // random (PI/7, PI/4.5);
    float controlPosition = 0.35 * dist (x, y, endX, endY); // random (0.25, 0.5)
    float controlOneX = x/*lerp (x, endX, 0.5)*/ + cos (angle + angleAbstand + controlAngle) * controlPosition;
    float controlOneY = y/*lerp (y, endY, 0.5)*/ + sin (angle + angleAbstand + controlAngle) * controlPosition;
   
    float controlTwoX = x/*lerp (x, endX, 0.5)*/ + cos (angle + angleAbstand - controlAngle) * controlPosition;
    float controlTwoY = y/*lerp (y, endY, 0.5)*/ + sin (angle + angleAbstand - controlAngle) * controlPosition;
     
    /* draw the circleLeaf */
    beginShape();
    curveVertex (controlTwoX, controlTwoY);
    curveVertex (x, y);
    curveVertex (controlOneX, controlOneY);
    curveVertex (endX, endY);
    curveVertex (endX, endY);
    curveVertex (controlTwoX, controlTwoY);
    curveVertex (x, y);
    curveVertex (controlOneX, controlOneY);
    endShape (CLOSE);
   
    line (x, y, endX, endY);
  }
}
