import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DinoHop extends PApplet {

PFont font;
Player player;
SaveSys savesys = new SaveSys();
Menu Menu = new Menu();

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

float Birdcount = 0.15f;  //bestemmer hvor mange procent er fugle. 1 = 100%


ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Bird> birds = new ArrayList<Bird>();
ArrayList<Ground> grounds = new ArrayList<Ground>();

Boolean noFly = false; 

Boolean menu = true;

//------------Variable slut-------------------------------------


//------------Setup, Køre en gang-------------------------------

public void setup(){
  //----canvas indstillinger
  frameRate(60);
  
  
  //-----DATA load test
  savesys.CheckForFile();
  savesys.LoadFile();  //Loader highscoren fra sidst

   
  
  
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

public void draw(){
  
  if (menu) {
    Menu.MenuSide();
    
    
  }else{
  
  score = frameCount/2;
  smooth();
  drawToScreen();
  player.show();
  player.move();
  updateObstacles();
  
  text(obstacles.size(),300,100);
  text(birds.size(),400,100);
  text("Score:",100,100);
  text(score,200,100);
  text(savesys.HighScore, 700,100);
 
  fill(0);
  
 
 
  player.update();
  
  }
}

//------------Draw, slut----------------------------------------

//------------Input---------------------------------------------
public void keyPressed(){

  switch(key){
    case ' ':          //Funktion for tryk på 'Space'/'mellemrum' key på keyboard   
    player.jump(false); 
      break;
      
     case 'w':        //Funktion for tryk på w key på keyboard
     player.jump(false);  
      break;
      
     case 'g':        //lukker for menuen
     if (menu){
       menu = false;
       frameCount = 0;
       score = 0;
       
     }
     
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

public void drawToScreen(){
  background(255);      //Baggrund overskrevet til hvid 
  stroke(0);
  strokeWeight(2);
  line(0, height - groundHeight - 5, width, height - groundHeight - 5);


} 

//---------------------------------------------------------------------------------------------------------------------------------------------------------
//opdatere forhændringerne hvert frame
public void updateObstacles() {
  obstacleTimer ++;
  speed += 0.002f;
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
public void moveObstacles() {
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
public void addObstacle() {
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
public void showObstacles() {
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
public void resetObstacles() {
  obstacles = new ArrayList<Obstacle>();
  birds = new ArrayList<Bird>();
  obstacleTimer = 0;
  randomAddition = 0;
  groundCounter = 0;
  speed = 10;
  savesys.SaveFile(score);
  frameCount = 0;
  score = 0;
  menu = true;
}
class Bird {
  float w = 60;
  float h = 50;
  float posX;
  float posY;
  int flapCount = 0;
  int typeOfBird;
//------------------------------------------------------------------------------------------------------------------------------------------------------
 //constructor
  Bird(int type) {
    posX = width;
    typeOfBird = type;
    switch(type) {
    case 0://flying low
      posY = 10 + h/2;
      break;
    case 1://flying middle
      posY = h;
      break;
    case 2://flying high
      posY = h*2;
      break;
    }
  }
//------------------------------------------------------------------------------------------------------------------------------------------------------
  //show the birf
  public void show() {
    flapCount++;
    
    if (flapCount < 0) {//flap the berd
      image(bird,posX-bird.width/2,height - groundHeight - (posY + bird.height-20));
    } else {
      image(bird1,posX-bird1.width/2,height - groundHeight - (posY + bird1.height-20));
    }
    if(flapCount > 15){
     flapCount = -15; 
      
    }
  }
//------------------------------------------------------------------------------------------------------------------------------------------------------
  //move the bard
  public void move(float speed) {
    posX -= speed;
  }
//------------------------------------------------------------------------------------------------------------------------------------------------------
  //returns whether or not the bird collides with the player
  public boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {

    float playerLeft = playerX - playerWidth/2;
    float playerRight = playerX + playerWidth/2;
    float thisLeft = posX - w/2 ;
    float thisRight = posX + w/2;

    if ((playerLeft<= thisRight && playerRight >= thisLeft ) || (thisLeft <= playerRight && thisRight >= playerLeft)) {
      float playerUp = playerY + playerHeight/2;
      float playerDown = playerY - playerHeight/2;
      float thisUp = posY + h/2;
      float thisDown = posY - h/2;
      if (playerDown <= thisUp && playerUp >= thisDown) {
        return true;
      }
    }
    return false;
  }
}

//Viser små prikker på jorden
class Ground{
  float posX = width;
  float posY = height -floor(random(groundHeight - 20,groundHeight));
  int w = floor(random(1,5));
  
  Ground(){}
 
  public void show(){
    stroke(0);
    strokeWeight(2);
    line(posX,posY, posX + w, posY);

  }
  public void move(float speed) {
    posX -= speed;
  } 
}


class Menu{
  SaveSys savesys = new SaveSys();
  Menu(){}
 
public void MenuSide(){
  
  //Load highscore array fra fil og sorter, sotere for at være sikker på rækkefølge
  String[] load = loadStrings("data/highscore.txt");
  int[] x = PApplet.parseInt(load);   
  x = sort(x);  //sætter x[0] som den mindste og resten i rækkefølge derefter 
  println("done");
  
  
  
  smooth();
  background(255);      //Baggrund overskrevet til hvid 
  stroke(0);
  strokeWeight(2);
  
  //Venstre side af canvas
  textSize(40);
  text("This is the place to be",50,50);
  textSize(35);
  text("Highscore:",50,150);
  text(x[9],235,150);
  textSize(25);
  text("Press g to try again",50,300);
  
  
  
  
  //SCORES på højre side af canvas
  textSize(35);
  line(550, 0, 550, height);
  text("Score:",560,50);
  
  
  text("2:",675,100);
  text(x[8],710,100);
  line(650,110,900,110);
  
  //Venstre side har alle ulige tal
  text("3:",575,170);
  text(x[7],610,170);
  
  text("5:",575,220);
  text(x[5],610,220);
  
  text("7:",575,270);
  text(x[3],610,270);
  
  text("9:",575,320);
  text(x[1],610,320);
  
  //Højre side har lige tal 
  text("4:",800,170);
  text(x[6],835,170);
  
  text("6:",800,220);
  text(x[4],835,220);
  
  text("8:",800,270);
  text(x[2],835,270);
  
  text("10:",782,320);
  text(x[0],835,320);
  
  
  fill(0);


  }
}
class Obstacle {
  float posX;
  int w ;
  int h ;
  int type; 
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor
  Obstacle(int t) {
    posX = width;
    type = t;
    switch(type) {
    case 0://small cactus
      w = 40;
      h = 40;
      break;
    case 1://big cactus
      w = 60;
      h = 60;
      break;
    case 2://small cacti
      w = 100;
      h = 40;
      break;
    }
  }

  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //show the cactus
  public void show() {
    fill(0);
    rectMode(CENTER);
    switch(type) {
    case 0:
      image(smallCactus, posX - smallCactus.width/2, height - groundHeight - smallCactus.height);
      break;
    case 1:
      image(bigCactus, posX - bigCactus.width/2, height - groundHeight - bigCactus.height);
      break;
    case 2:
      image(manySmallCactus, posX - manySmallCactus.width/2, height - groundHeight - manySmallCactus.height);
      break;
    }
  }
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  // move the obstacle
  public void move(float speed) {
    posX -= speed;
  }
  //------------------------------------------------------------------------------------------------------------------------------------------------------
  //returns whether or not the player collides with this obstacle
  public boolean collided(float playerX, float playerY, float playerWidth, float playerHeight) {

    float playerLeft = playerX - playerWidth/2;
    float playerRight = playerX + playerWidth/2;
    float thisLeft = posX - w/2 ;
    float thisRight = posX + w/2;

    if ((playerLeft <= thisRight && playerRight >= thisLeft ) || (thisLeft <= playerRight && thisRight >= playerLeft)) {
      float playerDown = playerY - playerHeight/2;
      float thisUp = h;
      if (playerDown <= thisUp) {
        return true;
      }
    }
    return false;
  }
}

class Player {
  float posY = 0;
  float velY = 0;
  float gravity = 0.5f;
  
  Boolean dead = false;
  Boolean duck = false;
  int runCount = -5;
  
  int size = 20;
  Player(){
  }
 
   public void show() {
     
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
   runCount++;
   if (runCount > 5){
     runCount = -5;
   }
  }
 
 //----------Dinos bevægelser og tyngdekraftens påvirkning-------------
 public void move(){
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
        if (obstacles.get(i).collided(playerXpos, posY + dinoRun1.height/2, dinoRun1.width*0.5f, dinoRun1.height)) {
          resetObstacles();
        }
      }

      for (int i = 0; i< birds.size(); i++) {
        if (duck && posY ==0) {
          if (birds.get(i).collided(playerXpos, posY + dinoDuck.height/2, dinoDuck.width*0.8f, dinoDuck.height)) {
            resetObstacles();
          }
        }
      }
 }
 //----------bukker sig
   public void ducking(boolean isDucking) {
    if (posY != 0 && isDucking) {
      gravity = 3;
    }else {
    gravity = 0.5f;
    }
    duck = isDucking;   
  }
 
 //---------hopper
   public void jump(boolean bigJump) {
    if (player.posY == 0){
    gravity = 1;
    velY = 9;
    }
     //---------forsøg på højt hop
    // if (player.posY >= 0 && player.posY < 80 && noFly == false) {
    //  if (bigJump) {
    //    gravity = 1;
    //    velY = 15;
    //    noFly = true;
    //  } else {
    //    gravity = 1.2;
    //    velY = 9;
    //  }
    //}
  }
 
 
 
 public void update(){
 
 
 }
 
 
 
}
class SaveSys{
  int HighScore = 0;
  SaveSys(){
  }
  
  
  public void CheckForFile(){
   //Tjek om gem fil eksistere, hvis ikke lav en dummy fil
    String path = dataPath("highscore.txt");
    File f = new File(path);  
    if (f.exists() == false){
      println("no exist");
      int[] x = {0,0,0,0,0,0,0,0,0,0};
      String[] i = str(x);
      saveStrings("/data/highscore.txt", i);
    }
  }
  
  public void LoadFile(){
    //Load highscore array fra fil og sorter, sotere for at være sikker på rækkefølge
    String[] load = loadStrings("data/highscore.txt");
    int[] x = PApplet.parseInt(load);   
    x = sort(x);  //sætter x[0] som den mindste og resten i rækkefølge derefter
    HighScore = x[9];
    println("done");
  }
  
  
  public void SaveFile(int Score){
    //Load highscore array fra fil og sorter, sotere for at være sikker på rækkefølge
    String[] load = loadStrings("data/highscore.txt");
    int[] x = PApplet.parseInt(load);   
    x = sort(x);  //sætter x[0] som den mindste og resten i rækkefølge derefter
    
    //Overskriver den mindste highscore værdi med den nye og sortere værdierne igen
    if (Score > x[0]){
      x[0] = Score;
      x = sort(x);
      println(x);
      
      //Convetere array af int til et array af string og gemmer dataen til fil
      String[] savethis = str(x);  
      saveStrings("/data/highscore.txt", savethis);
      HighScore = x[9];
      
      
      
      
    }
  }
}
  public void settings() {  size(1000,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DinoHop" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
