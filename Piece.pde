//TODO: return array of colors

class Piece {
  public int d = 4;
  public int w = 10;
  public int h = 10;
  private int x; //x pos
  private int y; //y pos
  private int[] colors = new int[3]; //red, green, blue
  private boolean falling; //if falling, set to true
  private boolean nextGo; //once stopped falling, the next one can go.
  public boolean [][] rects = new boolean[d][d];

  //initialize piece 
  Piece() {
    //get x, which is a multiple of 10, and y
    this.x = ((int) random(20, width-20))/w * w;
    this.y = 0;

    //set falling to true
    this.falling = true;

    //set nextGo to false
    this.nextGo = false;

    //generate random number to determine color
    float c = random(0, 3);

    //set to red
    if (c < 1) {
      colors[0] = 255;
      colors[1] = 0;
      colors[2] = 0;
    } else if (c >= 1 && c<=2) {
      //set to green
      colors[0] = 0;
      colors[1] = 255;
      colors[2] = 0;
    } else {
      //set to blue
      colors[0] = 0;
      colors[1] = 0;
      colors[2] = 255;
    }

    //initialize all rects to false
    for (int i = 0; i < d; i++) {
      for (int j = 0; j < d; j++) {
        this.rects[i][j] = false;
      }
    }

    //based off random number, determine which shape it will take
    float rand = random(0, 7);
    if (rand < 1) {
      //create straight piece
      for (int j = 0; j < 4; j++) {
        this.rects[0][j] = true;
      }
    } else if (rand >=1 && rand < 2) {
      //create square
      for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
          this.rects[i][j] = true;
        }
      }
    } else if (rand >=2 && rand < 3) {
      //create l shape left
      this.rects[0][0] = true;
      for (int j = 0; j < 3; j++) {
        this.rects[j][1] = true;
      }
    } else if (rand >=3 && rand < 4) {
      //create l shape right
      this.rects[2][0] = true;
      for (int j = 0; j < 3; j++) {
        this.rects[j][1] = true;
      }
    } else if (rand >=4 && rand < 5) {
      //flipped z
      this.rects[1][0] = true;
      this.rects[2][0] = true;
      this.rects[0][1] = true;
      this.rects[1][1] = true;
    } else if (rand >= 5 && rand < 6) {
      // z
      this.rects[0][0] = true;
      this.rects[1][0] = true;
      this.rects[1][1] = true;
      this.rects[2][1] = true;
    } else {
      //don't know how to explain this one piece
      this.rects[1][0] = true;
      for (int j = 0; j < 3; j++) {
        this.rects[j][1] = true;
      }
    }
  }

  //rotate the piece
  void rotatePiece() {
    //translate
    for(int i = 0; i < d; i++){
      for(int j=0; j < i; j++){
        boolean temp = rects[i][j];
        rects[i][j] = rects[j][i];
        rects[j][i] = temp;
      }
    }
    //reverse
    for(int i = 0; i < d/2; i++){
      for(int j = 0; j < d; j++){
        boolean temp = rects[d-1-i][j];
        rects[d-1-i][j] = rects[i][j];
        rects[i][j] = temp;
      }
    }
    
    //if off the board, move back
    if(moveRight() == false){
      this.x = board.w - (d*w);
    }
  }
  
  //move down
  void moveDown(){
    this.y += 10;
  }

  //move piece to the left, unless hitting screen
  boolean moveLeft() {

    for (int i = 0; i < d; i++) {
      for (int j = 0; j < d; j++) {
        //if any piece at end of screen, set falling to false
        if (this.rects[i][j] == true && (this.x + i*w) <= 0) {
          //stop moving
          return false;
        }
      }
    }
    this.x -= w;
    return true;
  }

  //move piece to the right, unless hitting screen
  boolean moveRight() { 

    for (int i = 0; i < d; i++) {
      for (int j = 0; j < d; j++) {
        //if any piece at end of screen, set falling to false
        if (this.rects[i][j] == true && (this.x + (i+1)*w) >= board.getW()) {
          //stop moving
          return false;
        }
      }
    }
    this.x += w;
    return true;
  }

  //returns true if the piece is falling. returns false if it has touched the bottome or another piece
  boolean checkFalling() {
    //get board dimenisions in terms of squares, not coordinates
    int boardW = board.getW()/w;
    int boardH = board.getH()/h;

    for (int i = 0; i < d; i++) {
      for (int j = 0; j < d; j++) {
        //if any piece at end of screen, set falling to false
        if (this.rects[i][j] == true) {
          if ((this.y + j*h) >= board.getH()-10) {
            return false;
          }

          //if piece touches another piece
          for (int m = 0; m < boardW; m++) {
            for (int n = 0; n <boardH; n++) {
              if (board.grid[m][n].getOn() == true) {
                //y check
                if (this.y + (j+1)*h >= board.grid[m][n].getY() && this.y + (j+1)*h <= board.grid[m][n].getY()+h) {
                  //x check
                  if (this.x + (i)*w >= board.grid[m][n].getX() && this.x + (i+1)*w <= board.grid[m][n].getX() + w) {
                    return false;
                  }
                }
              }
            }
          }
        }
      }
    }

    return true;
  }

  //getter
  boolean getNextGo() {
    return nextGo;
  }

  //getter 
  boolean getFalling() {
    return falling;
  }

  //getter
  int[] getColors() {
    return this.colors;
  }

  //getter
  int getX() {
    return this.x;
  }

  //getter
  int getY() {
    return this.y;
  }

  //draw that piece
  void drawPiece() {
    fill(colors[0], colors[1], colors[2]);
    for (int i = 0; i < d; i++) {
      for (int j = 0; j < d; j++) {
        if (this.rects[i][j] == true) {
          rect(this.x + i*w, this.y + j*h, w, h);
        }
      }
    }
  }

  void update() {
    //check falling
    falling = checkFalling();

    //if falling, keep changing y and draw piece
    if (falling == true) {

      //decrement y position
      this.y+=h;

      //draw piece
      drawPiece();
    } else {

      //if done falling, tell the next one to go
      this.nextGo = true;
    }
  }
}