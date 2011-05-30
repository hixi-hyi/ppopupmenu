/*
 * 
Copyright (c) <2011>, <Hiroyoshi Houchi> and <Shigeo Yoshida>
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
The names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;

import processing.core.PApplet;

public class PPopupMenu extends JPopupMenu{
	
	private PApplet target=null;
	/**
        * Creates a new PPopupMenu with the specified applet.
        * PApplet target - the PApplet to use display
	*/
        public PPopupMenu(PApplet target) {
		this.target=target;
	}
	public void show(MouseEvent event){
		show(event.getComponent(), event.getX(), event.getY());
	}

	/**
        * Displays the popup menu at the position x,y. 
        * int x - the x coordinate in target(ctor) coordinate space at which the popup menu is to be displayed
        * int y - the y coordinate in target(ctor) coordinate space at which the popup menu is to be displayed
        **/
	public void show(int x, int y){
		show(target, x, y);
	}
        /**
        * Displays the popup menu at the position x,y in the coordinate space of the mouse. 
        **/
        public void show(){
                 show(target, target.mouseX, target.mouseY); 
        }
	
        /**
        * Appends the menu item to the end of this menu.
        * String buttonName - The string for the menu item
        * String methodName - The string for the method
        * Object args - the argument passed to the method
        **/
	public void addMenuItem(final String buttonName, final String methodName, final Object... args) {
		JMenuItem menuItem=new JMenuItem(buttonName);
		menuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {  
				Method method;
				try {
					int length = args.length;
					Class[] c = new Class[length];
					for(int i=0;i<length;i++) {
						c[i] = args[i].getClass();
					}
					method = target.getClass().getMethod(methodName, c);
				} catch (SecurityException exception) {
					throw new RuntimeException(exception);
				} catch (NoSuchMethodException exception) {
					throw new RuntimeException(exception);
				}
				Object ret=null;
				try {
					ret = method.invoke(target, args);
				} catch (IllegalArgumentException exception) {
					throw new RuntimeException(exception);
				} catch (IllegalAccessException exception) {
					throw new RuntimeException(exception);
				} catch (InvocationTargetException exception) {
					throw new RuntimeException(exception);
				}
			}
		});
		add(menuItem);
	}
}
