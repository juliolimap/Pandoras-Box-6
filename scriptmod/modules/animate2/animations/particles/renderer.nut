class AttractModeRenderer extends ParticleEngineListener {
    surface = null              //the surface the particles will draw on
    particle_objects = null     //the cloned AM objects for our particles
    textures = null             //the texture file names that will be cloned
    debug = null                //hold references to debug objects
    
    constructor( surface ) {
        base.constructor()
        particle_objects = []
        textures = {}
        debug = {}
        this.surface = ( surface != null ) ? surface : ( FeVersionNum > 1.3 ) ? ::fe.add_surface(fe.layout.width, fe.layout.height) : ::fe
}

    function identify() { return "renderer" }
    function onEvent( event ) {
        switch ( event.type ) {
            case ParticleEngine.CREATE_EVENT:
                //create texture arrays and debug objects
                if ( ENABLE_DEBUG ) {
                    debug.surface_bg <- ::fe.add_surface(fe.layout.width, fe.layout.height)
                    debug.surface <- ::fe.add_surface(fe.layout.width, fe.layout.height)
                    debug.surface_fg <- ::fe.add_surface(fe.layout.width, fe.layout.height)
                    debug.surface.x = debug.surface.y = 20
                    debug.surface.alpha = 220
                    debug.pixel <- debug.surface.add_image(fe.module_dir + "resources/pixel.png")
                    debug.marker <- debug.surface.add_image(fe.module_dir + "resources/marker.png", -1, -1, 1, 1)
                    debug.line1 <- debug.surface.add_text("ParticleEngine Debugger", 10, 10, fe.layout.width * 0.75, 20)
                    debug.line2 <- debug.surface.add_text("", 10, 30, fe.layout.width * 0.75, 20)
                    debug.line3 <- debug.surface.add_text("", 10, 50, fe.layout.width * 0.75, 20)
                    debug.line4 <- debug.surface.add_text("", 10, 70, fe.layout.width * 0.75, 20)
                    debug.line1.align = debug.line2.align = debug.line3.align = debug.line4.align = Align.Left
                    debug.line1.set_bg_rgb(20,20,20)
                    debug.line2.set_bg_rgb(20,20,20)
                    debug.line3.set_bg_rgb(20,20,20)
                    debug.line4.set_bg_rgb(20,20,20)
                    debug.emitters <- []
                }
                break
            case ParticleEngineEmitter.CREATE_EVENT:
                //show emitter location in debug
                if ( ENABLE_DEBUG ) {
                  local obj = debug.surface_bg.add_clone( debug.marker )
                  obj.alpha = 200
                  debug.emitters.push( obj )
                }
                break
            case ParticleEngineParticle.CREATE_EVENT:
                //create objects we can clone for each unique texture
                if ( event.emitter.config.texture in textures == false )
                    textures[ event.emitter.config.texture ] <- surface.add_image( event.emitter.config.texture, -1, -1, 1, 1 )
                
                //if this particle id hasn't been created, create it
                if ( particle_objects.len() == 0 || event.particle.id >= particle_objects.len() )
                    particle_objects.push( surface.add_clone( textures[ event.emitter.config.texture ] ) )
                
                //if texture is different from reused particles, update it
                if ( event.emitter.config.texture != particle_objects[event.particle.id].file_name )
                    particle_objects[event.particle.id].file_name = event.emitter.config.texture
                break
            case ParticleEngine.UPDATE_EVENT:
                break
            case ParticleEngineEmitter.UPDATE_EVENT:
                //update emitter location in debug mode
                if ( ENABLE_DEBUG ) {
                  debug.emitters[ event.emitter.id ].x = event.emitter.position.x
                  debug.emitters[ event.emitter.id ].y = event.emitter.position.y
                  debug.emitters[ event.emitter.id ].width = event.emitter.size.x
                  debug.emitters[ event.emitter.id ].height = event.emitter.size.y
                }
                break
            case ParticleEngineParticle.UPDATE_EVENT:
                //update particle properties
                particle_objects[event.particle.id].set_pos(event.particle.position.x, event.particle.position.y, event.particle.size.x, event.particle.size.y)
                particle_objects[event.particle.id].set_rgb( event.particle.color.r, event.particle.color.g, event.particle.color.b )
                particle_objects[event.particle.id].visible = true
                break
            case ParticleEngine.DESTROY_EVENT:
                break
            case ParticleEngineEmitter.DESTROY_EVENT:
                break
            case ParticleEngineParticle.DESTROY_EVENT:
                //particle_objects.remove(event.particle.id)
                //hide dead particles
                particle_objects[event.particle.id].visible = false
                break
            case ParticleEngine.ERROR_EVENT:
            case ParticleEngineEmitter.ERROR_EVENT:
            case ParticleEngineParticle.ERROR_EVENT:
                print("Error: " + event.msg)
                break
            case ParticleEngine.DEBUG_EVENT:
                //display info in debug mode
                if ( ENABLE_DEBUG ) {
                    debug.line1.msg = "ParticleEngine: emitters: " + event.debug.emitterCount + " particles: " + event.debug.particleCount
                    debug.line2.msg = "fps: " + event.debug.fps + " time: " + event.debug.time + " elapsed: " + event.debug.elapsed
                    debug.line3.msg = "particle objects: " + particle_objects.len()
                }
                break
        }
    }
}