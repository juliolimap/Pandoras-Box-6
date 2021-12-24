/////////////////////////////////////////////////////////
//
// Attract-Mode Frontend - Utils
//
// This program comes with ABSOLUTELY NO WARRANTY.  It is licensed under
// the terms of the GNU General Public License, version 3 or later.
//
// Utils provides useful helper functions for working with strings or making fe operations easier
//
//  Utils.
//      random( min, max )                  get a random integer
//      randomf( min, max )                 get a random float
//      randoma( array )                    get a random entry from an array
//      clamp( val, min, max )              get a clamped value between min and max
//      colors_from( rgba_table )           get a colors table { red, green, blue, alpha } from a color string (#ffffff or 255,255,255,100)
//      int_to_rgb( c )                     get a colors table from an integer
//      rgb_to_hex( r, g, b )               get a hex value from an r, g, b table
//      hex_to_rgba( val )                  get an rgba table from a hex value
//      hex_to_int( val )                   get an integer from a hex value
//      set_props( target, props )          set all properties in props table on target
//      merge_props(a, b)                   merge props b into a
//      register_callback( id, env, func )  register a global callback for the specified event id
//      register_callback( id, func )
//      unregister_callback( id )           unregister a global callback
//      run_callback( id )                  run a global callback
//      find_file( path )                   find out if a file exists
//
////////////////////////////////////////////////////////////////

