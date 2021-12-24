class ForceModifier extends ParticleEngineListener {
    force = null
    NORMALIZE = 1 //100?

    constructor( x = 0, y = 1 ) {
        this.force = Vector2D(x, y)
        this.force.multiplyScalar(NORMALIZE)
    }

    function onEvent( event ) {
        switch( event.type ) {
            case ParticleEngineParticle.CREATE_EVENT:
                //add force to particles
                applyForce(event.particle, force)
                break
        }
    }

    function applyForce( v, force ) {
        local f = Vector2D(force.x, force.y)
        f.divideScalar(v.mass)
        v.acceleration.add(f)
    }
}