
//Viser små prikker på jorden
class Ground{
  float posX = width;
  float posY = height -floor(random(groundHeight - 20,groundHeight));
  int w = floor(random(1,5));
  
  Ground(){}
 
  void show(){
    stroke(0);
    strokeWeight(2);
    line(posX,posY, posX + w, posY);

  }
  void move(float speed) {
    posX -= speed;
  } 
}
