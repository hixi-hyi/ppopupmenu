/**
  Requirement
  You need to add Picking.jar.
  (http://code.google.com/p/processing-picking-library/)
  
  You need to add NyAR4psg.jar and NyARToolkit.jar.
  You need to put camera_para.dat and patt.hiro into "data" folder.
  (http://nyatla.jp/nyartoolkit/wiki/index.php?NyAR4psg)
*/
import processing.video.*;
import processing.core.*;
import jp.nyatla.nyar4psg.*;
import processing.opengl.*;
import picking.*;

Capture cam=null;
MultiMarker nya=null;

int r=255;
int g=255;
int b=255;

Picker picker=null;

PPopupMenu menu=null;

void setup(){
  size(640, 480, P3D);
  colorMode(RGB, 100);
  
  nya=new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro", 80);
  
  cam=new Capture(this, 640, 480);
  picker=new Picker(this);
  menu=new PPopupMenu(this);
  
  menu.addMenuItem("red", "changeBoxColorRed");
  menu.addMenuItem("green", "changeBoxColorGreen");
  menu.addMenuItem("blue", "changeBoxColorBlue");
  menu.addMenuItem("yellow", "changeBoxColorYellow");
  menu.addMenuItem("purple", "changeBoxColorPurple");
  menu.addMenuItem("cyan", "changeBoxColorCyan");
}

void draw(){
  if(cam.available()!=true)
    return;
  
  cam.read();
  nya.detect(cam);
  hint(DISABLE_DEPTH_TEST);
  image(cam, 0, 0);
  hint(ENABLE_DEPTH_TEST);
  
  if(!nya.isExistMarker(0))
    return;
  
  picker.start(0);
  nya.beginTransform(0);
  fill(r, g, b);
  translate(0, 0, 20);
  box(40);
  nya.endTransform();
}

void mouseClicked(){
  if(mouseButton==RIGHT){
    int id=picker.get(mouseX, mouseY);
    switch(id){
      case 0:
        menu.show();
        break;
    }
  }else{
    r=255;
    g=255;
    b=255;
  }
}

  
void changeBoxColorRed(){
  r=255;
  g=0;
  b=0;
}
void changeBoxColorGreen(){
  r=0;
  g=255;
  b=0;
}
void changeBoxColorBlue(){
  r=0;
  g=0;
  b=255;
}
void changeBoxColorYellow(){
  r=255;
  g=255;
  b=0;
}
void changeBoxColorPurple(){
  r=255;
  g=0;
  b=255;
}
void changeBoxColorCyan(){
  r=0;
  g=255;
  b=255;
}
