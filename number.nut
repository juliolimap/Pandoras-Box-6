fe.load_module("shuffle");

fe.layout.width=800;
fe.layout.height=600;
local flx = fe.layout.width; 
local fly = fe.layout.height; 
local flw = fe.layout.width; 
local flh = fe.layout.height;

 

//font size
local font_size =20;

 local set_sel_rgb= (255,243, 20); 
//font color
local R = 0;
local G = 172;
local B = 238;
 

//alpha
local alpf =  2000;

class ShufflePow extends Shuffle
 {
	
        function select(slot) 
 {
	slot.visible = true;
	}
	
	function deselect(slot) 
 {
	slot.visible = false;
	}

}
 



class Shuffle extends Shuffle {
	// Overwrite the select function
	function select(slot) {
		//slot.style = Style.Bold;
		slot.set_rgb (0,172,238);
		
	}
	
	// Overwrite the deselect function
	function deselect(slot) {
		//slot.style = Style.Regular;
		slot.set_rgb (0,172,238);
		 
	}
}

//===================================================================================
local list = Shuffle(10, "text", "[ListEntry] ");


list.slots[0].set_pos(flx*0.070, fly*0.110, flw*0.392, flh*0.080);
list.slots[0].set_rgb (R,G,B);///set_sel_rgb
list.slots[0].font ="tahomabd";
list.slots[0].charsize = font_size;
list.slots[0].alpha = alpf;
list.slots[0].align = Align.Left;
 
 
list.slots[1].set_pos(flx*0.090, fly*0.194, flw*0.382, flh*0.080);
list.slots[1].set_rgb (R,G,B);
list.slots[1].font ="tahomabd";
list.slots[1].charsize = font_size;
list.slots[1].alpha = alpf;
list.slots[1].align = Align.Left;

list.slots[2].set_pos(flx*0.100, fly*0.285, flw*0.382, flh*0.080);
list.slots[2].set_rgb (R,G,B);
list.slots[2].font ="tahomabd";
list.slots[2].charsize = font_size;
list.slots[2].alpha = alpf;
list.slots[2].align = Align.Left;


list.slots[3].set_pos(flx*0.110, fly*0.368, flw*0.382, flh*0.080);
list.slots[3].set_rgb (R,G,B);
list.slots[3].font ="tahomabd";
list.slots[3].charsize = font_size;
list.slots[3].alpha = alpf;
list.slots[3].align = Align.Left;


list.slots[4].set_pos(flx*0.116, fly*0.460, flw*0.382, flh*0.080);
list.slots[4].set_rgb (R,G,B);
list.slots[4].font ="tahomabd";
list.slots[4].charsize = font_size;
list.slots[4].alpha = alpf;
list.slots[4].align = Align.Left;


list.slots[5].set_pos(flx*0.113, fly*0.548, flw*0.382, flh*0.080);
list.slots[5].set_rgb (R,G,B);
list.slots[5].font ="tahomabd";
list.slots[5].charsize = font_size;
list.slots[5].alpha = alpf;
list.slots[5].align = Align.Left;


list.slots[6].set_pos(flx*0.105, fly*0.635, flw*0.382, flh*0.080);
list.slots[6].set_rgb (R,G,B);
list.slots[6].font ="tahomabd";
list.slots[6].charsize = font_size;
list.slots[6].alpha = alpf;
list.slots[6].align = Align.Left;


list.slots[7].set_pos(flx*0.090, fly*0.720, flw*0.382, flh*0.080);
list.slots[7].set_rgb (R,G,B);
list.slots[7].font ="tahomabd";
list.slots[7].charsize = font_size;
list.slots[7].alpha = alpf;
list.slots[7].align = Align.Left;


list.slots[8].set_pos(flx*0.070, fly*0.810, flw*0.382, flh*0.080);
list.slots[8].set_rgb (R,G,B);
list.slots[8].font ="tahomabd";
list.slots[8].charsize = font_size;
list.slots[8].alpha = alpf;
list.slots[8].align = Align.Left;


list.slots[9].set_pos(flx*0.055, fly*0.895, flw*0.382, flh*0.080);
list.slots[9].set_rgb (R,G,B);
list.slots[9].font ="tahomabd";
list.slots[9].charsize = font_size;
list.slots[9].alpha = alpf;
list.slots[9].align = Align.Left;

//==================================================================sombra
  