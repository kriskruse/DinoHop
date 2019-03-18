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

int groundHeight = 100;  //Jord linjens højde fra bunden af frame
int playerXpos = 150;    //spillers placering fra venstre væg
int score = 0;           //Score spilleren har opnået

int obstacleTimer = 0;
int minimumTimeBetweenObstacles = 60;
int randomAddition = 0;
int groundCounter = 0;
float speed = 10;

float Birdcount = 0.15;  //bestemmer hvor mange procent er fugle. 1 = 100%


ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bird> birds = new ArrayList<Bird>();
ArrayList<Ground> grounds = new ArrayList<Ground>();

Boolean noFly = false; 

//------------Variable slut-------------------------------------


//------------Setup, Køre en gang-------------------------------

void setup(){
    //----canvas indstillinger
  frameRate(60);
  size(1000,400);
  

  
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
  
  
  
  //------font og andet
  font = loadFont("Arial.vlw");
  textFont(font,32);
  player = new Player();

  
  

  

}

//------------Setup, slut---------------------------------------


//------------Draw, køre hele tiden-----------------------------

void draw(){
  score = frameCount;
  smooth();
  drawToScreen();
  player.show();
  player.move();
  updateObstacles();
  
  text(obstacles.size(),300,100);
  text(birds.size(),400,100);
  text("Score:",100,100);
  text(score,200,100);
  //println(player.velY);
  fill(0);
  //println(frameCount);
 
  //println(score);
  player.update();
  //println(noFly );

  //---------Høj hop forsøg
  //if (noFly == true && player.posY == 0){
  //  noFly = false;
  //}

}

//------------Draw, slut----------------------------------------

//------------Input---------------------------------------------
void keyPressed(){

  switch(key){
    case ' ':          //Funktion for tryk på 'Space'/'mellemrum' key på keyboard
    player.jump(false);
    //--------------forsøg på højt hop
      //if (player.posY > 0 && player.posY < 80 && noFly == false){
      //  player.jump(true);
      //  noFly = true;
      //}else{
      //  player.jump(false);
      //}      
      break;
      
     case 'w':        //Funktion for tryk på w key på keyboard
     player.jump(false);
     //-------forsøg på højt hop
      //if (player.posY > 0 && player.posY < 16 && noFly == false){
      //  player.jump(true);
      //  noFly = true;
      //}else{
      //  player.jump(false);
      //}      
      break;
     
    case 'b':         //Funktion for tryk på b key på keyboard
      exit();
      break;
  } 
  if (key == 's'){    //Funktion for tryk på s key på keyboard
    player.ducking(true);
  }else {
  player.ducking(false);
  }
}
//------------Input slut----------------------------------------

//------------tegn på skærm-------------------------------------

void drawToScreen(){
  background(255);      //Baggrund overskrivet til hvid 
  stroke(0);
  strokeWeight(2);
  line(0, height - groundHeight - 5, width, height - groundHeight - 5);


} 

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//opdatere forhændringerne hvert frame
void updateObstacles() {
  obstacleTimer ++;
  speed += 0.002;
  if (obstacleTimer > minimumTimeBetweenObstacles + randomAddition) { //Hvis obstacle timer er høj nok tilføj en ny obstacle
    addObstacle();
  }
  groundCounter ++;
  if (groundCounter> 5) { //Hvert 10 frames tilføj en ground bit
    groundCounter =0;
    grounds.add(new Ground());
  }

  moveObstacles();    //Flyt alting til venstre
  showObstacles();
}



//---------------------------------------------------------------------------------------------------------------------------------------------------------
//Bevæg alt til venstre baseret på hastigheden af spillet 
void moveObstacles() {
  println(speed);
  for (int i = 0; i< obstacles.size(); i++) {
    obstacles.get(i).move(speed);
    if (obstacles.get(i).posX < -playerXpos) { 
      obstacles.remove(i);
      i--;
    }
  }

  for (int i = 0; i< birds.size(); i++) {
    birds.get(i).move(speed);
    if (birds.get(i).posX < -playerXpos) {
      birds.remove(i);
      i--;
    }
  }
  for (int i = 0; i < grounds.size(); i++) {
    grounds.get(i).move(speed);
    if (grounds.get(i).posX < -playerXpos) {
      grounds.remove(i);
      i--;
    }
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------
//Tilføjer en forhændring til banen 
void addObstacle() {
  int lifespan = score;
  int tempInt;
  if (lifespan > 1000 && random(1) < Birdcount) { 
    tempInt = floor(random(3));
    Bird temp = new Bird(tempInt);//floor(random(3)));
    birds.add(temp);
  } else {//otherwise add a cactus
    tempInt = floor(random(3));
    Obstacle temp = new Obstacle(tempInt);//floor(random(3)));
    obstacles.add(temp);
    tempInt+=3;
  }

  randomAddition = floor(random(50));
  obstacleTimer = 0;
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//Hviser Fohændringer
void showObstacles() {
  for (int i = 0; i< grounds.size(); i++) {
    grounds.get(i).show();
  }
  for (int i = 0; i< obstacles.size(); i++) {
    obstacles.get(i).show();
  }

  for (int i = 0; i< birds.size(); i++) {
    birds.get(i).show();
  }
}


//-------------------------------------------------------------------------------------------------------------------------------------------
//Resetter banen når dinoen rammer en forhændring
void resetObstacles() {
  obstacles = new ArrayList<Obstacle>();
  birds = new ArrayList<Bird>();
  obstacleTimer = 0;
  randomAddition = 0;
  groundCounter = 0;
  speed = 10;
  frameCount = 0;
  score = 0;
}
