import processing.svg.*;

import blobDetection.*;
import peasy.*;
import processing.pdf.*;
PeasyCam cam;

PImage ref;
PImage output;

String filename = "SmallEarth.png";

int blobMaxNb = 1000; 
int blobLinesMaxNb = 10100; 
int blobTrianglesMaxNb = 500;

float levels = 10;
//float factor = 1;      //Scale factor, not used.
//float elevation = 50;  //Not used.

BlobDetection[] contours = new BlobDetection[int(levels)];

//Creating array to store the blob objects
ArrayList<Ring> rings = new ArrayList<Ring>();


void setup() {

  size(480, 360, P3D);
  surface.setResizable(true);

  //ref = loadImage("bkmap_contrast.png");
  ref = loadImage(filename);
  
  // create a copy of reference image with a black border
  output = createImage(ref.width+2, ref.height+2, RGB);
  for(int i=0; i < output.pixels.length; i++){
    output.pixels[i] = color(0);
  }
  
  output.updatePixels();
  output.set(1, 1, ref);
  
  surface.setSize(output.width, output.height);

  cam = new PeasyCam(this, output.width, output.height, 0, 1500);
  colorMode(HSB, 360, 100, 100);

  for (int i=0; i<levels; i++) {
    contours[i] = new BlobDetection(output.width, output.height);
    contours[i].setConstants(blobMaxNb, blobLinesMaxNb, blobTrianglesMaxNb);
    contours[i].setThreshold(i/levels);
    contours[i].computeBlobs(output.pixels);
    println("blobs in level " + i + " : " + contours[i].getBlobNb());
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
    
    beginRecord(SVG, filename+"_level_"+i+".svg");
    
    drawContours(i);
    println("drew level " + i);
    
    println("saved as: " + filename + "_level_"+i+".svg");
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
    if(b.w*width>.01*width && b.h*height>.01*height){
      
      if (b!=null) {
        stroke(250, 75, 90);
  
        for (int m=0; m<b.getEdgeNb(); m++) {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
  
          //This part draws the blobs.
          //This is where we need to modify so that they are no overlaps.
          
          if (eA !=null && eB !=null)
           line(
           eA.x*output.width, eA.y*output.height, 
           eB.x*output.width, eB.y*output.height 
           );
           
           //println("eA.x: " + eA.x);
           //println("eA.y: " + eA.y);
           //println("eB.x: " + eB.x);
           //println("eB.y: " + eB.y);
           //println();
           
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
           
                 
           ////Checking if vertex has a point at x=0
           //if (b.getEdgeVertexA(m).x == 0 && b.getEdgeVertexB(b.getEdgeNb()).x == 0){
                 
                 
           //      line(  b.getEdgeVertexA(0).x*output.width, b.getEdgeVertexA(0).y*output.height, 
           //             b.getEdgeVertexA(m).x*output.width, b.getEdgeVertexA(m).y*output.height   );
                 
           //      println("////");
           //      println("making line (scaled to width and height): ");
           //      //println(eA.x, eA.y, eB.x, eB.y);
           //      println(  b.getEdgeVertexA(0).x*output.width, b.getEdgeVertexA(0).y*output.height, 
           //             b.getEdgeVertexA(m).x*output.width, b.getEdgeVertexA(m).y*output.height   );
                 
           //      println("////");
           //}
           
           //Checking if vertex has a point at y=0
           //if (b.getEdgeVertexA(m).y == 0 && b.getEdgeVertexB(b.getEdgeNb()).y == 0){
             
           //  line(  b.getEdgeVertexA(0).x*output.width, b.getEdgeVertexA(0).y*output.height, 
           //             b.getEdgeVertexA(m).x*output.width, b.getEdgeVertexA(m).y*output.height   );
                 
           //      println("////");
           //      println("making line (scaled to width and height): ");
           //      //println(eA.x, eA.y, eB.x, eB.y);
           //      println(  b.getEdgeVertexA(0).x*output.width, b.getEdgeVertexA(0).y*output.height, 
           //             b.getEdgeVertexA(m).x*output.width, b.getEdgeVertexA(m).y*output.height   );
                 
           //      println("////");
                 
           //}
           
           
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