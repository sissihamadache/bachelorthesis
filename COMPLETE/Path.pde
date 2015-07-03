
  int[] mousePrecision = {1,2,0};
  
  class Path {
  ///////////////////////////////////////////
  //supershapecreator by someone else
  float[][][] m,  mHires;
  fnCycle fns = new fnCycle();
  shapeFn fn;
  int mc0, mc1; 
  int ic0, ic1;
  final static int LORES=0, MIXRES=1, HIRES=2;
  boolean grid = true, faces = true, light = true, colors = true, output=false;
  int loRes = 60, hiRes = 180;
  int mode = LORES;
  float minZoom = 1, maxZoom = 100;
  float rotX=PI/4, rotY=-PI/8, rotZ=-PI*2/3, moveX, moveY, zoom = 2;
  ///////////////////////////////////////////
  Plant mom;
  ArrayList history = new ArrayList();
  float radius;  float alpha;  float beta;
  float betas = 0;  float alphas = 0;
  
  float vx,vy,vz;
  float pathSize = 100;
  float stray;
  
  
  color col;  
  color green; 
  boolean dead,stop;
  
  Path(int index) {
    if (index==0)
      col = color(139,90,0);
    else if (index==1)
      col = color(255,180,0);
    else if (index==2)
      col = color(200,80,0);
    else if (index==3)
      col = color(105,180,0);
    else if (index==4)
      col = color(50,50,0);
    else if (index==5)
      col = color(100,100,0);
    green = color(0,random(100,255),random(50));
    
    //fns.add(new supershape(40,4,0.17,-0.61,-0.66,5,8.93,-0.81,87.44));
    fns.add(new supershape(40,6,-0.47,1.61,0.87,0,1,1,1));
    //fns.add(new supershape(40,5.2,0.04,1.7,1.7,0,1,1,1));
    //fns.add(new supershape(40,6,0.173275,31.5035,-0.980,5,93.3607,-0.327466,68.91));
    //fns.add(new supershape(40, 6, 0.709889, 46.6299, -0.602, 7, -31.9083, -0.196521, 97));
    //fns.add(new supershell(20, 10, 3, 0, 3, 4, 10, 10, 10, 0.6, 0.7, 2.5, 6));
    fn = fns.next();
    updateMesh();
  }
  
  public void init() {
    pathSize = 3;
    betas = random(-0.02, 0.02);
    alphas = random(-0.02, 0.02);
    stray = random(10,-10);
  }
  
  public void update() {
    beta += betas;
    alpha += alphas;
  }
  
  public void render() {
    if(!stop){
      float r = mom.radius + stray;
      float y = sin(beta) * sin(alpha) * r;
      float x = cos(beta) * sin(alpha) * r;
      float z = cos(alpha) * r; 
      float y2 = sin(beta+betas*2) * sin(alpha+alphas*2) * r;
      float x2 = cos(beta+betas*2) * sin(alpha+alphas*2) * r;
      float z2 = cos(alpha+alphas*2) * r; 
      vx = x; vy = y; vz = z; 
      ad();
      pushMatrix();
      translate(x,y,z);
      if(dead==false)
        fill(col);
      else { 
        fill(0);
        die();
      }
      noStroke();
      //sphere(pathSize);
      drawBug(pathSize);
      popMatrix(); 
      pushMatrix();
      translate(x2,y2,z2);
      if(dead){fill(0);}
      drawBug(pathSize/2);
      popMatrix();
    }
  }
  
  float w=0;
  public void die(){
    fill(col);
    if(w<height){
      translate(0,w,0);
      drawBug(pathSize);
      //translate(0,2.5,0);
      //sphere(pathSize-1);
      w+=5;
    }
    else
      stop=true;
  }
  
  public void ad(){
    PVector dummy = new PVector(vx,vy,vz);
    history.add(dummy);
  }
  
  public void li(){
    pushStyle(); 
    fill(0,155,10); 
    //pg.beginShape(); 
    for(int i=0; i<history.size()-1; i++){
      PVector p = (PVector) history.get(i);
      pushMatrix();
      translate(p.x,p.y,p.z);
      sphere(1);
      if(i%29==0){
        if(i%3==0)
          drawLeaf(1,0,0,10,PI/4,-1);
        if(i%5==0)    
          drawLeaf(1,0,0,5,PI/2,1);
        if(i%7==0)
          drawLeaf(1,0,0,7,PI/6,1);
        if(i%11==0)
          drawLeaf(1,0,0,6,PI,1);
        if(i%13==0)
          drawLeaf(1,0,0,7,PI/8,1);
      }
      
      if(i%139==20){
         if(changeFlower){
          translate(-1,-1,-1);
          scale(0.02);
          pushMatrix();
          rotateY(radians(135));
          rotateZ(radians(45));
          drawB();
          popMatrix();
        }
      }
      popMatrix();
      if(i%139==20){
        if(!changeFlower){
          pushMatrix();
          translate(p.x+2,p.y,p.z);
          rotate(radians(90));
          redrawImage();
          popMatrix();
        }
      }
     // popMatrix();
    }
    popStyle(); //popMatrix();
  }

    void redrawImage() {
    //translate(width/2, height/2);
    //g3d.translate(moveX, moveY);
    rotateX(rotX); rotateY(rotY); rotateZ(rotZ);
    scale(zoom);
    render(m);
    ic1=ic0;
  }

float[][][] mesh(shapeFn fn, int imax, int jmax) {
 float[][][] m = new float[imax+1][jmax+1][3];
 for(int i=0; i<=imax; i++) {
    for(int j=0; j<=jmax; j++) {
      float u = map(i, 0, imax, 0, 1);
      float v = map(j, 0, jmax, 0, 1);
      m[i][j] = fn.eval(u,v);  
    }
  }  
  return m;
}
int yres(int res) {
  return  int(fn.getRatio() * res);
} 

void updateImage() {
  ic0++;
}

 void updateMesh() {
   int res = loRes;
   m = mesh(fn, yres(res), res ); mc0++;
   updateImage();
}
void render(float[][][] mesh) {
  pushMatrix(); pushStyle();
  scale(0.025);
  int imax = mesh.length;
  int jmax = mesh[0].length;
  if (grid) stroke(255,255,255,50); else noStroke(); 
  for(int i=0; i<imax-1; i++) {
    float p[];
    //if (faces) g.fill(colors ? Color.HSBtoRGB(float(i)/imax, 0.5, 1.0) : 255); else g.noFill();  
    noFill(); 
    drawBug(1);
    beginShape(QUAD_STRIP); 
    for(int j=0; j<jmax; j++) {
      fill(frameCount%200,0,0);
      p = m[i][j]; vertex(p[0],p[1],p[2]);
      fill(0,0,frameCount%200);
      p = m[i+1][j]; vertex(p[0],p[1],p[2]);
    }
    endShape();
  }
  popMatrix(); popStyle();
}
}
