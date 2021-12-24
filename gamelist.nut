fe.load_module("shuffle");

fe.layout.width=800;
fe.layout.height=600;
local flx = fe.layout.width; 
local fly = fe.layout.height; 
local flw = fe.layout.width; 
local flh = fe.layout.height;









//font size
local font_size =20;
local alpha0 = 0;
local alpha = 255;


 local set_sel_rgb= (255,243, 20); 
//font color
local R = 230;
local G = 230;
local B = 230;
local space = 20; 

//alpha
local alpf =  2000;
///////////
//fe.load_module("objects/scrollingtext");
fe.do_nut( fe.script_dir + "scriptmod/objects/scrollingtext.nut");

ScrollingText.debug = false;



local scroller1 = ScrollingText.add( "[Title]", flx*0.110, fly*0.090, flw*0.435 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller1.set_bg_rgb(200, 0, 200);
    scroller1.set_rgb( 255,210,0 );
    scroller1.text.charsize = font_size;
	scroller1.text.alpha = alpha;
////
local scroller2 = ScrollingText.add( "[Title]", flx*0.135, fly*0.175, flw*0.430 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller2.set_bg_rgb(200, 0, 200);
    scroller2.set_rgb( 255,210,0 );
    scroller2.text.charsize = font_size;
	scroller2.text.alpha = alpha;
////
local scroller3 = ScrollingText.add( "[Title]", flx*0.142, fly*0.265, flw*0.435 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller3.set_bg_rgb(200, 0, 200);
    scroller3.set_rgb( 255,210,0 );
    scroller3.text.charsize = font_size;
	scroller3.text.alpha = alpha;
////
local scroller4 = ScrollingText.add( "[Title]", flx*0.152, fly*0.35, flw*0.430 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller4.set_bg_rgb(200, 0, 200);
    scroller4.set_rgb( 255,210,0 );
    scroller4.text.charsize = font_size;
	scroller4.text.alpha = alpha;
////
local scroller5 = ScrollingText.add( "[Title]", flx*0.16, fly*0.44, flw*0.430 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller5.set_bg_rgb(200, 0, 200);
    scroller5.set_rgb( 255,210,0 );
    scroller5.text.charsize = font_size;
	scroller5.text.alpha = alpha;
////
local scroller6 = ScrollingText.add( "[Title]", flx*0.154, fly*0.53, flw*0.430 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller6.set_bg_rgb(200, 0, 200);
    scroller6.set_rgb( 255,210,0 );
    scroller6.text.charsize = font_size;
	scroller6.text.alpha = alpha;
////
local scroller7 = ScrollingText.add( "[Title]", flx*0.144, fly*0.617, flw*0.430 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller7.set_bg_rgb(200, 0, 200);
    scroller7.set_rgb( 255,210,0 );
    scroller7.text.charsize = font_size;
	scroller7.text.alpha = alpha;
////
local scroller8 = ScrollingText.add( "[Title]", flx*0.135, fly*0.7, flw*0.430 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller8.set_bg_rgb(200, 0, 200);
    scroller8.set_rgb( 255,210,0 );
    scroller8.text.charsize = font_size;
	scroller8.text.alpha = alpha;
////
local scroller9 = ScrollingText.add( "[Title]", flx*0.112, fly*0.79, flw*0.433 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller9.set_bg_rgb(200, 0, 200);
    scroller9.set_rgb( 255,210,0 );
    scroller9.text.charsize = font_size;
	scroller9.text.alpha = alpha;
////
local scroller10 = ScrollingText.add( "[Title]", flx*0.098, fly*0.875, flw*0.430 - flh*0.080, 70, ScrollType.HORIZONTAL_LEFT );
    scroller10.set_bg_rgb(200, 0, 200);
    scroller10.set_rgb( 255,210,0 );
    scroller10.text.charsize = font_size;
	scroller10.text.alpha = alpha;
////



//////
/////////
class ShufflePowb extends Shuffle
 {
	
        function select(slot) 
 {
	slot.visible = false;
 
	}
	
	function deselect(slot) 
 {
	slot.visible = true;
	}

}
//local powb = ShufflePowb(10, "image", "");




//local powb = ShufflePowb(10, "image", "art/barras/b/1.png");
//powb.slots[0].set_pos(90,90, 596, 60);


local powb = ShufflePowb(10, "image""art/barras/b/2.png");
powb.slots[0].set_pos(flx*0.067, fly*0.117, flw*0.44, flh*0.08);

local powb = ShufflePowb(10, "image""art/barras/b/3.png");
powb.slots[1].set_pos(flx*0.082, fly*0.202, flw*0.44, flh*0.08);

local powb = ShufflePowb(10, "image""art/barras/b/4.png");
powb.slots[2].set_pos(flx*0.092, fly*0.291, flw*0.44, flh*0.08);

 local powb = ShufflePowb(10, "image""art/barras/b/5.png");
powb.slots[3].set_pos(flx*0.100, fly*0.377, flw*0.44, flh*0.08);

 
local powb = ShufflePowb(10, "image""art/barras/b/6.png");
powb.slots[4].set_pos(flx*0.109, fly*0.467, flw*0.43, flh*0.084);
 
 
  
local powb = ShufflePowb(10, "image""art/barras/b/7.png");
powb.slots[5].set_pos(flx*0.105, fly*0.554, flw*0.435, flh*0.08);
 

local powb = ShufflePowb(10, "image""art/barras/b/8.png");
powb.slots[6].set_pos(flx*0.097, fly*0.640, flw*0.435, flh*0.08);
 
local powb = ShufflePowb(10, "image""art/barras/b/9.png");
powb.slots[7].set_pos(flx*0.085, fly*0.728, flw*0.438, flh*0.08);
  
local powb = ShufflePowb(10, "image""art/barras/b/0.png");
powb.slots[8].set_pos(flx*0.065, fly*0.817, flw*0.445, flh*0.08);
  

 local powb = ShufflePowb(10, "image""art/barras/b/0.png");
powb.slots[9].set_pos(flx*0.036, fly*0.904, flw*0.448, flh*0.08);

//powb.slots[0].zorder = 110;
//powb.slots[1].zorder = 110;
//powb.slots[2].zorder = 110;
//powb.slots[3].zorder = 110;
//powb.slots[4].zorder = 110;
//powb.slots[5].zorder = 110;
//powb.slots[6].zorder = 110;
//powb.slots[7].zorder = 110;
//powb.slots[8].zorder = 110;
//powb.slots[9].zorder = 110;



//fe.load_module( "animate" );
fe.do_nut(fe.script_dir + "scriptmod/modules/animate.nut"); 

////////


class ShufflePow extends Shuffle
 {
	
        function select(slot) 
 {
	slot.visible = true;
	//slot.zorder = 15; //

	}
	
	function deselect(slot) 
 {
	slot.visible = false;
//slot.zorder = 15;	
	}

}


local pow = ShufflePow(10, "image""art/barras/2.png");
pow.slots[0].set_pos(flx*0.068.5, fly*0.117, flw*0.432, flh*0.07);

local pow = ShufflePow(10, "image""art/barras/3.png");
pow.slots[1].set_pos(flx*0.086, fly*0.202, flw*0.430, flh*0.07);

local pow = ShufflePow(10, "image""art/barras/4.png");
pow.slots[2].set_pos(flx*0.098, fly*0.291, flw*0.428, flh*0.07);

 local pow = ShufflePow(10, "image""art/barras/5.png");
pow.slots[3].set_pos(flx*0.106, fly*0.377, flw*0.424, flh*0.07);

 
local pow = ShufflePow(10, "image""art/barras/6.png");
pow.slots[4].set_pos(flx*0.109, fly*0.467, flw*0.423, flh*0.07);
 
 
  
local pow = ShufflePow(10, "image""art/barras/7.png");
pow.slots[5].set_pos(flx*0.107, fly*0.554, flw*0.422, flh*0.07);
 

local pow = ShufflePow(10, "image""art/barras/8.png");
pow.slots[6].set_pos(flx*0.099, fly*0.640, flw*0.424, flh*0.07);
 
local pow = ShufflePow(10, "image""art/barras/9.png");
pow.slots[7].set_pos(flx*0.086, fly*0.730, flw*0.428, flh*0.07);
  
local pow = ShufflePow(10, "image""art/barras/10.png");
pow.slots[8].set_pos(flx*0.068, fly*0.817, flw*0.430, flh*0.07);
  

 local pow = ShufflePow(10, "image""art/barras/10.png");
pow.slots[9].set_pos(flx*0.043, fly*0.904, flw*0.432, flh*0.07);


//pow.slots[0].alpha= 150;
//pow.slots[1].alpha= 150;
//pow.slots[2].alpha= 150;
//pow.slots[3].alpha= 150;
//pow.slots[4].alpha= 150;
//pow.slots[5].alpha= 150;
//pow.slots[6].alpha= 150;
//pow.slots[7].alpha= 150;
//pow.slots[8].alpha= 150;
//pow.slots[9].alpha= 150;



//local move_transition1 = {
//when = Transition.ToNewSelection, 
//property = "alpha", 
//start = 250,	
//end = 0, 
////delay = 6800,
//tween = Tween.Linear, 
//time = 1000}
//animation.add( PropertyAnimation( pow.slots[0], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[1], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[2], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[3], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[4], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[5], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[6], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[7], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[8], move_transition1 ) );
//animation.add( PropertyAnimation( pow.slots[9], move_transition1 ) );







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



local pow = ShufflePow(10, "image", "art/barras/boll.gif");
pow.slots[0].set_pos(flx*0.010 fly*0.128, flw*0.05, flh*0.05);
pow.slots[1].set_pos(flx*0.025, fly*0.210, flw*0.05, flh*0.05);
pow.slots[2].set_pos(flx*0.035, fly*0.295, flw*0.05, flh*0.05);
pow.slots[3].set_pos(flx*0.043, fly*0.385, flw*0.05, flh*0.05);
pow.slots[4].set_pos(flx*0.053, fly*0.476, flw*0.05, flh*0.05);
pow.slots[5].set_pos(flx*0.047, fly*0.560, flw*0.05, flh*0.05);
pow.slots[6].set_pos(flx*0.040, fly*0.644, flw*0.05, flh*0.05);
pow.slots[7].set_pos(flx*0.030, fly*0.735, flw*0.05, flh*0.05);
pow.slots[8].set_pos(flx*0.010, fly*0.820, flw*0.05, flh*0.05);
pow.slots[9].set_pos(flx*-0.010, fly*0.910, flw*0.05, flh*0.05);





class Shuffle extends Shuffle {
	// Overwrite the select function
	function select(slot) {
		//slot.style = Style.Bold;
		//slot.set_rgb (255,210,0);
		slot.visible = false;
	
		
	}
	
	// Overwrite the deselect function
	function deselect(slot) {
		//slot.style = Style.Regular;
		//slot.set_rgb (230,230,230);
		slot.visible = true;
		
	}
}

//===================================================================================

//////////
local list = Shuffle(10, "text", " [Title]");


list.slots[0].set_pos(space + flx*0.070, fly*0.110, flw*0.392, flh*0.080);
list.slots[0].set_rgb (R,G,B);///set_sel_rgb
list.slots[0].font ="tahomabd";
list.slots[0].charsize = font_size;
list.slots[0].alpha = alpf;
list.slots[0].align = Align.Left;
 
 
list.slots[1].set_pos(space + flx*0.090, fly*0.194, flw*0.382, flh*0.080);
list.slots[1].set_rgb (R,G,B);
list.slots[1].font ="tahomabd";
list.slots[1].charsize = font_size;
list.slots[1].alpha = alpf;
list.slots[1].align = Align.Left;

list.slots[2].set_pos(space + flx*0.100, fly*0.285, flw*0.382, flh*0.080);
list.slots[2].set_rgb (R,G,B);
list.slots[2].font ="tahomabd";
list.slots[2].charsize = font_size;
list.slots[2].alpha = alpf;
list.slots[2].align = Align.Left;


list.slots[3].set_pos(space + flx*0.110, fly*0.368, flw*0.382, flh*0.080);
list.slots[3].set_rgb (R,G,B);
list.slots[3].font ="tahomabd";
list.slots[3].charsize = font_size;
list.slots[3].alpha = alpf;
list.slots[3].align = Align.Left;


list.slots[4].set_pos(space + flx*0.116, fly*0.460, flw*0.382, flh*0.080);
list.slots[4].set_rgb (R,G,B);
list.slots[4].font ="tahomabd";
list.slots[4].charsize = font_size;
list.slots[4].alpha = alpf;
list.slots[4].align = Align.Left;


list.slots[5].set_pos(space + flx*0.113, fly*0.548, flw*0.382, flh*0.080);
list.slots[5].set_rgb (R,G,B);
list.slots[5].font ="tahomabd";
list.slots[5].charsize = font_size;
list.slots[5].alpha = alpf;
list.slots[5].align = Align.Left;


list.slots[6].set_pos(space + flx*0.105, fly*0.635, flw*0.382, flh*0.080);
list.slots[6].set_rgb (R,G,B);
list.slots[6].font ="tahomabd";
list.slots[6].charsize = font_size;
list.slots[6].alpha = alpf;
list.slots[6].align = Align.Left;


list.slots[7].set_pos(space + flx*0.090, fly*0.720, flw*0.382, flh*0.080);
list.slots[7].set_rgb (R,G,B);
list.slots[7].font ="tahomabd";
list.slots[7].charsize = font_size;
list.slots[7].alpha = alpf;
list.slots[7].align = Align.Left;


list.slots[8].set_pos(space + flx*0.070, fly*0.810, flw*0.382, flh*0.080);
list.slots[8].set_rgb (R,G,B);
list.slots[8].font ="tahomabd";
list.slots[8].charsize = font_size;
list.slots[8].alpha = alpf;
list.slots[8].align = Align.Left;


list.slots[9].set_pos(space + flx*0.055, fly*0.895, flw*0.382, flh*0.080);
list.slots[9].set_rgb (R,G,B);
list.slots[9].font ="tahomabd";
list.slots[9].charsize = font_size;
list.slots[9].alpha = alpf;
list.slots[9].align = Align.Left;

//==================================================================sombra



function fade_transitions( ttype, var, ttime ) {

 	switch ( ttype ) {
  case Transition.ToNewSelection:
  case Transition.ToNewList:
	local Wheelclick = fe.add_sound("art/click.wav")
	      Wheelclick.playing=true
		
		
  break;
  }
 return false;
}

fe.add_transition_callback( "fade_transitions" );
 


















  