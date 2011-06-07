/**
  Requirement
  You need to add Picking.jar.
  (http://code.google.com/p/processing-picking-library/)
*/
import picking.*;

import ppopupmenu.*;

import processing.opengl.*;

Picker picker=null;

PPopupMenu menu1=null;
PPopupMenu menu2=null;
PPopupMenu menu3=null;

float a=0.0f;

void setup(){
  smooth();
  size(200, 200, OPENGL);
  picker=new Picker(this);

  menu1=new PPopupMenu(this);
  menu2=new PPopupMenu(this);
  menu3=new PPopupMenu(this);

  menu1.addMenuItem("menu11", "menu11Func");
  menu1.addSeparator();
  menu1.addMenuItem("menu12", "menu12Func");

  menu2.addMenuItem("menu21", "menu21Func");

  menu3.addMenuItem("menu31", "menu31Func");
}

void draw(){
  background(0);
  lights();
  stroke(0);
  a+=0.01;

  picker.start(0);
  pushMatrix();{
    translate(80, 75);
    rotateX(a); rotateY(a);
    fill(255, 0, 0);
    box(50);
  }popMatrix();

  picker.start(1);
  pushMatrix();{
    translate(140, 75);
    rotateX(a); rotateY(a);
    fill(0, 255, 0);
    box(20);
  }popMatrix();

  picker.stop();
}

void mouseClicked(){
  if(mouseButton==RIGHT){
    //System.out.println("right clicked");
    int id=picker.get(mouseX, mouseY);
    //System.out.println("id: "+id);
    switch(id){
      case 0:
	menu1.show();
        break;
      case 1:
	menu2.show();
        break;
      case 2:
        menu3.show();
        break;
      }
  }else if(mouseButton==LEFT){
    //System.out.println("left clicked");
  }
}

void menu11Func(){
  println("menu11");
}

void menu12Func(){
  println("menu12");
}

void menu21Func(){
  println("menu21");
}

void menu31Func(){
  println("menu31");
}
