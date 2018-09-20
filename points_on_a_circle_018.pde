// Circle packing using a method of checking for points of intercetion with 
// existing circles.  
// This method compares a 50 poinnts on the circurframce of the new random circle
// to make sure eac poiint is the same colour


// pallet http://colorbrewer2.org/?type=qualitative&scheme=Set1&n=7


color[] rainbow = {#000000, #66c2a4, #8c96c6, #fd8d3c, #fe9929, #969696, #b2e2e2, #66c2a4, #2ca25f, #006d2c, #edf8fb, #b3cde3, #8c96c6, #8856a7, #810f7c, #ffffb2, #fecc5c, #fd8d3c, #f03b20, #bd0026, #feebe2, #fbb4b9, #f768a1, #c51b8a, #7a0177};

color[] greens = {#edf8fb, #b2e2e2, #66c2a4, #2ca25f, #006d2c};
color[] magentas = {#edf8fb, #b3cde3, #8c96c6, #8856a7, #810f7c};
color[] oranges = {#ffffb2, #fecc5c, #fd8d3c, #f03b20, #bd0026};
color[] purples = {#feebe2, #fbb4b9, #f768a1, #c51b8a, #7a0177};
color[] browns = {#ffffd4, #fed98e, #fe9929, #d95f0e, #993404};
color[] greys = {#f7f7f7, #cccccc, #969696, #636363, #252525};


int sizeOfColourArray = 23;

boolean collision  = false;

color c ;
color firstColour;

double step = 2 * PI/50;  // how many points to test on each new ellipse to see if there is a change in colour eg a collision with another boundary

float h = 300;
float k = 300;

int randX = 0;
int randY = 0;
float randDiameter = 0;
int max = 1000;           // maximum size of ellipse
float shrink = 0.1;     // reduce maximum size of ellipse each loop by this amount
int counter = 0;
int saveCount = 0;

int radius = max;

void setup() {
  background(255);
  size(8800, 8800);
  smooth(8);
  background(rainbow[0]);
  noStroke();
}



void draw() {

  randX = int(random(0, width));
  randY = int(random(0, width));
  randDiameter = random(0, radius);

  if (radius < 10) {
    save("last.png");
    exit();
  }

  // TRUE eg no collision with a boundary of an other ellipse then draw new ellipse 
  if (check(randX, randY, randDiameter)) {

    // get the colour of the central pixel under the location of the new ellipse that we are about to draw
    // find which pallet is comes from and set the random colour to one from it's pallet

    findPallet(randX, randY);

    // fill(rainbow[int(random(1, sizeOfColourArray))]);

    ellipse(randX, randY, randDiameter, randDiameter);
  }

  if (counter == 1000) {
    save("save_" + saveCount + ".png");
    println("saving " + saveCount);
    saveCount ++;
    counter = 0;
  }
  counter ++;
}


// check points around the curcumfrance of the ellipse to see if each point
// is the same colour.  If so we assume that the new ellipse is not overlapping 
// any other ellipse.
// Returns False if there is a change of colour at any of the test points
boolean check(float x, float y, float r) {
  boolean draw = true;  // assume no collision
  for (float theta=0; theta < 2 * PI; theta += step) {
    x = randX + randDiameter /2 * cos(theta);
    y = randY + randDiameter /2 * sin(theta); 
    c = get(int(x), int(y));  // find the colour under each point on the circle

    if (theta == 0) {
      firstColour = c;  // find the colour of the first poinit on the circle for comparison with each other point
    }

    if (c != firstColour) {
      draw = false;  // found a change in colour
    }
  }
  return draw;
}

void mouseClicked() {
  save("save_" + saveCount + ".png");
  println("saving " + saveCount);
  saveCount ++;
}


void findPallet(int x, int y) {
  // get the colour of the central pixel under the location of the new ellipse that we are about to draw
  // find which pallet is comes from and set the random colour to one from it's pallet
  color testColour;
  testColour = get(x, y);
  
  if ( testColour == rainbow[0]) {
    fill(rainbow[int(random(0, sizeOfColourArray))]);
  }

  if ( testColour == (browns[0]) | testColour ==(browns[1]) | testColour == (browns[2]) | testColour ==(browns[3]) | testColour == (browns[4])) {
    fill(browns[int(random(0, 4))]);
  }
  
  if ( testColour == (greens[0]) | testColour == (greens[1]) | testColour == (greens[2]) | testColour == (greens[3]) | testColour == (greens[4])) {
    fill(greens[int(random(0, 4))]);
  }
  
  if ( testColour == (magentas[0]) | testColour == (magentas[1]) | testColour == (magentas[2]) | testColour == (magentas[3]) | testColour == (magentas[4])) {
    fill(magentas[int(random(0, 4))]);
  }
  
  if ( testColour == (oranges[0]) | testColour == (oranges[1]) | testColour == (oranges[2]) | testColour == (oranges[3]) | testColour == (oranges[4])) {
    fill(oranges[int(random(0, 4))]);
  }
  
  if ( testColour == (purples[0]) | testColour == (purples[1]) | testColour == (purples[2]) | testColour == (purples[3]) | testColour == (purples[4])) {
    fill(purples[int(random(0, 4))]);
  }
  
  if ( testColour == (greys[0]) | testColour == (greys[1]) | testColour == (greys[2]) | testColour == (greys[3]) | testColour == (greys[4])) {
    fill(greys[int(random(0, 4))]);
  }
  
}