::Utils <- {
    VERSION = 1.0,
    //math utils
    random = function(min, max) { return floor(((rand() % 1000 ) / 1000.0) * (max - (min - 1)) + min) },
    randomf = function(min, max) { return (((rand() % 1000 ) / 1000.0) * (max - min) + min).tofloat() },
    randoma = function( a ) { if ( typeof(a) != "array" ) return; if ( a.len() > 0 ) return a[random(0, a.len() - 1)]; return null },
    clamp = function(value, min, max) { if (value < min) value = min; if (value > max) value = max; return value; },
    //color utils
    int_to_rgb = function( color ) { return { r = color & 255, b = (color >> 16) & 255, g = (color >> 8) & 255 } },
    rgb_to_hex = function(r, g, b) { return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).tostring(16).slice(1); },
    hex_to_rgba = function( val )
    {
        if( val.slice(0, 1) == "#" ) val = val.slice( 1, val.len() );
        //convert hex code to RGB
        local color = {
            red = hex_to_int( val.slice(0, 2) ),
            green = hex_to_int( val.slice(2, 4) ),
            blue = hex_to_int( val.slice(4, 6) ),
        }
        color.alpha <- ( val.len() > 6 ) ? hex_to_int( val.slice(6, 8) ) : 255;
        return color;
    },
    hex_to_int = function(h)
    {
        //convert hex to integer value
        h = h.toupper();
        local total = 0;
        for ( local i = 0; i < h.len(); i++ )
        {
            // less than 58 = 0-9, greater than = A-F
            local val = ( h[i] < 58 ) ? h[i] - 48 : h[i] - 55;
            local power = h.len() - i - 1;
            total += val * pow(16, power);
        }
        return total;
    },
    colors_from = function( color )
    {
        //translate a color string to a color table
        if ( color.slice(0, 1) == "#" )
        {
            //hex
            color = Utils.hexToRGBA(color);
        } else if ( typeof(color) == "table" )
        {
            //do nothing for now, should check for r,g,b or red,green,blue and alpha
        } else {
            local c = split(color, ",");
            if ( c.len() >= 3 )
            {
                //rgb
                color = { red = c[0].tointeger(), green = c[1].tointeger(), blue = c[2].tointeger() }
                //rgba
                color.alpha <- ( c.len() > 3 ) ? c[3].tointeger() : 255;
            }
        }
        return color;
    },
    //set object properties
    set_props = function(obj, props) {
        foreach( key, val in props )
        try {
            if ( key == "rgb" ) {
                obj.set_rgb(val[0],val[1],val[2]);
                if ( val.len() > 3 ) obj.alpha = val[3];
            } else if ( key == "bg_rgb" ) {
                obj.set_bg_rgb(val[0],val[1],val[2]);
                if ( val.len() > 3 ) obj.bg_alpha = val[3];
            } else if ( key == "sel_rgb" ) {
                obj.set_sel_rgb(val[0],val[1],val[2]);
                if ( val.len() > 3 ) obj.sel_alpha = val[3];
            } else if ( key == "selbg_rgb" ) {
                obj.set_selbg_rgb(val[0],val[1],val[2]);
                if ( val.len() > 3 ) obj.selbg_alpha = val[3];
            } else {
                obj[key] = val;
            }
        } catch(e) { ::print("set_props error,  setting property: " + key + "\n") }
    },
    //utils to register and run global callbacks for an event id
    callbacks = [],
    register_callback = function( id, param1, param2 = null ) {
        local cb = { id = id, env = ( param2 == null ) ? null : param1, func = ( param2 == null ) ? param1 : param2 }
        callbacks.push( cb );
    },
    unregister_callback = function ( id ) {
        for ( local i = 0; i < callbacks.len(); i++ )
            if ( callbacks[i].id == id ) callbacks.remove(i);
    },
    run_callback = function( id, params = {} ) {
        foreach ( cb in callbacks )
        {
            if ( cb.id == id )
            {
                if ( cb.env == null ) cb.func( params ); else cb.env[cb.func]( params );
            }
        }
    },
    //utils for objects
    //updates x/y/w/h location for transformation, rotation and scale from original object
    transform = function(obj, x, y, scale, rotation)
    {
        //we store the original state of the object so we have these values later
        if ( obj in Utils.nv == false )
        {
            //print( "storing object info: " + obj + "\n" );
            Utils.nv[obj] <- {
                x = obj.x,
                y = obj.y,
                width = obj.width,
                height = obj.height,
                mx = x + ( obj.width / 2 ),
                my = y + ( obj.height / 2 ),
                scale = 1.0,
                rotation = 0
            }
        }

        local origin = Utils.nv[obj];

        local newWidth = origin.width * scale;
        local newHeight = origin.height * scale;

        local scaleMidX = origin.x + newWidth / 2;
        local scaleMidY = origin.y + newHeight / 2;

        local radians = rotation * PI / 180.0;
        //move x and y based on center of scaled, rotated object
        local newX = ( origin.x - scaleMidX ) * cos(radians) - ( origin.y - scaleMidY ) * sin(radians) + scaleMidX;
        local newY = ( origin.x - scaleMidX ) * sin(radians) + ( origin.y - scaleMidY ) * cos(radians) + scaleMidY;

        obj.x = newX + ( origin.mx - scaleMidX ) + ( x - origin.x );
        obj.y = newY + ( origin.my - scaleMidY ) + ( y - origin.y );
        obj.width = newWidth;
        obj.height = newHeight;
        obj.rotation = rotation;

        //Utils.nv[obj].mx <- newX + ( obj.width / 2 );
        //Utils.nv[obj].my <- newY + ( obj.height / 2 );
        Utils.nv[obj].scale <- scale;
        Utils.nv[obj].rotation <- rotation;
    },
    anchor = function( src, target, anchor, padding = 0 )
    {
        //TODO anchor an object inside another object
        /*
        if ( target == ::fe ) target = {
            x = 0,
            y = 0,
            width = fe.layout.width,
            height = fe.layout.height
        }
        try
        {
            local anchors = [ "top", "left", "bottom", "right", "mid" ];
            print("anchor request: " + anchor + "\n");
            local vals = split( anchor, " " );
            local result = 0;
            foreach ( v in vals )
            {
                if ( v == "top" ) result += 1;
                if ( v == "bottom" ) result += 2;
                if ( v == "left" ) result += 3;
                if ( v == "right" ) result += 4;
                switch ( result )
                {
                    case 1:
                        //top
                        src.y = target.y;
                        break;
                    case 2:
                        //bottom
                        src.y = target.y + target.height - src.height - padding;
                        break;
                    case 3:
                        //left
                        src.x = target.x + padding;
                        break;
                    case 4:
                        //right
                        src.x = target.x - target.width - padding;
                        break;
                    case 5:
                        //bottom left
                        src.x = target.x + padding;
                        src.y = target.y + target.height - src.height - padding;
                        break;
                    case 6:
                        //bottom right
                        src.x = target.x - target.width - padding;
                        src.y = target.y + target.height - src.height - padding;
                        break;
                    case 7:
                        //left right
                        src.x = target.x + padding;
                        src.width = target.x + target.width - src.x - padding;
                        break;
                }
            }
        } catch ( err ) { print("anchor error: " + err + "\n" ); }
        */
        return src;
    },
    align = function( src, target, align, padding = 0 )
    {
        //TODO align an object next to another object
        if ( "x" in src && "y" in src && "width" in src && "height" in src )
        {
            local alignments = [ "top", "left", "bottom", "right", "mid" ];
            local vals = split( align, " " );
            foreach ( v in vals )
            {

            }
        }
        return src;
    },
    percent = function( val, per, relativeTo = null )
    {
        return ( relativeTo == null ) ? val * per : relativeTo * per;
    },
    //utils to translate or evaluate strings
    translate = function( value )
    {
        //translate is responsible for converting brace enclosed string values into ones AM can recognize:
        //  functions, magic tokens, constants, strings to floats
        /*
        if ( typeof(value) == "string" && value.len() > 4 && value.slice(0, 2) == "[!" && value.slice( value.len() - 1, value.len() ) == "]" )
        {
            local func = value.slice( 2, value.len() - 1);
            ::print("\ttranslate function: " + func + "\n" );
        }
        */

        local translate_map = [
            //Constants
            [ "FeVersion", FeVersion ],
            [ "FeVersionNum", FeVersionNum ],
            [ "FeConfigDirectory", FeConfigDirectory ],
            [ "ScreenWidth", ScreenWidth ],
            [ "ScreenHeight", ScreenHeight ],
            [ "ScreenSaverActive", ScreenSaverActive ],
            [ "OS", OS ],
            [ "ShadersAvailable", ShadersAvailable ],
            //fe.layout
            [ "fe.layout.width", fe.layout.width ],
            [ "fe.layout.height", fe.layout.height ],
            [ "fe.layout.font", fe.layout.font ],
            [ "fe.layout.base_rotation", fe.layout.base_rotation ],
            [ "fe.layout.toggle_rotation", fe.layout.toggle_rotation ],
            [ "fe.layout.page_size", fe.layout.page_size ],
            //fe.list
            [ "fe.list.name", fe.list.name ],
            [ "fe.list.filter_index", fe.list.filter_index ],
            [ "fe.list.index", fe.list.index  ],
            //fe.overlay
            [ "fe.overlay.is_up", fe.overlay.is_up ],
            //fe.filters
            //fe.monitors
            //Transitions
            [ "Transition.StartLayout", Transition.StartLayout ],
            [ "Transition.EndLayout", Transition.EndLayout ],
            [ "Transition.ToNewSelection", Transition.ToNewSelection ],
            [ "Transition.FromOldSelection", Transition.FromOldSelection ],
            [ "Transition.ToGame", Transition.ToGame ],
            [ "Transition.FromGame", Transition.FromGame ],
            [ "Transition.ToNewList", Transition.ToNewList ],
            [ "Transition.EndNavigation", Transition.EndNavigation ],
            //fe.game_info variables (would need transition callback)
            //Align
            [ "Align.Left", Align.Left ],
            [ "Align.Centre", Align.Centre ],
            [ "Align.Right", Align.Right ],
            //Shaders
            [ "Shader.VertexAndFragment", Shader.VertexAndFragment ],
            [ "Shader.Vertex", Shader.Vertex ],
            [ "Shader.Fragment", Shader.Fragment ],
            [ "Shader.Empty", Shader.Empty ],
            //Paths
            [ "fe.script_dir", fe.script_dir ],
            [ "SharedPath", FeConfigDirectory + "shared" ],
            [ "ResourcePath", Utils.ResourcePath() ]
        ];

        //translate object attribute values from translate_map
        local retVal = value;
        if ( typeof( value ) == "string" )
        {
            //handle Bool replacements
            if ( value == "true" ) return true;
            if ( value == "false" ) return false;

            //handle Style.* values
            if ( value.find("Style.") != null )
            {
                //try to total all values
                try
                {
                    local val = 0;
                    if ( value.find("Style.Regular") != null ) val += Style.Regular;
                    if ( value.find("Style.Bold") != null ) val += Style.Bold;
                    if ( value.find("Style.Italic") != null ) val += Style.Italic;
                    if ( value.find("Style.Underlined") != null ) val += Style.Underlined;
                    return val;
                } catch ( e ) { print("couldn't parse Style string: " + value + "\n" ); }
            }

            //handle Vid.* values
            if ( value.find("Vid.") != null )
            {
                try
                {
                    local val = 0;
                    if ( value.find("Vid.Default") != null ) val += Vid.Default;
                    if ( value.find("Vid.ImagesOnly") != null ) val += Vid.ImagesOnly;
                    if ( value.find("Vid.NoAudio") != null ) val += Vid.NoAudio;
                    if ( value.find("Vid.NoAutoStart") != null ) val += Vid.NoAutoStart;
                    if ( value.find("Vid.NoLoop") != null ) val += Vid.NoLoop;
                    return val;
                } catch ( e ) { print("couldn't parse Vid string: " + value + "\n" ); }
            }

            //handle Art.* values
            /*
            if ( value.find("Art.") != null )
            {
                //try to total all values
                try
                {
                    local val = 0;
                    if ( value.find("Art.Default") != null ) val += Art.Default;
                    if ( value.find("Art.ImageOnly") != null ) val += Art.ImageOnly;
                    if ( value.find("Art.IncludeLayout") != null ) val += Art.IncludeLayout;
                    return val;
                } catch ( e ) { print("couldn't parse Art string: " + value + "\n" ); }
            }
            */

            //replace items in the translate map
            foreach( item in translate_map )
            {
                if ( value.find("[" + item[0] + "]") != null ) retVal = Utils.replace( value, "\\[" + item[0] + "\\]", item[1] );
                //if ( value == item[0] ) retVal = item[1];
            }

            //handle String to Int replacemants
            //try to force final value to float
            try
            {
                retVal = retVal.tofloat();
            } catch( e ) { }
        }

        return retVal;
    },
    //utils for paths and files
    ResourcePath = function( basePath = fe.script_dir )
    {
        //WIP
        //look for resource in an aspect specific location
        //need to "fallback" to next best matching aspect
        local aspect = (fe.layout.width / fe.layout.height ).tofloat();
        switch ( aspect )
        {
            case 1.33:
                return basePath + "4x3";
            case 1.66:
                return basePath + "";
            case 1.78:
                if ( fe.layout.width == 1920 ) return basePath + "1080p";
                if ( fe.layout.width == 1280 ) return basePath + "720p";
                if ( fe.layout.width == 1024 ) return basePath + "PAL16x9";
                return basePath + "16x9";
            case 0.75:
                return basePath + "3x4";
            case 0.5625:
                if ( fe.layout.width == 1920 ) return basePath + "1080p-vert";
                if ( fe.layout.width == 1280 ) return basePath + "720p-vert";
            default:
                return basePath;
        }
    },
    find_path = function( filename )
    {
        local hasPath = false;
        local firstPos = -1;
        local lastPos = 0;
        for ( local i = 0; i < filename.len(); i++ )
        {
            if ( filename[i].tochar() == "/" || filename[i].tochar() == "\\" )
            {
                hasPath = true;
                if ( firstPos = -1 ) firstPos = i;
                lastPos = i;
            }
        }
        if ( hasPath )
        {
            local relativePath = filename.slice( 0, lastPos + 1 );
            local filenameOnly = filename.slice( lastPos + 1, filename.len() );
            local f = null;
            try
            {
                //first look relative to script_dir
                //::print( "trying relative path: " + fe.script_dir + relativePath + "\n" );
                f = file( fe.script_dir + relativePath + filenameOnly, "r" );
                return fe.script_dir + relativePath;
            }
            catch ( e )
            {
                //try direct path (in case of full location provided)
                try
                {
                    //::print( "trying direct path: " + relativePath + filenameOnly + "\n" );
                    f = file( relativePath + filenameOnly );
                    return relativePath;
                }
                catch ( e )
                {
                    //just use script_dir
                    //::print( "using script_dir: " + fe.script_dir + "\n" );
                    return fe.script_dir;
                }
            }
        } else
        {
            //just use script_dir
            //::print( "using script_dir: " + fe.script_dir + "\n" );
            return fe.script_dir;
        }
        return 0;
    },
    find_file = function( filename )
    {
        local hasPath = false;
        local firstPos = -1;
        local lastPos = 0;
        //look for slashes to see if we have any path
        for ( local i = 0; i < filename.len(); i++ )
        {
            if ( filename[i].tochar() == "/" || filename[i].tochar() == "\\" )
            {
                hasPath = true;
                if ( firstPos = -1 ) firstPos = i;
                lastPos = i;
            }
        }

        if ( hasPath ) return filename.slice( lastPos + 1, filename.len() );
        return filename;
    },
    //utils for strings
    replace = function(string, original, replacement)
    {
        //allows you to replace text in a string
        local expression = regexp(original);
        local result = "";
        local position = 0;
        local captures = expression.capture(string);
        while (captures != null)
        {
        foreach (i, capture in captures)
        {
          result += string.slice(position, capture.begin);
          result += replacement;
          position = capture.end;
        }
        captures = expression.capture(string, position);
        }
        result += string.slice(position);
        return result;
    },
    evaluate = function( target, property, relativeTo = null )
    {
        //evaluate a string for a value
        //  allow for values relative to current value [-25]
        //  percentage of current value [25%]
        //  math operations ( +, -, /, * ) [25%*4]
        //  functions?

        /*
        Use regex?
        ^([-+/*]\d+(\.\d+)?)*
        Regexr Demo

            ^ - beginning of the string
            [-+/*] - one of these operators
            \d+ - one or more numbers
            (\.\d+)? - an optional dot followed by one or more numbers
            ()* - the whole expression repeated zero or more times
        */

        //find any operator positions in the string
        local EVAL_OPS = [ "+", "-", "/", "*" ];
        local find_operators = function ( string ) { local ops_pos = []; for ( local i = 0; i < string.len(); i++ ) foreach( op in EVAL_OPS ) if ( string[i].tochar() == op ) ops_pos.push(i); return ops_pos; }
        function do_equation( eq )
        {
            ops_pos = find_operators( eq );
            for ( local e = 0; e < ops_pos.len(); e++ )
            {
                lastOp = ( e == 0 ) ? 0 : ops_pos[e - 1];
                nextOp = ( e + 1 >= ops_pos.len() ) ? newvalue.len() : ops_pos[e + 1];
                prev_string = newvalue.slice( lastOp, ops_pos[e] );
                next_string = newvalue.slice( ops_pos[e] + 1, nextOp );
                print("  evaluating: " + prev_string + " " + newvalue[ops_pos[e]].tochar() + " " + next_string + "\n" );
            }
            switch (op)
            {
                case "(":
                    eq = do_operation();
                    break;
                case "*":
                    eq = do_operation();
                    break;
                case "/":
                    eq = do_operation();
                    break;
                case "+":
                    eq = do_operation();
                    break;
                case "-":
                    eq = do_operation();
                    break;
            }
        }
        local newvalue = value;
        print( "attempt to evaluate: " + newvalue + "\n" );
        if ( typeof( value ) == "string" )
        {
            //translate any strings to integers
            if ( property in map_values )
            {
                foreach( state, state_value in map_values[property] )
                {
                    print( "translating: " + property + ": " + state + "\n" );
                    //if percentage, replace with percentage instead

                    newvalue = replace( newvalue, state, state_value );
                }
            }

            local ops_pos = find_operators( value );
            local lastOp = 0;
            local nextOp = 0;
            local op = "";
            local prev_string = "";
            local next_string = "";

            //find positions of any operators in the string
            for ( local i = 0; i < value.len(); i++ )
            {
                foreach( op in EVAL_OPS ) if ( value[i].tochar() == op ) ops_pos.push(i);
            }

            //  evaluate by finding prefix of op and suffix of op
            //Parentheses, Exponents, Multiplication and Division, and Addition and Subtraction
            //Parentheses outrank exponents, which outrank multiplication and division (but multiplication and division are at the same rank), and these two outrank addition and subtraction (which are together on the bottom rank). When you have a bunch of operations of the same rank, you just operate from left to right.
            /*
            for ( local t = 0; t < ops_pos.len(); t++ )
            {
                op = value[ops_pos[t]].tochar();
                lastOp = ( t == 0 ) ? 0 : ops_pos[t - 1];
                prev_string = value.slice( lastOp, ops_pos[t] );
                print( "attempt to translate: " + prev_string + " for property " + property + "\n" );
                if ( property in map_values && prev_string in map_values[property] )
                {
                    newvalue = replace( value, prev_string, map_values[property][prev_string] );
                }
            }
            */

            //try to evaluate, if error return unmodified value ( with warning )
            print( "attempt to evaluate: " + newvalue + "\n" );
            do_equation( newvalue );

        }
        return newvalue;
    },
    //get a squirrel table as a string
    table_as_string = function ( table )
    {
        if ( table == null ) return "";
        local str = "";
        foreach ( name, value in table )
        {
            if ( typeof(value) == "table" )
            {
                str += "[" + name + "] -> ";
                str += table_as_string( value );
            } else
            {
                str += name + ": " + value + " ";
            }
        }
        return str;
    },
    //print a squirrel table
    print_table = function( table )
    {
        ::print( table_as_string( table ) );
    },
    transition_to_text = function( ttype ) {
        switch (ttype) {
            case 0:
                return "StartLayout";
            case 1:
                return "EndLayout";
            case 2:
                return "ToNewSelection";
            case 3:
                return "FromOldSelection";
            case 4:
                return "ToGame";
            case 5:
                return "FromGame";
            case 6:
                return "ToNewList";
            case 7:
                return "EndNavigation";
            case 100:
                return "OnDemand";
            case 101:
                return "Always";
        }
    },
    //utils for other fe functions
    add_config = function( name, label, help, options = null, order = null )
    {
        //add config option to layout
        UserConfig[name] <- "";
        local cfg = {
            label = label,
            help = help,
        }
        if ( options != null ) cfg.options <- options;
        if ( order != null) cfg.order <- order;

        UserConfig.setattributes( name, cfg );
        //set default value?
        //UserConfig[name] <- ( name in user_config && user_config[name] != "" ) ? user_config[name] : defaultValue;
    },
    find_file = function(path) {
        try
        {
            file( path, "r" );
            return true;
        }
        catch ( e ) { return false; }
    },
    //merge one table into another ( 2nd table will overwrite any existing keys )
    merge_props = function(a, b) {
        foreach( key, value in b ) {
            if ( typeof(b[key]) == "table" )
                a[key] <- merge_props(a[key], b[key]);
            else
                a[key] <- b[key];
        }
        return a;
    }
}
