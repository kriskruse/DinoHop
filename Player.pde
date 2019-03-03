
class Player {
  float posY = 0;
  float velY = 0;
  float gravity = 1.2;
  
  Boolean duck = false;
  int runCount = -5;
  
  int size = 20;
  Player(){
  }
 
   void show() {
    if (duck && posY == 0) {
      if (runCount < 0) {

        image(dinoDuck, playerXpos - dinoDuck.width/2, height - groundHeight - (posY + dinoDuck.height));
      } else {

        image(dinoDuck1, playerXpos - dinoDuck1.width/2, height - groundHeight - (posY + dinoDuck1.height));
      }
    } else
      if (posY ==0) {
        if (runCount < 0) {
          image(dinoRun1, playerXpos - dinoRun1.width/2, height - groundHeight - (posY + dinoRun1.height));
        } else {
          image(dinoRun2, playerXpos - dinoRun2.width/2, height - groundHeight - (posY + dinoRun2.height));
        }
      } else {
        image(dinoJump, playerXpos - dinoJump.width/2, height - groundHeight - (posY + dinoJump.height));
      }
  }
 
 void move(){
   posY += velY;
   
   if (posY > 0){
     velY -= gravity;
     
   }else{
     velY = 0;
     posY = 0;
   }
 }
 
   void ducking(boolean isDucking) {
    if (posY != 0 && isDucking) {
      gravity = 3;
    }
    duck = isDucking;
  }
 
}
