class Plant {
  float xp = width/2;   
  float yp = height/2;   
  float zp = height/2;        
  
  float radius = 30; 
      
  ArrayList paths;  
    
  
  Plant(){
    paths = new ArrayList();
  }
   
  public void init() {
  }
  
  public void addPath(int index) {
    Path p = new Path(index);
    p.mom = this;
    p.beta = random(PI*2);
    p.alpha = random(PI*2);
    paths.add(paths.size(), p);
    p.init();
  }
  
  public void update() {
    for (int i = 0; i < paths.size(); i ++) {
      Path p = (Path) paths.get(i); 
      if(p.dead==false)
        p.update();
    }
  }
  
  public void render() {
    translate(xp, yp, zp);
    pushMatrix();
    if (record) {
      beginRecord("nervoussystem.obj.OBJExport", "hmm.obj");
    }
    for (int i = 0; i < paths.size(); i ++) {
      Path p = (Path) paths.get(i);
        p.render();
        p.li();  
    }
    if (record) {
    endRecord();
    record = false;
    println("done"); 
  }
    popMatrix();
  }
  
  public void tryLeaves(){
    translate(xp, yp, zp);
    pushMatrix();
    for (int j = 0; j < paths.size(); j ++) {
      Path p = (Path) paths.get(j);
      for ( int jj = 0; jj < p.history.size(); jj+=5 ) {
        PVector pp = (PVector) p.history.get(jj);
        pushMatrix(); translate(pp.x,pp.y,pp.z);
         popMatrix();
      }
    }
      
    popMatrix();
    
  }
}
