class RateModifier extends ParticleEngineListener {
    config = null
    particleRate = null
    timeRate = null
    startTime = 0
    nextTime = 0

    constructor( config = {} ) {
        this.config = {
            particleRate = ( "particleRate" in config ) ? config.particleRate : "random",
            timeRate = ( "timeRate" in config ) ? config.timeRate : "random",
            type = ( "type" in config ) ? config.type : "random",
            random = {
                particleRate = { min = 1.0, max = 3.0 },
                timeRate = { min = 0.25, max = 1.5 }
            }
        }
        
        particleRate = newValue( "particleRate" )
        timeRate = newValue( "timeRate" )        
    }

    function newValue( key, getFloat = true ) {
        if ( key in config ) {
            if ( config[key] == "random" || config[key] == "random-each" || this.config.type == "random" ||this.config.type == "random-each") {
                return ( getFloat ) ? ::Utils.randomf( config.random[key].min, config.random[key].max ) : ::Utils.random( config.random[key].min, config.random[key].max)
            } else {
                return this.config[key]
            }
        }
        return 0
    }
    
    function onEvent( event ) {
        switch( event.type ) {
            case ParticleEngineEmitter.CREATE_EVENT:
                this.startTime = next( event.time )
                break
            case ParticleEngineEmitter.UPDATE_EVENT:
                local updateTime = ParticleEngine.time()
                if (  updateTime >= this.nextTime) {
                    //choose next emit time
                    next(updateTime)
                    for ( local i = 0; i < particleRate; i++ ) event.emitter.emit()
                    //if random-each, get new values
                    if ( config.particleRate == "random-each" || config.type == "random-each" ) particleRate = newValue( "particleRate" )
                    if ( config.timeRate == "random-each" || config.type == "random-each" ) timeRate = newValue( "timeRate" )
                }
                break
        }
    }

    function next(currentTime) {
        this.nextTime = currentTime + ( timeRate * 1000.0 )
    }
}