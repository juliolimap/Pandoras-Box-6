class AccelerateModifier extends ParticleEngineListener {
    angle = 0
    radius = 0.1
    
    constructor( angle = 0, radius = 0.1 ) {
        this.angle = angle
        this.radius = radius
    }

    function onEvent( event ) {
        switch( event.type ) {
            case ParticleEngineParticle.CREATE_EVENT:
                //add acceleration to particles
                event.particle.acceleration.set((radius * cos(angle.tofloat() * PI / 180)).tofloat(), (radius * sin(angle.tofloat() * PI / 180)).tofloat() )
                break
        }
    }
}