class ParticleEngineEmitter {

    //events this emitter dispatches
    CREATE_EVENT = "emitter_create"
    UPDATE_BEFORE_EVENT = "emitter_update_before"
    UPDATE_EVENT = "emitter_update"
    DESTROY_EVENT = "emitter_destroy"
    ERROR_EVENT = "emitter_error"

    MAX_PARTICLES = 1500
    MAX_HISTORY = 10
    PARTICLE_ID = -1
    
    parent = null       //parent engine
    id = 0
    position = null
    origin = null
    history = null
    transform = null
    velocity = null
    acceleration = null
    size = null
    scale = null
    color = null
    particles = null    //particles array
    modifiers = null    //modifiers array
    spread = 3.14159 / 32.0

    age = 0
    life = 0
    mass = 1.1
    config = null

    //create the emitter
    constructor( parent, config = {} ) {
        this.parent = parent
        this.position = ( parent instanceof ParticleEngineEmitter ) ? parent.position.copy() : Vector2D( config.x, config.y )
        this.transform = Vector2D()
        this.velocity = Vector2D()
        this.acceleration = Vector2D()
        this.size = Vector2D( 32, 32 )
        this.scale = Vector2D( 1.0, 1.0 )
        this.particles = []
        this.modifiers = []
        this.history = []
        this.color = Color( 200, 0, 0 )
        this.config = {
            texture = ( "texture" in config ) ? config.texture : fe.module_dir + "resources/circle.png"
        }

        if ( parent instanceof ParticleEngine ) {
            //emitter
            this.id = parent.EMITTER_ID++
            this.position.addXY( - ( this.size.x / 2 ), - ( this.size.y / 2 ) )
            dispatchEvent({ type = CREATE_EVENT })
        }
    }
    
    function addModifier( modifier ) { modifiers.push(modifier) }
    function progress() { return ( life > 0 ) ? age / ( life * 1.0 ) : age / 1.0 }
    function isDead() { return ( ( life > 0 ) && ( age > life ) ) }
    function destroy() { for ( local i = 0; i < particles.len(); i++ ) particles[i].destroy() }

    //emit particles
    function emit() {
        if ( isDead() ) return
        local p = ParticleEngineParticle(this)
        if ( particles.len() >= MAX_PARTICLES ) particles[PARTICLE_ID] = p else particles.push(p)
        dispatchEvent( {
            type = ParticleEngineParticle.CREATE_EVENT,
            particle = p.weakref()
        } )
    }
    
    //pass events to parent (engine) and modifiers
    function dispatchEvent( event ) {
        event.emitter <- this.weakref()
        parent.dispatchEvent( event )
        for ( local i = 0; i < modifiers.len(); i++ ) {
            event.modifier <- modifiers[i].weakref()
            modifiers[i].onEvent( event )
        }
    }
    
    //update the emitter
    function update(elapsed) {
        if ( history.len() >= MAX_HISTORY ) history.remove(0)
        history.push( { position = this.position.copy(), scale = this.scale.copy(), size = this.size.copy(), velocity = this.velocity.copy(), acceleration = this.acceleration.copy() } )
        dispatchEvent( { type = UPDATE_BEFORE_EVENT, elapsed = elapsed } )
        age += ( elapsed / 1000.0 )
        velocity.add(acceleration)
        position.add(velocity)
        
        for ( local i = 0; i < particles.len(); i++ ) {
            particles[i].update(elapsed)
            if ( particles[i].isDead() ) {
                dispatchEvent( { type = ParticleEngineParticle.DESTROY_EVENT, particle = particles[i].weakref() } )
                particles.remove(i)
                if ( i > 0 ) i--
            }
        }
        
        //only send update for emitters, particles send their own UPDATE_EVENT
        if ( parent instanceof ParticleEngine ) dispatchEvent({ type = UPDATE_EVENT })        
    }
}