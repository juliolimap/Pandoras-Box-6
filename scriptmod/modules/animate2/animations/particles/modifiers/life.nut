class LifeModifier extends ParticleEngineListener {
    config = null
    life = 0
    
    constructor( config = {} ) {
        this.config = {
            randomLifeMin = ( "randomLifeMin" in config ) ? config.randomLifeMin : 2,
            randomLifeMax = ( "randomLifeMax" in config ) ? config.randomLifeMax : 5,
            life = ( "life" in config ) ? config.life : 0
        }
        
        if ( this.config.life == "random" || this.config.life == "random-each" ) {
            this.life = ::Utils.randomf( this.config.randomLifeMin, this.config.randomLifeMax )
        } else {
            this.life = config.life
        }
    }
    function onEvent( event ) {
        switch( event.type ) {
            case ParticleEngineParticle.CREATE_EVENT:
                if ( config.life == "random-each" ) this.life = ::Utils.randomf( config.randomLifeMin, config.randomLifeMax )
                event.particle.life = this.life.tofloat()
                break
        }
    }
}