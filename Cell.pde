
class Cell {
  boolean hidden;
  boolean mine;
  boolean flagged = false;
  int x;
  int y;
  int nmines; // amount of neighbour mines
  int fontSize = width/20;
  PImage p_flag;
  PImage p_mine;
  PImage p_hidden;
  PImage p_empty;
  Cell(boolean m, int x_, int y_) {
    hidden = true;
    mine = m;
    x = x_;
    y = y_;
    p_flag = loadImage("pics/flag.png");
    p_mine = loadImage("pics/mine.png");
    p_hidden = loadImage("pics/hidden.png");
    p_empty = loadImage("pics/empty.png");
  }
  void show() {
    if (hidden==false) {
      if (mine) {
        //fill(250, 0, 0);
        image(p_mine, x*(width/fieldSize), y*(height/fieldSize), width/fieldSize, height/fieldSize);
      } else {
        //fill(175, 175, 175);
        image(p_empty, x*(width/fieldSize), y*(height/fieldSize), width/fieldSize, height/fieldSize);
      }
      fill(0);
      textAlign(CENTER);
      textSize(fontSize);
      if (nmines>0) {
        text(nmines, x*(width/fieldSize)+(width/fieldSize/2), y*(height/fieldSize)+(height/fieldSize/2+fontSize/3));
      }
      if (nmines == 0) {
        // top left
        if (x!=0 && y!=0) {
          field[x-1][y-1].hidden = false;
        }

        // top middle
        if (y!=0) {
          field[x][y-1].hidden = false;
        }

        // top right
        if (x!=fieldSize-1 && y!=0) {
          field[x+1][y-1].hidden = false;
        }


        // middle left
        if (x!=0) {
          field[x-1][y].hidden = false;
        }


        // middle right
        if (x!=fieldSize-1) {
          field[x+1][y].hidden = false;
        }

        // bottom left
        if (x!=0 && y!=fieldSize-1) {
          field[x-1][y+1].hidden = false;
        }

        // bottom middle
        if (y!=fieldSize-1) {
          field[x][y+1].hidden = false;
        }

        // bottom right
        if (x!=fieldSize-1 && y!=fieldSize-1) {
          field[x+1][y+1].hidden = false;
        }
      }
    } else {
      if (flagged) {
        //fill(0, 0, 255);
        image(p_flag, x*(width/fieldSize), y*(height/fieldSize), width/fieldSize, height/fieldSize);
      } else {
        image(p_hidden, (x*(width/fieldSize)), y*(height/fieldSize), width/fieldSize, height/fieldSize);
      }
    }
  }


  void countMines() {
    int sum = 0;
    // top left
    if (x!=0 && y!=0) {
      if (field[x-1][y-1].mine) {
        sum++;
      }
    }

    // top middle
    if (y!=0) {
      if (field[x][y-1].mine) {
        sum++;
      }
    }

    // top right
    if (x!=fieldSize-1 && y!=0) {
      if (field[x+1][y-1].mine) {
        sum++;
      }
    }


    // middle left
    if (x!=0) {
      if (field[x-1][y].mine) {
        sum++;
      }
    }


    // middle right
    if (x!=fieldSize-1) {
      if (field[x+1][y].mine) {
        sum++;
      }
    }

    // bottom left
    if (x!=0 && y!=fieldSize-1) {
      if (field[x-1][y+1].mine) {
        sum++;
      }
    }

    // bottom middle
    if (y!=fieldSize-1) {
      if (field[x][y+1].mine) {
        sum++;
      }
    }

    // bottom right
    if (x!=fieldSize-1 && y!=fieldSize-1) {
      if (field[x+1][y+1].mine) {
        sum++;
      }
    }


    nmines = sum;
  }
}
