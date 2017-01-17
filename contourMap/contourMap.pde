import processing.svg.*;

import blobDetection.*;
import peasy.*;
import processing.pdf.*;
PeasyCam cam;

PImage img;

float levels = 10;
//float factor = 1;      //Scale factor, not used.
//float elevation = 50;  //Not used.

BlobDetection[] contours = new BlobDetection[int(levels)];

//Creating array to store the blob objects
ArrayList<Ring> rings = new ArrayList<Ring>();


void setup() {

  size(480, 360, P3D);
  surface.setResizable(true);

  //img = loadImage("bkmap_contrast.png");
  img = loadImage("map1.gif");
  surface.setSize(img.width, img.height);

  cam = new PeasyCam(this, img.width, img.height, 0, 1500);
  colorMode(HSB, 360, 100, 100);

  for (int i=0; i<levels; i++) {
    contours[i] = new BlobDetection(img.width, img.height);
    contours[i].setThreshold(i/levels);
    contours[i].computeBlobs(img.pixels);
  }

  for (int i = 0; i < rings.size(); i++) {
    System.out.println("id: " + rings.get(i).getId());
    System.out.println("lvl: " + rings.get(i).getLvl());
    System.out.println("x: " + rings.get(i).getX());
    System.out.println("y: " + rings.get(i).getY());
    System.out.println();
  }

  noLoop();
}


void draw() {
  
  //beginRecord(SVG, "master.svg");
  //endRecord();
  
  for (int i = 0; i<levels; i++){
  //for (int i=2; i<3; i++) {  
    
    beginRecord(SVG, "level-"+i+".svg");
    
    drawContours(i);
    println("drew level " + i);
    
    println("saved as: level-"+i+".svg");
    endRecord();
    println();
    
    if(i == levels-1){
      println("finished");
    }
    
  }
  
  System.out.println("Number of blobs (rings.size()): " + rings.size());
   println();
   
   for (int i = 0; i < rings.size(); i++){
   System.out.println("id: " + rings.get(i).getId());
   System.out.println("lvl: " + rings.get(i).getLvl());
   System.out.println("x: " + rings.get(i).getX());
   System.out.println("y: " + rings.get(i).getY());
   System.out.println();
   }

}

void drawContours(int i) {
  Blob b;
  Blob b2;    //Used for displacing previous blob by width and height of b2
  EdgeVertex eA, eB;
  for (int n=0; n<contours[i].getBlobNb(); n++) {
    b=contours[i].getBlob(n);
    
    if (n==0){
      b2 = b;
    }
    else {
      b2 = contours[i].getBlob(n-1);
    }
    
    //println("b: ",b.x,b.y,b.w,b.h);
    //println("b2: ",b2.x,b2.y,b2.w,b2.h); 
    
    //Condition for drawing only blobs bigger than 5% of width and 5% of height
    if(b.w*width>.05*width && b.h*height>.05*height){
      
      if (b!=null) {
        stroke(250, 75, 90);
  
        for (int m=0; m<b.getEdgeNb(); m++) {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
  
          //This part draws the blobs.
          //This is where we need to modify so that they are no overlaps.
          
          if (eA !=null && eB !=null)
           line(
           eA.x*img.width, eA.y*img.height, 
           eB.x*img.width, eB.y*img.height 
           );
           
           println("eA.x: " + eA.x);
           println("eA.y: " + eA.y);
           println("eB.x: " + eB.x);
           println("eB.y: " + eB.y);
           println();
           
           ////////////
           
           /*if (
               eA.x == 0 ||
               eA.y == 0 ||
               eB.x == 0 ||
               eB.y == 0 ||
               eA.x == 1 ||
               eA.y == 1 ||
               eB.x == 1 ||
               eB.y == 1
                           ){
               

           }
           
           
               (eA.x == 0 && eB.x == 0) ||
               (eA.x == 1 && eB.x == 1) ||
               (eA.y == 0 && eB.y == 0) ||
               (eA.y == 1 && eB.y == 1)  ){
           */
           
                 
           //Checking if vertex has a point at x=0
           if (b.getEdgeVertexA(m).x == 0 && b.getEdgeVertexB(b.getEdgeNb()).x == 0){
                 
                 
                 line(  b.getEdgeVertexA(0).x*img.width, b.getEdgeVertexA(0).y*img.height, 
                        b.getEdgeVertexA(m).x*img.width, b.getEdgeVertexA(m).y*img.height   );
                 
                 println("////");
                 println("making line (scaled to width and height): ");
                 //println(eA.x, eA.y, eB.x, eB.y);
                 println(  b.getEdgeVertexA(0).x*img.width, b.getEdgeVertexA(0).y*img.height, 
                        b.getEdgeVertexA(m).x*img.width, b.getEdgeVertexA(m).y*img.height   );
                 
                 println("////");
           }
           
           //Checking if vertex has a point at y=0
           if (b.getEdgeVertexA(m).y == 0 && b.getEdgeVertexB(b.getEdgeNb()).y == 0){
             
             line(  b.getEdgeVertexA(0).x*img.width, b.getEdgeVertexA(0).y*img.height, 
                        b.getEdgeVertexA(m).x*img.width, b.getEdgeVertexA(m).y*img.height   );
                 
                 println("////");
                 println("making line (scaled to width and height): ");
                 //println(eA.x, eA.y, eB.x, eB.y);
                 println(  b.getEdgeVertexA(0).x*img.width, b.getEdgeVertexA(0).y*img.height, 
                        b.getEdgeVertexA(m).x*img.width, b.getEdgeVertexA(m).y*img.height   );
                 
                 println("////");
                 
           }
           
           
           ////////////
  
        }
        
        //In this version, the blobs are stored in the array by level group, i.e: 4,5,6,2,3,1
        //rings.add(n,new Ring(String.valueOf(rings.size()+1), (int) i+1, (double) b.x*100, (double) b.y*100));
  
        //In this version, blobs are appended to the end of the array: 1,2,3,4,5,6...
        rings.add(new Ring(String.valueOf(rings.size()+1), (int) i, (double) b.x*100, (double) b.y*100));
        //println(b.id, b.w, b.h);
        }
    }
  }
}