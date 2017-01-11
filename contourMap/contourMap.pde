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
float factor = 10;
float elevation = 125;

float colorStart = 0;
float colorRange = 160;

BlobDetection[] contours = new BlobDetection[int(levels)];


//Creating array to store the blob objects
ArrayList<Ring> rings = new ArrayList<Ring>();

void setup() {
  
  size(1000,800,P3D);
  surface.setResizable(true);
  
  img = loadImage("map1.gif");
  surface.setSize(img.width, img.height);
  
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
  
  System.out.println(rings);
  
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
  EdgeVertex eA,eB;
  for (int n=0 ; n<contours[i].getBlobNb() ; n++) {
    b=contours[i].getBlob(n);
    if (b!=null) {
      stroke(250,75,90);
      for (int m=0;m<b.getEdgeNb();m++) {
        eA = b.getEdgeVertexA(m);
        eB = b.getEdgeVertexB(m);
        if (eA !=null && eB !=null)
          line(
          eA.x*img.width, eA.y*img.height, 
          eB.x*img.width, eB.y*img.height 
            );
      //Here I add blob object to the rings array.
      //I am not getting the right data however.
      rings.add(n,new Ring(String.valueOf(b), (int) levels, (double) eA.x*img.width, (double) eB.x*img.height));      
      }
    }
  }
}