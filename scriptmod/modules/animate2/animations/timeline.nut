class TimelineAnimation extends Animation
{
    function defaults(vargv) {
        base.defaults(vargv);
        //set some additional default values
        opts = merge_opts({
            queue = [],
            index = 0
        }, opts);
    }

    //chainable functions
    function add( anim ) {
        print("queued anim: " + anim.name );
        opts.queue.push( anim );
        return this
    }

    function start()
    {
        last_update = ::clock() * 1000;
        elapsed = 0;
        tick = 0;

        running = true;
        run_callback( "start", this );

        //if anything is in queue, play it
        if ( opts.queue.len() > 0 )
        {
            //queue the next animation
            opts.queue[0].on("stop", this, "next" );
            //start playing
            opts.queue[0].play()
        }
    }

    function next( lastAnim = null )
    {
        opts.queue[opts.index].off( "stop", this, "next" )
        if ( opts.queue[opts.index].running ) opts.queue[opts.index].stop()
        opts.index++
        if ( opts.index <= opts.queue.len() - 1 )
        {
            run_callback( "next", this );
            opts.queue[opts.index].on("stop", this, "next" );
            opts.queue[opts.index].play();
            print("finished " + opts.index + " of " + opts.queue.len() + " " + opts.queue[opts.index].name);
        } else
        {
            local name = ( opts.name == "" ) ? "" : opts.name;
            print("timeline " + name + " finished!");
            running = false;
            opts.index = 0;
            run_callback( "stop", this );
        }
    }
    
    function print( msg ) { base.print( "TimelineAnimation: " + msg + "\n" ) }
}
