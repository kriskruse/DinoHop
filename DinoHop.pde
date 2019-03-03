PFont font;

Player player;

int height = 400;  //skal passe med størrelsen af vinduet
int width = 1000;

float GroundLine = height * 0.8;
float SpaceFromWall = width * 0.08;

void setup(){
  font = loadFont("Arial.vlw");
  textFont(font,32);
  size(1000,400);
  background(255);
  player = new Player();

}

void draw(){
  player.show();
  player.move();
  text(height,300,100);
  text(width,400,100);
  text(GroundLine,500,100);
  text(SpaceFromWall,700,100);
  line(0,GroundLine,width,GroundLine);
  fill(0);
}

void keyPressed(){
  switch(key){
    case ' ':
      player.velY = 10;
  }
}
