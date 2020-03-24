
class Marcador{

  float puntos,x;
  public Marcador(float x){
  this.x=x;
  puntos=0;
  }  
  
  void setX(float x2){
    x=x+x2;

  }
    void reset(){
    puntos=0;

  }
  float getPoints(){
    return puntos;

  }

  boolean dentro(float x2,float puntos,float y2){
    if(x2*2>x-43 && x2*2<x+43&& y2 < height-30){
        this.puntos+=puntos;
        return true;
    }
    return false;
  }
}
