/*
    much of this is based on Proton particle engine:
    https://github.com/a-jie/Proton/tree/master/src
*/

//allow subcomponents to listen to ParticleEngine events
class ParticleEngineListener {
    static ENABLE_DEBUG = false;
    constructor() {}
    function identify() { return "ParticleEngineListener" }
    function onEvent( event ) {}
    function print( msg ) { ::print( "ParticleEngine : " + identify() + " : " + msg + "\n" ) }
}

fe.do_nut("scriptmod/modules/utils.nut");
fe.do_nut("scriptmod/modules/renderer.nut");

class ParticleEngine {
    CREATE_EVENT = "engine_create"
    UPDATE_EVENT = "engine_update"
    DESTROY_EVENT = "engine_destroy"
    ERROR_EVENT = "engine_error"
    DEBUG_EVENT = "engine_debug"

    EMITTER_ID = 0

    renderer = null
    emitters = null
    particles = null
    listeners = null
    elapsed = 0
    age = 0
    debug = null
    initialized = false

    constructor( surface  ) {
        this.renderer = AttractModeRenderer(surface)
        this.emitters = []
        this.listeners = []
        this.debug = {}
        registerListener(renderer)

        //TODO - time calculations in renderer, not engine
        ::fe.add_ticks_callback(this, "on_tick")

        dispatchEvent({ type = CREATE_EVENT })
        initialized = true
    }

    //register event listener
    function registerListener( l ) {
        //a listener is just an class/object/table with an onEvent function
        listeners.push(l)
        return this
    }

    //add emitter to engine
    function addEmitter( config = {} ) {
        emitters.push( ParticleEngineEmitter( this, config ) )
        return emitters[emitters.len() - 1]
    }

    //add modifier to all emitters
    function addModifier( modifier ) {
        for ( local i = 0; i < emitters.len(); i++ ) emitters[i].addModifier(modifier)
    }

    //passes events to interested listeners
    function dispatchEvent( event ) {
        event.engine <- this.weakref()
        event.debug <- this.debug
        for ( local i = 0; i < listeners.len(); i++ )
            listeners[i].onEvent( event )
        event = null
    }

    //remove emitter
    function removeEmitter(emitter) {

    }

    //update engine
    function update(ttime) {
        if ( initialized ) {
            this.elapsed = ttime - this.age
            this.age = ttime

            for ( local i = 0; i < emitters.len(); i++ ) {
                emitters[i].update(elapsed)
                dispatchEvent({ type = UPDATE_EVENT })
            }

            //debug info
            debug.emitterCount <- emitters.len()
            debug.particleCount <- getCount()
            debug.time <- ttime
            debug.elapsed <- elapsed
            if ( "fps" in debug == false || "fpsCount" in debug == false || debug.fpsCount > 1000 ) {
                debug.fps <- ( "frames" in debug == false ) ? 0 : debug.frames
                debug.frames <- 0
                debug.fpsCount <- 0
            } else {
                debug.fpsCount += elapsed
                debug.frames++
            }
            
            dispatchEvent({ type = DEBUG_EVENT })
        }
    }

    //get particle count
    function getCount() {
        local count = 0
        for ( local i = 0; i < emitters.len(); i++ ) count += emitters[i].particles.len()
        return count
    }

    //destroy engine
    function destroy() {
        for ( local i = 0; i < emitters.len(); i++ )
        {
            emitters[i].destroy()
            dispatchEvent({ type = DESTROY_EVENT })
        }
    }

    function time() {
      return ::clock() * 1000
    }

    //TODO time calculations in renderer, not engine
    function on_tick(ttime) {
        ::clock() * 1000
        update(ttime)
    }

}

fe.do_nut("scriptmod/modules/animate2/animations/particles/emitter.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/particle.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/accelerate.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/color.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/field.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/force.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/life.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/rate.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/scale.nut")
fe.do_nut("scriptmod/modules/animate2/animations/particles/modifiers/velocity.nut")
