class boardPiece{
  private boolean on;
  private int[] colors = new int[3];
  private int x;
  private int y;
  
  //initialize boardPiece
  boardPiece(){
    this.on = false;
  }
  
  void setPiece(int tempx, int tempy, int[] tempc){
    this.on = true;
    this.x = tempx;
    this.y = tempy;
    this.colors = tempc;
  }
  
  void setOff(){
    this.on = false;
  }
  
  void setOn(){
    this.on = true;
  }
  
  void setColors(int[] tempc){
    this.colors = tempc;
  }
  
  boolean getOn(){
    return this.on;
  }
  
  int getX(){
    return this.x;
  }
  
  int getY(){
    return this.y;
  }
  
  int[] getColors(){
    return this.colors;
  }
}