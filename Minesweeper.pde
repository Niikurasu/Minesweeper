
/*
 Global variables
 */
public int fieldSize = 9;
Cell[][] field = new Cell[fieldSize][fieldSize];
boolean lost;
float startTime;
float endTime;
int mineAmount;

int screenState; // 0 = startscreen, 1 = gamescreen, 2 = win screen, 3 = lose screen

void setup() {

  size(900, 900); 

  screenState = 0;
  mineAmount = 10;
  restartGame();
}


void draw() {

  if (screenState == 0) { // Start Screen
    background(220);
    textSize(width/21);
    textAlign(CENTER);
    int tx = width/2;
    int ty = height/10*4;
    fill(0);
    text("press r to start the game", tx, ty);
  } else if (screenState == 2) { // Win Screen
    background(220);
    textSize(width/21);
    textAlign(CENTER);
    int tx = width/2;
    int ty = height/10*4;
    int time_x = width/2;
    int time_y = height/3;
    fill(50, 200, 50);
    text("You Won! Press r to start the game", tx, ty);
    fill(0);
    text("Time: " + str(endTime/1000-startTime/1000), time_x, time_y);
  } else if (screenState == 3) { // Lose Screen
    background(220);
    textSize(width/21);
    textAlign(CENTER);
    int tx = width/2;
    int ty = height/10*4;
    fill(200, 50, 50);
    text("You Lost! Press r to start the game", tx, ty);
  } else if (screenState == 1) { // Game Screen
    /*
   Check for Win
     */
    if (checkWin()) {
      endTime = millis();
      screenState = 2;
    }
    if (lost) {
      screenState = 3;
    }

    /*
  Drawings
     */

    for (int x = 0; x < fieldSize; x++) {
      for (int y = 0; y < fieldSize; y++) {
        field[x][y].show();
      }
    }
  }
}


void mousePressed() {
  // mouseButton: 37=left, 39=right
  if (mouseButton == 37) {
    int mx = floor(mouseX/float(width)*fieldSize);
    int my = floor(mouseY/float(height)*fieldSize);
    field[mx][my].hidden = false;
  }
  if (mouseButton == 39) {
    int mx = floor(mouseX/float(width)*fieldSize);
    int my = floor(mouseY/float(height)*fieldSize);
    field[mx][my].flagged = true;
  }
}

void keyPressed() {
  if (key=='r') {
    screenState = 1;
    restartGame();
  }
}


boolean checkWin() {
  boolean win = true;
  for (int x = 0; x < fieldSize; x++) {
    for (int y = 0; y < fieldSize; y++) {
      if (field[x][y].mine == false) {
        if (field[x][y].hidden == true) {
          win = false;
        }
      }

      if (field[x][y].mine && field[x][y].hidden == false) {
        lost = true;
      }
    }
  }
  return win;
}


void restartGame() {
  startTime = millis();
  lost = false;
  // initialize field
  for (int i = 0; i < fieldSize; i++) {
    for (int j = 0; j < fieldSize; j++) {
      field[i][j] = new Cell(false, i, j);
    }
  }
  int placedMines = 0;
  while (placedMines < mineAmount) {
    int rand_x = floor(random(1)*fieldSize);
    int rand_y = floor(random(1)*fieldSize);
    if (field[rand_x][rand_y].mine == false) {
      field[rand_x][rand_y].mine = true;
      placedMines++;
    }
  }
  // count mines
  for (int i = 0; i < fieldSize; i++) {
    for (int j = 0; j < fieldSize; j++) {
      field[i][j].countMines();
    }
  }
}



/*
  TODO:
 Font Size Bug
 Textures
 
 
 */
