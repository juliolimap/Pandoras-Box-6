class VelocityModifier extends ParticleEngineListener {
    config = null
    angle = 0
    radius = 1
    
    r = {
    }
    constructor( config = {} ) {
        this.config = {
            randomAngleMin = ( "randomAngleMin" in config ) ? config.randomAngleMin : 0,
            randomAngleMax = ( "randomAngleMax" in config ) ? config.randomAngleMax : 359,
            randomRadiusMin = ( "randomRadiusMin" in config ) ? config.randomRadiusMin : 0,
            randomRadiusMax = ( "randomRadiusMax" in config ) ? config.randomRadiusMax : 5,
            angle = ( "angle" in config ) ? config.angle : 0,
            radius = ( "radius" in config ) ? config.radius : 0.3
        }
        
        if ( typeof( this.config.angle ) == "array" ) {
            angle = ::Utils.randoma(this.config.angle)
        } else if ( this.config.angle == "random" || this.config.angle == "random-each" ) {
            angle = ::Utils.randomf( this.config.randomAngleMin, this.config.randomAngleMax )
        } else {
            angle = this.config.angle
        }
        
        if ( typeof( this.config.radius ) == "array" ) {
            radius = ::Utils.randoma(this.config.radius)
        } else if ( this.config.radius == "random" || this.config.radius == "random-each" ) {
            radius = ::Utils.randomf( this.config.randomRadiusMin, this.config.randomRadiusMax )
        } else {
            radius = this.config.radius
        }
        
        //angle
        //local a = velocity.getAngle() + this.spread - ( ::Utils.random(0, 1) * this.spread * 2 )
        // The magnitude of the emitter's velocity
        //local m = velocity.getMagnitude()
        //p.velocity = Vector2D.fromAngle(a, m)        
    }

    function onEvent( event ) {
        switch( event.type ) {
            case ParticleEngineParticle.CREATE_EVENT:
                //add direction to particle
                event.particle.velocity.set( (radius * cos(angle.tofloat() * PI / 180)).tofloat(),
                                            (radius * sin(angle.tofloat() * PI / 180)).tofloat() )
                if ( config.angle == "random-each" ) angle = angle = ::Utils.randomf( this.config.randomAngleMin, this.config.randomAngleMax )
                if ( config.radius == "random-each" ) radius = ::Utils.randomf( this.config.randomRadiusMin, this.config.randomRadiusMax )                
                break
        }
    }
}