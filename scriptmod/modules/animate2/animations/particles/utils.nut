//standard Vector2D
class Vector2D
{
    x = 0
    y = 0
    constructor( x = 0, y = 0 ) {
        this.x = x
        this.y = y
    }
    function add( vector ) {
      this.x += vector.x
      this.y += vector.y
    }
    
    function addXY( x, y ) {
        this.x += x
        this.y += y
    }
    
    function equals( vector ) {
        if ( vector.x == this.x && vector.y == this.y ) return true
        return false
    }
    
    function multiply( vector ) {
        this.x *= vector.x
        this.y *= vector.y
    }
    
    function multiplyScalar( s ) {
        this.x *= s
        this.y *= s
    }
    
    function divide( vector ) {
        this.x /= x
        this.y /= y
    }
    
    function divideScalar( s ) {
        if ( s != 0 ) {
            this.x /= s
            this.y /= s
        } else {
            this.x = this.y = 0
        }
    }
    
    function sub( x, y ) {
        this.x -= x
        this.y -= y
    }
    
    function set( x, y ) {
      this.x = x
      this.y = y
    }
    function getMagnitude() {
      return sqrt( this.x * this.x + this.y * this.y )
    }
    function getAngle() {
      return atan2( this.y, this.x )
    }
    function fromAngle( angle, magnitude ) {
      return Vector2D( magnitude * cos(angle), magnitude * sin(angle) )
    }
    function copy() {
      return Vector2D( this.x, this.y )
    }
} 

function interpolate(start, end, steps, count) {
    return floor(start + (((end - start) / steps) * count))
}

function interpolateF(start, end, steps, count) {
    return start + (((end - start) / steps) * count)
}

function normalize( val, min, max ) {
    return ( val - min ) / ( max - min ).tofloat()
}

class Span {
    // a span stores an array of values, and determines the
    // current, previous and next values to use based on a 0.0 to 1.0 progress
    //TODO progress for inifinite particles
    
    values = null
    
    constructor( v ) {
        this.values = v
    }
    
    function add( value ) {
        this.values.push( value )
    }
    
    function currentIndex( progress ) {
        progress = ::Utils.clamp(progress, 0, 1)
        return floor( ( values.len() - 1 ) * progress )
    }
    
    function nextIndex( progress ) {
        progress = ::Utils.clamp(progress, 0, 1)
        local current = currentIndex( progress )
        return ( current <= values.len() - 2 ) ? current + 1 : values.len() - 1
    }
    
    function currentValue( progress ) {
        progress = ::Utils.clamp(progress, 0, 1)
        local current = currentIndex(progress)
        local next = nextIndex(progress)
        local progressPerSpan = 1 / (values.len() - 1).tofloat()
        local step_progress = normalize( progress, current * progressPerSpan, next * progressPerSpan )
        return interpolateF( values[current], values[next], 1, step_progress )
    }
}
