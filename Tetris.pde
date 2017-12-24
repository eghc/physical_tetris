Board board;

void setup(){
  size(100,400);
  board =  new Board();
  frameRate(5);
  textAlign(CENTER);
}

void draw(){
  background(0);
  board.update();
  fill(255);
  text(board.score, width/2,height/2);
}

void keyPressed(){
  Piece curr = board.getCurr();
  if(keyPressed == true){
    if(keyCode == LEFT && curr.getFalling() == true){
      curr.moveLeft();
    }else if(keyCode == RIGHT && curr.getFalling() == true){
      curr.moveRight();
    }else if(keyCode == DOWN && curr.getFalling() == true){
      //curr.moveDown();
    }else if(key == ' '){
      curr.rotatePiece();
    }
  }
}