# contours

INTRODUCTION

The goal of this project is to go from a height map to a contour map, and to then cut each contour with the laser cutter to make landscape maquettes.


CURRENT PROGRESS

1. Starting with a height map (jpg, png, gif), we make a contour map of it in Processing.

2. We need to "isolate" each contour, that is, all contours should be stored as objects in an array, with the following properties (add more if you thing there is a need):

	- x and y coordinates of leftmost point of the blob
	- level (heght) of the blob

I created the Ring class with a contructor to make ring objects which would have four properties (String id; int lvl; double x; double y;).
In the drawContours() method, I make an object for each contour however I cannot get the right x,y coordinates and the right level data into those objects.

	--- --- --- --- --- --- --- --- ---
	This is basically where we are now...
	--- --- --- --- --- --- --- --- ---

3. The next step would be to rearrange all blobs on the window. The resulting layout of blobs next to each other, not overlapping, should be exported as SVG.

4. Then, do some minor editing on Illustrator if needed, and then laser cut it.


MORE INFO

I have included the blobDetection library, along with all the code I have worked with so far.
Here is the link to the blobDetection documentation: http://www.v3ga.net/processing/BlobDetection/index-page-documentation.html