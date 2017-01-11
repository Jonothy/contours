public class Ring {
  String id;
  int lvl;
  double x;
  double y;
  
  public Ring(String idINI, int lvlINI, double xINI, double yINI){
    id = idINI;
    lvl = lvlINI;
    x = xINI;
    y = yINI;
  }
  
  public String getId(){
    return id;
  }
  
  public int getLvl(){
    return lvl;
  }
  
  public double getX(){
    return x;
  }
  
  public double getY(){
    return y;
  }
  
}