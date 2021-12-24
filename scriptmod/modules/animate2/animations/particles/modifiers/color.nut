function Color(r, g, b) {
    return { r = r, g = g, b = b }
}

class ColorSpan extends Span {
    function currentValue( progress ) {
        local current = currentIndex(progress)
        local next = nextIndex(progress)
        local progressPerSpan = 1 / (values.len() - 1).tofloat()
        local step_progress = normalize( progress, current * progressPerSpan, next * progressPerSpan )
        return {
            r = interpolate( values[current].r, values[next].r, 1, step_progress ),
            g = interpolate( values[current].g, values[next].g, 1, step_progress ),
            b = interpolate( values[current].b, values[next].b, 1, step_progress )
        }
    }
}

class ColorModifier extends ParticleEngineListener {
    config = null
    color = null
    type = "random"
    
    constructor( config = {} ) {
        this.config = {
            color = ( "color" in config ) ? config.color : "random",
            type = ""
        }
        if ( typeof( this.config.color ) == "array" ) {
            this.color = ::Utils.randoma(config.color)
        } else if ( this.config.color == "random" || this.config.color == "random-each" ) {
            this.color = randomColor()
        } else {
            this.color = { r = 30, g = 30, b = 30 }
        }
    }
    
    function randomColor() {
        return {
            r = ::Utils.random(0, 255),
            g = ::Utils.random(0, 255),
            b = ::Utils.random(0, 255)
        }
    } 
    
    function onEvent( event ) {
        switch ( event.type ) {
            case ParticleEngineParticle.CREATE_EVENT:
                if ( typeof( color ) == "array" && type == "random-each" ) {
                    event.particle.color = ::Utils.randoma(config.color)
                } else if ( color == "random-each") {
                    event.particle.color = randomColor()
                } else if ( type == "span" ) {
                    event.particle.color = color.currentValue( event.particle.progress() )
                }
                break
            case ParticleEngineParticle.UPDATE_EVENT:
                if ( color instanceof ColorSpan ) event.particle.color = color.currentValue( event.particle.progress() )
                break;
        }
    }
}