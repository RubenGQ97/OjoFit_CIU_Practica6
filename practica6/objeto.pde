

class objeto {
  PShape s;
  float x, y;
  float speed,radio,puntos;
  boolean flag;

  public objeto(float radio,Marcador cesta) {
    fill(255);
    flag=true;
    puntos=100/radio;
    this.radio=radio;
    x = random(width);
    y = 0; 
    s = createShape(ELLIPSE,x,y,radio,radio);
    speed = random(2, 6);
  }
  
  void caida() {
    if(flag){
        y += speed;
    if (y > height-45) {
        if(cesta.dentro(x,puntos,y))puntos=0;

    }else{
      if(y>height-15){ 
        flag=false;
        x = random(width);
        y = 0; 
      }

    }
    
    }

  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    shape(s);
    popMatrix();
  }
}
