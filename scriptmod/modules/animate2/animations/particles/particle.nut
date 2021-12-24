class ParticleEngineParticle extends ParticleEngineEmitter {
    CREATE_EVENT = "particle_create"
    UPDATE_EVENT = "particle_update"
    DESTROY_EVENT = "particle_destroy"
    ERROR_EVENT = "particle_error"

    id = 0
    parent = null   //parent emitter

    //create the particle
    constructor( parent ) {
        base.constructor( parent )
        if ( parent.PARTICLE_ID == parent.MAX_PARTICLES - 1 ) {
            //destroy oldest and reuse it
            dispatchEvent( { type = DESTROY_EVENT, particle = parent.particles[0] } )
            this.id = parent.PARTICLE_ID = 0
        } else {
            parent.PARTICLE_ID++
            this.id = parent.PARTICLE_ID
        }
    }

    //pass events to parent
    function dispatchEvent( event ) {
        event.particle <- this
        parent.dispatchEvent( event )
    }

    //update this particle
    function update(elapsed) {
        base.update(elapsed)
        dispatchEvent({
            type = UPDATE_EVENT,
            particle = this.weakref(),
            elapsed = elapsed
        })
    }

    //destroy this particle
    function destroy() {
        dispatchEvent({
            type = DESTROY_EVENT,
            particle =this.weakref()
        });
    }
}