
  
  float factor = TWO_PI / 20.0;
  float bx, by, bz;
  PVector[] sphereVertexPoints;
  
 
  void drawBug(float rho) {
  pushStyle();
  for(float phi = 0.0; phi < HALF_PI; phi += factor) {
    beginShape(QUAD_STRIP);
    for(float theta = 0.0; theta < TWO_PI + factor; theta += factor) {
      bx = rho * sin(phi) * cos(theta);
      bz = rho * sin(phi) * sin(theta);
      by = -rho * cos(phi);
      
      vertex(bx, by, bz);
      
      bx = rho * sin(phi + factor) * cos(theta);
      bz = rho * sin(phi + factor) * sin(theta);
      by = -rho * cos(phi + factor);
      
      vertex(bx, by, bz);
    }
    endShape(CLOSE);
  }
  popStyle();

}
