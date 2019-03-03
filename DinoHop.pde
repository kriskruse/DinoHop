PFont font;
Player player;

//Billeder
PImage dinoRun1;
PImage dinoRun2;
PImage dinoJump;
PImage dinoDuck;
PImage dinoDuck1;
PImage smallCactus;
PImage manySmallCactus;
PImage bigCactus;
PImage bird;
PImage bird1;


//---------------------Variable---------------------------------

int groundHeight = 100;
int playerXpos = 150;


//------------Variable slut-------------------------------------


//------------Setup, Køre en gang-------------------------------

void setup(){
  
  //------Textures
  dinoRun1 = loadImage("dinorun0000.png");
  dinoRun2 = loadImage("dinorun0001.png");
  dinoJump = loadImage("dinoJump0000.png");
  dinoDuck = loadImage("dinoduck0000.png");
  dinoDuck1 = loadImage("dinoduck0001.png");

  smallCactus = loadImage("cactusSmall0000.png");
  bigCactus = loadImage("cactusBig0000.png");
  manySmallCactus = loadImage("cactusSmallMany0000.png");
  bird = loadImage("berd.png");
  bird1 = loadImage("berd2.png");
  
  
  dinoRun1.resize(0,50);
  dinoRun2.resize(0,50);
  dinoJump.resize(0,50);
  dinoDuck.resize(0,50);
  dinoDuck1.resize(0,50);
  
  smallCactus.resize(0,50);
  bigCactus.resize(0,50);
  manySmallCactus.resize(0,50);
  bird.resize(0,50);
  bird1.resize(0,50);
  
  //------font og andet
  font = loadFont("Arial.vlw");
  textFont(font,32);
  player = new Player();
  
  
  //----canvas indstillinger
  frameRate(60);
  size(1000,400);
  

}

//------------Setup, slut---------------------------------------


//------------Draw, køre hele tiden-----------------------------

void draw(){
  

  drawToScreen();
  player.show();
  player.move();
  text(height,300,100);
  text(width,400,100);
  text(groundHeight,500,100);
  fill(0);
  //println(frameCount);
 
  
}

//------------Draw, slut----------------------------------------

//------------Input---------------------------------------------
void keyPressed(){
  switch(key){
    case ' ':
      if (player.posY > 0){
      }else{
        player.velY = 10;
      }      
      println("Space click");
      break;
    case 'b':
      exit();
      break;
  }
}
//------------Input slut----------------------------------------

//------------tegn på skærm-------------------------------------

void drawToScreen(){
  background(255);
  stroke(0);
  strokeWeight(2);
  line(0, height - groundHeight - 5, width, height - groundHeight - 5);


}
