class SaveSys{
  int HighScore = 0;
  SaveSys(){
  }
  
  
  void CheckForFile(){
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
  
  void LoadFile(){
    //Load highscore array fra fil og sorter, sotere for at være sikker på rækkefølge
    String[] load = loadStrings("data/highscore.txt");
    int[] x = int(load);   
    x = sort(x);  //sætter x[0] som den mindste og resten i rækkefølge derefter
    HighScore = x[9];
    println("done");
  }
  
  
  void SaveFile(int Score){
    //Load highscore array fra fil og sorter, sotere for at være sikker på rækkefølge
    String[] load = loadStrings("data/highscore.txt");
    int[] x = int(load);   
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
