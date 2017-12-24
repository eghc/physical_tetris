//TODO: create method for percent of height of board filled 

class Board {
  private int w = width;
  private int h = height;
  private int pieceD = 10;
  private ArrayList<Piece> pieces = new ArrayList<Piece>();
  public boardPiece [][] grid = new boardPiece[w/pieceD][h/pieceD];
  public int score;

  Board() {
    score = 0;

    for (int i = 0; i < w/pieceD; i++) {
      for (int j = 0; j < h/pieceD; j++) {
        grid[i][j] = new boardPiece();
      }
    }

    pieces.add(new Piece());
  }

  //getter
  int getH() {
    return h;
  }

  //getter
  int getW() {
    return w;
  }

  //return current piece
  Piece getCurr() {
    return pieces.get(pieces.size()-1);
  }

  //only draw pieces if they are on the board
  void drawBoard() {
    for (int i = 0; i < w/pieceD; i++) {
      for (int j = 0; j < h/pieceD; j++) {
        if (grid[i][j].getOn() == true) {
          int[] c = grid[i][j].getColors();
          fill(c[0],c[1],c[2]);
          rect(grid[i][j].getX(), grid[i][j].getY(), pieceD, pieceD);
        }
      }
    }
  }

  //update pieces
  void updatePieces() {
    //go through array list and update each piece
    for (int i = 0; i < pieces.size(); i++) {
      if (pieces.get(i).getFalling() == true) {
        pieces.get(i).update();
      }
    }

    //if the previous piece's nextGo is true
    if (getCurr().getNextGo() == true) {

      //draw last curr piece to board
      for (int i = 0; i < getCurr().d; i++) {
        for (int j = 0; j < getCurr().d; j++) {
          if (getCurr().rects[i][j] == true) {
            grid[getCurr().getX()/pieceD + i][getCurr().getY()/pieceD + j].setPiece(getCurr().getX() + i*pieceD, getCurr().getY() + j*pieceD, getCurr().getColors());
          }
        }
      }

      //remove pieces from array list
      pieces.remove(pieces.size()-1);

      //generate a new piece
      pieces.add(new Piece());
    }
  }

  //check if a row is filled
  void checkRows() {
    for (int j = 0; j < h/pieceD; j++) {
      boolean doneRow = true;

      for (int i= 0; i < w/pieceD; i++) {
        if (grid[i][j].getOn() == false) {
          doneRow = false;
          break;
        }
      }

      if (doneRow == true) {
        //increament score
        score++;

        //remove row
        for (int i= 0; i < w/pieceD; i++) {
          grid[i][j].setOff();
        }

        //shift previous rows down
        for (int n = j; n >= 0; n--) {
          for (int m = 0; m < w/pieceD; m++) {
            //set all the top row to off
            if (n == 0) {
              grid[m][n].setOff();
            } else {
              //if the one above is on, change the current on to on and to the proper colors
              if(grid[m][n-1].getOn() == true){
                grid[m][n].setOn();
                grid[m][n].setColors(grid[m][n-1].getColors());
              }else{
                grid[m][n].setOff();
              }
            }
          }
        }

        //break
        break;
      }
    }
  }

  void update() {

    //updatePieces
    updatePieces();

    //check rows
    checkRows();

    //draw board
    drawBoard();
  }
}