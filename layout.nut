///////////////////////////////////////////////////
//
// Attract-Mode Frontend - ResFix plugin
//
///////////////////////////////////////////////////
class UserConfig </ help="This plugin will recreate the Attract-Mode window when returning from a game.  Use this to correct Attract-Mode's display if the game/emulator changes the screen resolution away from what it was previously" /> {

	</ label="Specific Emulators", help="If you list specific emulators here, then the window will only be reset for those specified emulators.  Multiple entries can be separated by a semicolon.  If this is left blank then the window will be reset for every emulator", order=1 />
	emulators="";
};

class ResFix
{
	emu_array = [];

	constructor()
	{
		local my_config = fe.get_config();

		if ( my_config[ "emulators" ].len() > 0 )
			emu_array = split( my_config[ "emulators" ], ";" );

		fe.add_transition_callback( this, "on_transition" );
	}

	function on_transition( ttype, var, ttime )
	{
		if ( ttype == Transition.FromGame )
		{
			if (( emu_array.len() == 0 )
				|| ( emu_array.find(
					fe.game_info( Info.Emulator )
					) != null ))
			{
				fe.signal( "reset_window" );
			}
		}
		return false;
	}
}

fe.plugin[ "ResFix" ] <- ResFix();



fe.layout.width=800;
fe.layout.height=600;
local flx = fe.layout.width; 
local fly = fe.layout.height; 
local flw = fe.layout.width; 
local flh = fe.layout.height;

fe.layout.font="tahomabd.ttf";

local bg = fe.add_image(  "art/systems/mame.png", 0, 0, 800, 600 ); 
bg.zorder = 10;
 


local t = fe.add_artwork( "video", 451, 152, 333, 272 );
t.zorder = 15;

local scan = fe.add_image(  "art/gif.mp4", flx*0.563, fly*0.006, flw*0.438, flh*0.239 );


/*
lode modules
*/

 
 
 
 
 
 
 
 
 
 
 
 


 
fe.do_nut("gamelist.nut"); 
 
fe.do_nut("number.nut");  

  
fe.load_module("animate.nut"); 


	

















// add Free play text    1127, 875, 641, 70 );    
local free = fe.add_text( "[FICHA]",   523, 485, 280, 52);
free.align = Align.Centre
free.set_rgb(0,0,0);
free.font = "tahomabd";
 
	// Pulsatining Aminamtion for the free pulse
			animation.add( PropertyAnimation( free, 
				{   
					property = "alpha",
					tween = Tween.Linear, 
					start =  10,
					end = 255,
					pulse = true,
					time = 1200

				} ) );

				
 // add Free play text    1127, 875, 641, 70 );    
local free = fe.add_text( "[FICHA]",   525, 485, 280, 52 );
free.align = Align.Centre
free.set_rgb(255,210,0);
free.font = "tahomabd";
 // Pulsatining Aminamtion for the free pulse
			animation.add( PropertyAnimation( free, 
				{   
					property = "alpha",
					tween = Tween.Linear, 
					start =  10,
					end = 255,
					pulse = true,
					time = 1200

				} ) );
				
				
				
				 
 
 
local clock = fe.add_text( "[CONTADOR]", 230, 28, 640, 22 );
clock.charsize = 24;
clock.set_rgb( 0, 0, 0 );
clock.alpha = 2000;
clock.font="tahomabd";
clock.align = Align.Left;	
 
local clock = fe.add_text( "[CONTADOR]", 230, 27, 640, 21 );
clock.charsize = 24;
clock.set_rgb( 0,172,238 );
clock.alpha = 2000;
clock.font="tahomabd";
clock.align = Align.Left;	

 
 
local clock = fe.add_text( "Games [ListSize]", 80, 27, 640, 22 );
clock.charsize = 24;
clock.set_rgb( 0, 0, 0  );
clock.alpha = 2000;
clock.font="tahomabd";
clock.align = Align.Left; 
 
local clock = fe.add_text( "Games [ListSize]", 80, 27, 640, 21 );
clock.charsize = 24;
clock.set_rgb( 0,172,238 );
clock.alpha = 2000;
clock.font="tahomabd";
clock.align = Align.Left; 
 
 
 
local bg2 = fe.add_image("/home/arcade/.attract/modules/qr.png", 420, 31, 90, 90 ); 
  










