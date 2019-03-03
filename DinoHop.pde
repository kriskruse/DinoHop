PFont font;
Player player;

//---------------------Variable---------------------------------

int groundHeight = 100;
int playerXpos = 150;


//------------Variable slut-------------------------------------


//------------Setup, Køre en gang-------------------------------

void setup(){
  
  font = loadFont("Arial.vlw");
  textFont(font,32);
  player = new Player();
  
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
      player.velY = 10;
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
  line(0, height - groundHeight - 30, width, height - groundHeight - 30);


}
