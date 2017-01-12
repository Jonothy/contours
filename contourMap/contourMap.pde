import processing.svg.*;

import blobDetection.*;
import peasy.*;
import processing.pdf.*;
PeasyCam cam;

PImage img;

boolean recording = false;

void keyPressed(){
  if (key == 'r' || key == 'R'){
    recording = !recording;
  }
}

float levels = 10;
//float factor = 1;      //Scale factor, not used.
//float elevation = 50;  //Not used.

BlobDetection[] contours = new BlobDetection[int(levels)];

//Creating array to store the blob objects
ArrayList<Ring> rings = new ArrayList<Ring>();


void setup() {
  
  size(480,360,P3D);
  //surface.setResizable(true);
  
  //img = loadImage("maptest.png");
  img = loadImage("map1.gif");
  //surface.setSize(img.width, img.height);
  
  cam = new PeasyCam(this, img.width, img.height, 0, 1500);
  colorMode(HSB, 360, 100, 100);
  
  for (int i=0; i<levels; i++){
    contours[i] = new BlobDetection(img.width, img.height);
    contours[i].setThreshold(i/levels);
    contours[i].computeBlobs(img.pixels);
  }
  
  for (int i = 0; i < rings.size(); i++){
    System.out.println("id: " + rings.get(i).getId());
    System.out.println("lvl: " + rings.get(i).getLvl());
    System.out.println("x: " + rings.get(i).getX());
    System.out.println("y: " + rings.get(i).getY());
    System.out.println();
  }
  
  noLoop();
  
}


void draw(){
  
  background(0);
  if (recording){
    beginRecord(SVG, "frame_####.svg");
  }
  
  for (int i=0; i<levels; i++){
    drawContours(i);
  }
  
  if (recording) {
    endRecord();
  recording = false;
  }
  
  /*
  System.out.println("Number of blobs (rings.size()): " + rings.size());
  println();
  
  for (int i = 0; i < rings.size(); i++){
    System.out.println("id: " + rings.get(i).getId());
    System.out.println("lvl: " + rings.get(i).getLvl());
    System.out.println("x: " + rings.get(i).getX());
    System.out.println("y: " + rings.get(i).getY());
    System.out.println();
  }
  */
  
}



void drawContours(int i) {
  Blob b;
  EdgeVertex eA,eB;
  for (int n=0 ; n<contours[i].getBlobNb() ; n++) {
    b=contours[i].getBlob(n);
    if (b!=null) {
      stroke(250,75,90);
      
      // Initializing displacement variables
      float dispW = img.width;
      float dispH = img.height;
      
      
      for (int m=0;m<b.getEdgeNb();m++) {
        eA = b.getEdgeVertexA(m);
        eB = b.getEdgeVertexB(m);
        
        //This part draws the blobs.
        //This is where we need to modify so that they are no overlaps.
        /*
        if (eA !=null && eB !=null)
          line(
          eA.x*img.width, eA.y*img.height, 
          eB.x*img.width, eB.y*img.height 
            );
        */
        
        //////
        //Needs some work...
        if (eA !=null && eB !=null)
        
        line(
          eA.x*(img.width+dispW), eA.y*(img.height+dispH), 
          eB.x*(img.width+dispW), eB.y*(img.height+dispH) 
            );
            
          dispW += b.w;
          dispH += b.h;
        
      }
      
      //In this version, the blobs are stored in the array by level group, i.e: 4,5,6,2,3,1
      //rings.add(n,new Ring(String.valueOf(rings.size()+1), (int) i+1, (double) b.x*100, (double) b.y*100));
      
      //In this version, blobs are appended to the end of the array: 1,2,3,4,5,6...
      rings.add(new Ring(String.valueOf(rings.size()+1), (int) i+1, (double) b.x*100, (double) b.y*100));
      //println(b.id, b.w, b.h);
    }
  }
}