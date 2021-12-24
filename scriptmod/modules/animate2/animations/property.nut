class PropertyAnimation extends Animation {
    supported = [ "x", "y", "width", "height", "origin_x", "origin_y", "scale", "rotation", "rgb", "red", "green", "blue", "bg_red", "bg_green", "bg_blue", "sel_red", "sel_green", "sel_blue", "sel_alpha", "selbg_red", "selbg_green", "selbg_blue", "selbg_alpha", "alpha", "skew_x", "skew_y", "pinch_x", "pinch_y", "subimg_x", "subimg_y", "charsize", "zorder" ];
    scale = 1.0;
    unique_keys = null;

    function defaults(params) {
        base.defaults(params);
        //set some additional default values
        opts = merge_opts({
            key = null,
            center_scale = false,
            center_rotation = false
        }, opts);
        return this;
    }

    function target( ref ) {
        base.target( ref );
        //store objects origin values
        state( "origin", collect_state(ref) );
        states["origin"].scale <- 1.0;
        return this;
    }

    function key( key ) { opts.key <- key; return this; }
    function center_rotation(bool = true) { opts.center_rotation = bool; return this; }
    function center_scale(bool = true) { opts.center_scale = bool; return this; }

    function start() {
        if ( opts.from == null && opts.to == null ) {
            print("you didn't specify a from or to value");
            return;
        }

        //save target states
        states["current"] <- collect_state( opts.target );
        state( "start", clone(states["current"]) );
        
        //evaluate states["from"] and states["to"] from opts.from and opts.to
        foreach( i, val in [ "from", "to" ]) {
            if ( opts[val] == null ) {
                //use default state
                states[val] <- states[opts.default_state];
            } else if ( typeof( opts[val] ) == "string" && opts[val] in states ) {
                //use requested state
                states[val] <- states[ opts[val] ];
            } else if ( typeof( opts[val] ) == "table" ) {
                //use provided table
                states[val] <- opts[val];
            } else {
                //generate a table using opts.key as key, opts.from/to as val
                states[val] <- {}
                states[val][opts.key] <- opts[val];
            }
        }

        //ensure all keys are accounted for
        foreach( key, val in states["to"] )
            if ( supported.find(key) != null )
                states["from"][key] <- ( key in states["from"] ) ? states["from"][key] : ( opts.default_state in states ) ? states[opts.default_state][key] : states["current"][key];
        foreach( key, val in states["from"] )
            if ( supported.find(key) != null )
                states["to"][key] <- ( key in states["to"] ) ? states["to"][key] : ( opts.default_state in states ) ? states[opts.default_state][key] : states["current"][key];
        
        //store a table of unique keys we are animating
        unique_keys = {}
        foreach ( key, val in states["from"] )
            if ( supported.find(key) != null )
                if ( states["from"][key] != states["to"][key] ) unique_keys[key] <- "";

        base.start();
    }

    function update() {
        foreach( key, val in states["to"] ) {
            if ( key == "scale" ) {
                local s = opts.interpolator.interpolate(_from[key], _to[key], progress);
                set_scale(s);
            } else if ( key == "rgb" ) {
                opts.target.set_rgb(
                    opts.interpolator.interpolate(_from[key][0], _to[key][0], progress),
                    opts.interpolator.interpolate(_from[key][1], _to[key][1], progress),
                    opts.interpolator.interpolate(_from[key][2], _to[key][2], progress)
                )
                if ( _from[key].len() > 3 && _to[key].len() > 3 )
                    opts.interpolator.interpolate(_from[key][3], _to[key][3], progress)
            } else if ( supported.find(key) != null ) {
                opts.target[key] = opts.interpolator.interpolate(_from[key], _to[key], progress);
                if ( key == "rotation" ) set_rotation(opts.target[key]);
            }
        }

        states["current"] <- collect_state(opts.target);
        base.update();

        if ( debug ) {
            //during debug, print out values as they are animated
            foreach( key, val in unique_keys )
                unique_keys[key] <- states["current"][key];
            print( "\t" + table_as_string(unique_keys));
        }
    }
    
    //collect supported key values in a state from target
    function collect_state(target) {
        if ( target == null ) return;
        local state = {}
        for ( local i = 0; i < supported.len(); i++)
            try {
                if ( supported[i] == "rgb" ) {
                    state[supported[i]] <- [ target.red, target.green, target.blue, target.alpha ];
                } else {
                    state[supported[i]] <- target[supported[i]];
                }
            } catch(e) {}
        state.scale <- 1;
        return state;
    }

    //set target centered rotation
    function set_rotation( r ) {
        if ( opts.center_rotation ) {
            opts.target.x = states["origin"].x + ( ( states["origin"].width * scale ) / 2 );
            opts.target.y = states["origin"].y + ( ( states["origin"].height * scale ) / 2 );
            opts.target.origin_x = ( states["origin"].width * scale ) - ( states["origin"].width / 2 ) ;
            opts.target.origin_y = ( states["origin"].height * scale ) - ( states["origin"].height / 2 );
        }
    }

    //set target scale
    function set_scale( s ) {
        scale = s;
        opts.target.width = states["origin"].width * s;
        opts.target.height = states["origin"].height * s;
        if ( opts.center_scale ) {
            //auto center scale
            //local offsetX = ( opts.target.width - states["origin"].width ) / 2;
            //local offsetY = ( opts.target.height - states["origin"].height ) / 2;
            opts.target.origin_x = ( opts.target.width / 2 ) / 2;
            opts.target.origin_y = ( opts.target.height / 2 ) / 2;
        } else {
            //scale origin
            opts.target.origin_x = states["origin"].origin_x * s;
            opts.target.origin_y = states["origin"].origin_y * s;
        }
        states["current"].scale <- scale;
    }
}