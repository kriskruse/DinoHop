
class Player {
  float posY = 0;
  float velY = 0;
  float gravity = 0.5;
  
  Boolean dead = false;
  Boolean duck = false;
  int runCount = -5;
  
  int size = 20;
  Player(){
  }
 
   void show() {
     
     //----opdatere sprite, skaber en animation når dino hopper eller dukker---
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
 
 //----------Dinos bevægelser og tyngdekraftens påvirkning-------------
 void move(){
   posY += velY;
   
   if (posY > 0){
     velY -= gravity;
     
   }else{
     velY = 0;
     posY = 0;
   }
   if (keyPressed != true){
     duck = false;
   }
   //-----tjekker for obstacle hits   
      for (int i = 0; i< obstacles.size(); i++) {
        if (obstacles.get(i).collided(playerXpos, posY + dinoRun1.height/2, dinoRun1.width*0.5, dinoRun1.height)) {
          resetObstacles();
        }
      }

      for (int i = 0; i< birds.size(); i++) {
        if (duck && posY ==0) {
          if (birds.get(i).collided(playerXpos, posY + dinoDuck.height/2, dinoDuck.width*0.8, dinoDuck.height)) {
            resetObstacles();
          }
        }
      }
 }
 //----------bukker sig
   void ducking(boolean isDucking) {
    if (posY != 0 && isDucking) {
      gravity = 3;
    }else {
    gravity = 0.5;
    }
    duck = isDucking;   
  }
 
 //---------hopper
   void jump(boolean bigJump) {
    if (player.posY >= 0 && player.posY < 80 && noFly == false) {
      if (bigJump) {
        gravity = 1;
        velY = 15;
        noFly = true;
      } else {
        gravity = 1.2;
        velY = 9;
      }
    }
  }
 
 
 
 void update(){
 
 
 }
 
 
 
}
