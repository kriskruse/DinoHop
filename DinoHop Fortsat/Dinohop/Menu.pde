

class Menu{
  SaveSys savesys = new SaveSys();
  Menu(){}
 
void MenuSide(){
  
  //Load highscore array fra fil og sorter, sotere for at være sikker på rækkefølge
  String[] load = loadStrings("data/highscore.txt");
  int[] x = int(load);   
  x = sort(x);  //sætter x[0] som den mindste og resten i rækkefølge derefter 

  //println("done");
  
  
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
