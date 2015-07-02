void drawLeaf(float padding, float x, float y, float l, float angle, float dir) {
  pushStyle(); pushMatrix(); 
  stroke(0,100,5); fill(0,150,3);
  strokeWeight(l / 20);
  float aa = dir * PI/4; 
  
  //x = x + cos(angle + aa) * padding;
  //y = y + sin(angle + aa) * padding;
 
  float endX = x + cos(angle + aa) * l;
  float endY = y + sin(angle + aa) * l;
 
  float ca = PI/5; 
  float cp = 0.35 * dist (x, y, endX, endY);
  float cox = x+ cos (angle + aa + ca) * cp;
  float coy = y + sin (angle + aa + ca) * cp;
 
  float ctx = x + cos (angle + aa - ca) * cp;
  float cty = y + sin (angle + aa - ca) * cp;
   
  beginShape();
  curveVertex (ctx, cty, 0);
  curveVertex (x, y, 0);
  curveVertex (cox, coy, 10);
  curveVertex (endX, endY, 0);
  curveVertex (endX, endY, 0);
  curveVertex (ctx, cty, 0);
  curveVertex (x, y, 0);
  curveVertex (cox, coy, 10);
  endShape (CLOSE);
 
  line (x, y, 0, endX, endY, 0);
  popStyle(); popMatrix();
}

