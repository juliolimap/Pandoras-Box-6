class ScaleModifier extends ParticleEngineListener {
    config = null
    scale = null
    
    constructor( config = {} ) {
        this.config = {
            randomScaleXMin = ( "randomScaleXMin" in config ) ? config.randomScaleXMin : 0.5,
            randomScaleXMax = ( "randomScaleXMax" in config ) ? config.randomScaleXMax : 4,
            randomScaleYMin = ( "randomScaleYMin" in config ) ? config.randomScaleYMin : 0.5,
            randomScaleYMax = ( "randomScaleYMax" in config ) ? config.randomScaleYMax : 4,
            scaleX = ( "scaleX" in config ) ? config.scaleX : 1.0,
            scaleY = ( "scaleY" in config ) ? config.scaleY : 1.0
        }
        this.scale = Vector2D( 1, 1 )
        if ( config.scaleX == "random" || config.scaleX == "random-each" || config.scaleY == "random" || config.scaleY == "random-each" ) {
            scale.x = scale.y = ::Utils.randomf( this.config.randomScaleXMin, this.config.randomScaleXMax )
        } else {
            scale.x = this.config.scaleX
            scale.y = this.config.scaleY
        }
    }

    function onEvent( event ) {
        switch( event.type ) {
            case ParticleEngineParticle.CREATE_EVENT:
                if ( ! ( config.scaleX instanceof Span ) ) {
                    //center based on scale
                    event.particle.position.addXY(
                        ( event.particle.size.x * ( scale.x - event.particle.scale.x ) ) / -2.0,
                        ( event.particle.size.y * ( scale.y - event.particle.scale.y ) ) / -2.0
                    );
                    //set the new scale and size
                    event.particle.scale.set( scale.x, scale.y )
                    event.particle.size.set( event.particle.size.x * event.particle.scale.x, event.particle.size.y * event.particle.scale.y )
                }
                break
            case ParticleEngineParticle.UPDATE_EVENT:
                //When scale changes over time, we need to use history to get the scale difference
                if ( config.scaleX instanceof Span || config.scaleY instanceof Span ) {
                    /*
                    local newScale = {
                        x = config.scaleX.currentValue( event.particle.progress() ),
                        y = config.scaleX.currentValue( event.particle.progress() )
                    }
                    local scaleDiff = {
                        x = event.particle.scale.x + newScale.x,
                        y = event.particle.scale.y + newScale.y
                    }
                    local newSize = {
                        x = event.particle.size.x
                    }
                    local sizeDiff = {
                        x = event.particle.size.x + event.particle.
                    }
                    
                    print(newScale + " " + event.particle.progress() )
                    */
                    local newScale = config.scaleX.currentValue( event.particle.progress() )
                    local previousScale = event.particle.history[event.particle.history.len() - 1].scale
                    local previousSize = event.particle.history[event.particle.history.len() - 1].size
                    event.particle.position.addXY(
                        ( ( event.particle.size.x - previousSize.x ) * ( newScale - previousScale.x ) ) / -2.0,
                        ( ( event.particle.size.y - previousSize.y ) * ( newScale - previousScale.y ) ) / -2.0
                    )
                    event.particle.scale.set( newScale, newScale )
                    event.particle.size.set( event.particle.size.x * event.particle.scale.x, event.particle.size.y * event.particle.scale.y )
                }
                break
        }
    }
}