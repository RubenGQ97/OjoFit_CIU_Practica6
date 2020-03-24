# OjoFit Practica 6 CIU
##Rubén García Quintana
## Procesamiento de imagen y vídeo 

### Introducción
- En esta práctica se desea hacer uso de la webcam para realizar un prototipo de aplicación que muestre una salida gráfica en respuesta a
una captura de vídeo

![](gifOjo.gif)

### Desarrollo

- Usando las herramientas de las que disponia para reconocimiento facil, se ha realizado un pequeño minijuego como prueba. El juego consiste en intentar atrapar el máximo de bolas posibles que aparecen en la imagen usando una cesta, la cual solo podemos desplazar usando nuestros ojos. Véase que para la ejecución de la aplicación es importante estar en un lugar bien iluminado y estar lo más quieto posible durante la ejecución.



-Para la realización de la práctica de han creado tres clases; la principal, una para los objetos que hay que atrapar y otra para controlar la colisión y puntos totales. Además se ha dado uso de otras herramientas usadas anteriormente en la asignatura como PShape o el control de colisiones. Por diferentes dificultades a la hora de realizar la práctica finalmente se decidió por realizar una creación de entre 4 y 10 objetos cada 250 ejecuciones del bucle 'draw'.
```

```


.
.
.

if(count>250){
    count=0;
    crear=true;
  }
  if(crear){
    
    objetos.clear();
    
    for (int i = 0; i < random(4,10); i++) {
    crear=false;
    objetos.add(new objeto(random(15, 45),cesta));
  }
  }

  for (objeto obj : objetos) {
    obj.display();
    obj.caida();
    
  }

```

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
```



```


class objeto {
  PShape s;
  float x, y;
  float speed,radio,puntos;
  boolean flag;
  Marcador cesta;

  public objeto(float radio,Marcador cesta) {
    fill(255);
    this.cesta=cesta;
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
```




### Instrucciones
  - Enter - Empezar/Terminar entrenamiento.


