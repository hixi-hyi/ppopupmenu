
PPopupMenu menu=null;

int r=255;
int g=255;
int b=255;

void setup(){
  size(200, 200);
  
  //create popupmenu
  menu=new PPopupMenu(this);
  
  //add menu
  //"menu1Func", "menu2Func" and "menu3Func" are method names you newly need to define in this source code.
  menu.addMenuItem("menu1", "menu1Func");
  menu.addSeparator();
  menu.addMenuItem("menu2", "menu2Func", "menu2 selected"); 
  menu.addMenuItem("menu3", "menu3Func", "menu", 3, "selected");
}

void mouseClicked(){
  if(mouseButton==RIGHT){
    //println("Right clicked!");
    menu.show();
  }else if(mouseButton==LEFT){
    r=255;
    g=255;
    b=255;
  }
}

void draw(){
  background(r, g, b);
}

//you need to add following methods
void menu1Func(){
  println("menu1 selected");
  r=255;
  g=0;
  b=0;
}
void menu2Func(String str){
  //println("menu2");
  println(str);
  r=0;
  g=255;
  b=0;  
}
void menu3Func(String str1, Integer menuId, String str2){
  println(str1+menuId+" "+str2);
  r=0;
  g=0;
  b=255;
}
