class SpriteAnimation extends Animation
{
    frameOffset = 0;
    orientations = { "horizontal": 0, "vertical": 1 }
    
    function sprite_frame( num ) { opts.frame = num; frame(opts.frame); return this }
    function sprite_mask( bool ) { opts.mask = bool; return this }
    function sprite_order( o ) { opts.order = o; return this }
    function sprite_orientation( o ) { foreach( key, val in orientations ) if ( o == key ) opts.orientation = orientations[key]; return this }
    function sprite_width( w ) { opts.width = w; return this }
    function sprite_height( h ) { opts.height = h; return this }
    
    function defaults(params) {
        base.defaults(params);
        //set some additional default values
        opts = merge_opts({
            frame = 0,                      //the sprite frame we are on
            order = null,                   //an array of frame indexes to provide an order to play them in
            orientation = "horizontal",     //orientation of our sprite sheet
            mask = true,                    //if true, use fix_masked_image to fix spritesheet transparency
            width = 128,                    //width of frames in the spritesheet
            height = 128                    //height of frames in the spritesheet
        }, opts);
        return this;
    }

    function init() {
        base.init()
        if ( opts.target != null )
        {
            if ( opts.mask ) opts.target.fix_masked_image();
            opts.target.subimg_width = opts.width;
            opts.target.subimg_height = opts.height;
        }
        sprite_frame(opts.frame);
    }
    
    function update()
    {
        base.update();
        local frame_count = ( opts.order != null ) ? opts.order.len() : ( opts.orientation == "vertical" ) ? opts.target.texture_height / opts.height : opts.target.texture_width / opts.width;
        local which_index = clamp(floor( frame_count * progress ), 0, frame_count - 1);
        local which_frame = ( opts.order != null ) ? opts.order[which_index] : which_index;
        if ( opts.frame != which_frame )
        {
            print( "Sprite change, index: " + which_index + " of " + ( frame_count - 1 ) );
            sprite_frame(which_frame);
        }
        if ( "target" in opts )
            if ( opts.orientation == "vertical" ) opts.target.subimg_y = opts.frame * opts.height; else opts.target.subimg_x = opts.frame * opts.width;
    }

    
    //shows a specific sprite frame
    function frame(which)
    {
        frameOffset = which;
        switch ( opts.orientation ) {
            case "vertical":
                opts.target.subimg_y = ( opts.order == null ) ? frameOffset * opts.height : opts.order[frameOffset] * opts.height;
                break;
            case "horizontal":
            default:
                opts.target.subimg_x = ( opts.order == null ) ? frameOffset * opts.width : opts.order[frameOffset] * opts.width;
                break;
        }
    }
    
    //find the last frame index, in the order specified, or in the spritesheet texture
    function last_frame_index()
    {
        if ( opts.order == null )
        {
            switch ( opts.orientation ) {
                case "vertical":
                    return (opts.target.texture_height - opts.height) / opts.height;
                case "horizontal":
                default:
                    return (opts.target.texture_width - opts.width) / opts.width;
            }
        } else
        {
            return opts.order.len() - 1;
        }
    }
    
    //find the previous frame index, in the order specified, or in the spritesheet texture
    function prev_frame_index()
    {
        if ( opts.order == null )
        {
            //iterate each sprite frame until we reach the beginning
            switch ( opts.orientation ) {
                case "vertical":
                    if ( frameOffset > 0 ) return frameOffset - 1; else return (opts.target.texture_height - opts.height) / opts.height;
                case "horizontal":
                default:
                    if ( frameOffset > 0 ) return frameOffset - 1; else return (opts.target.texture_width - opts.width) / opts.width;
            }
        } else
        {
            //get the previous sprite frame in a custom array, or the last if we reach the beginning
            if ( frameOffset > 0 ) return frameOffset - 1; else return opts.order.len() - 1;
        }
    }
    
    //find the next frame index, in the order specified, or in the spritesheet texture
    function next_frame_index()
    {
        if ( opts.order == null )
        {
            //iterate each sprite frame until we reach the end
            switch ( opts.orientation ) {
                case "vertical":
                    if ( frameOffset * opts.height < opts.target.texture_height - opts.height ) return frameOffset + 1; else return 0;
                case "horizontal":
                default:
                    if ( frameOffset * opts.width < opts.target.texture_width - opts.width ) return frameOffset + 1; else return 0;
            }
        } else
        {
            //get the next sprite frame in a custom array, or the first if we reach the beginning
            if ( frameOffset < opts.order.len() - 1 ) return frameOffset + 1; else return 0;
        }
    }
}