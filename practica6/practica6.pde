import java.lang.*;
import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;

Capture cam;
CVImage img;
CascadeClassifier face,leye,reye;
String faceFile, leyeFile,reyeFile;
boolean derecho,izquierdo,crear,guia;
float x;
int count;
ArrayList<objeto> objetos= new ArrayList<objeto>();
Marcador cesta; 


void setup() {
  size(640, 480);
  cesta=new Marcador(width/2);
  crear=true;
  x=0;
  derecho=true;
  izquierdo=true;
  count=0;
  guia=false;
  cam = new Capture(this, width , height);
  cam.start(); 
  
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  img = new CVImage(cam.width, cam.height);
  
  faceFile = "haarcascade_frontalface_default.xml";
  leyeFile = "haarcascade_mcs_lefteye.xml";
  reyeFile = "haarcascade_mcs_righteye.xml";
  face = new CascadeClassifier(dataPath(faceFile));
  leye = new CascadeClassifier(dataPath(leyeFile));
  reye = new CascadeClassifier(dataPath(reyeFile));
}

void draw() {  
  if(guia){
  if (cam.available()) {
    
    
    
    
    background(0);
    cam.read();
    
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
    img.copyTo();
    
    Mat gris = img.getGrey();
    
    image(img,0,0);
    
    FaceDetect(gris);
    actualizaMovimiento();
    noStroke();
    fill(101,67,33);
    arc(width/2+x, height-25, 85, 60, 0, PI, OPEN);
    gris.release();
    fill(0);
    rect(0,0,width,50);
    fill(255);
    textSize(40);
    text("Puntuación: "+cesta.getPoints(),20,40);
    textSize(12);
     text("Pulsa 'ENTER' para salir",505,20);
  
  }
  }else{
  background(255);
  MostrarInstrucciones();
  }
}

void FaceDetect(Mat grey)
{
  Mat auxroi;
  

  MatOfRect faces = new MatOfRect();
  face.detectMultiScale(grey, faces, 1.15, 3, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(60, 60), new Size(200, 200));
  Rect [] facesArr = faces.toArray();
  

  noFill();
  strokeWeight(4);

  
  //Búsqueda de ojos
  MatOfRect leyes,reyes;
  for (Rect r : facesArr) {    
    //Izquierdo (en la imagen)
    leyes = new MatOfRect();
    Rect roi=new Rect(r.x,r.y,(int)(r.width*0.7),(int)(r.height*0.6));
    auxroi= new Mat(grey, roi);
    
    //Detecta
    leye.detectMultiScale(auxroi, leyes, 1.15, 3, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(30, 30), new Size(200, 200));
    Rect [] leyesArr = leyes.toArray();
    
    //Dibuja
    stroke(0,255,0);
    izquierdo=false;
    for (Rect rl : leyesArr) {    
      rect(rl.x+r.x, rl.y+r.y, rl.height, rl.width);   //Strange dimenions change
      izquierdo=true;
    }
    leyes.release();
    auxroi.release(); 
     
     
    //Derecho (en la imagen)
    reyes = new MatOfRect();
    roi=new Rect(r.x+(int)(r.width*0.3),r.y,(int)(r.width*0.7),(int)(r.height*0.6));
    auxroi= new Mat(grey, roi);
    
    //Detecta
    reye.detectMultiScale(auxroi, reyes, 1.15, 3, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(30, 30), new Size(200, 200));
    Rect [] reyesArr = reyes.toArray();
    
    //Dibuja
    stroke(0,0,255);
    derecho=false;
    for (Rect rl : reyesArr) {    
      rect(rl.x+r.x+(int)(r.width*0.3), rl.y+r.y, rl.height, rl.width);   //Strange dimenions change
      derecho=true;
    }
    reyes.release();
    auxroi.release(); 
    

  }
  
  faces.release();
}




void actualizaMovimiento(){
      count++;
    if(!izquierdo && x>-(width/2-5)){
      x=x-10;
      cesta.setX(-10);
    }
    if(!derecho && x<(width/2-5)){
      x=x+10;
      cesta.setX(+10);
    }
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
}


void MostrarInstrucciones(){
   count++;
   background(255);
   fill(0);
     textSize(40);
     text("OjosFit",20,40);
     textSize(20);
     text("OjosFit es un juego que permite el entrenamiento de los\nparpados. \n\n Consiste en recoger el máximo de bolas posibles, usando el\ncesto que veras en pantalla. Para desplazar el cesto debe cerrar\nlos ojos, izquierdo para moverte a la izquierda y el derecho\nal contrario, siempre desde el punto de vista de la pantalla.\nPara el correcto funcionamiento debe estar en un lugar bien \niluminado. En cuento más pequeña sea la bola, más puntos recibes.   ",20,100);
     textSize(15);
     text("Creado por Rubén Garcia Quintana",width/3.5,height-30);
       fill(0,143,57);
       textSize(25);
       text("Pulsa 'ENTER' para Empezar",width/4,height-60);
       
     
 }
 
 
 void keyPressed(){
     if(key==ENTER){
       guia=!guia;
       cesta.reset();
     }
   }
