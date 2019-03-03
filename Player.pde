
class Player {
  float posY = 0;
  float velY = 0;
  float gravity = 0.5;
  float speed = 5;
  
  int size = 20;
  Player(){
  }
 
 void show(){
   fill(0);
   rectMode(CENTER);
   rect(SpaceFromWall, GroundLine - 25,25,25);
 }
 
 void move(){
   posY += velY;
   
   if (posY > 0){
     velY += gravity;
     
   }else{
     velY = 0;
     posY = 0;
   }
 }
}
