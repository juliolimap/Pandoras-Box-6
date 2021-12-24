class ParticleEngineField {
  position = null
  mass = 100
  
  constructor( position, mass ) {
    this.position = position
    this.mass = mass
  }
  
  function setMass( mass = 100 ) {
    this.mass = mass
  }
}

class FieldModifier extends ParticleEngineListener {
  fields = null
  constructor( x, y, mass ) {
    this.fields = []
    addField( x, y, mass )
  }

  function addField( x, y, mass ) {
    local field = ParticleEngineField( Vector2D(x, y), mass)
    fields.push(field)
  }

  function onEvent( event ) {
    switch( event.type ) {
      case ParticleEngineEmitter.UPDATE_EVENT:
        local emitterAccelX = 0
        local emitterAccelY = 0

        //update emitter
        /*
        for ( local i = 0; i < fields.len(); i++ ) {
          //find dist between emitter and field
          local emitterVectorX = fields[i].position.x - event.emitter.position.x
          local emitterVectorY = fields[i].position.y - event.emitter.position.y
          local force = fields[i].mass / pow(emitterVectorX*emitterVectorX+emitterVectorY*emitterVectorY,1.5).tofloat()
          emitterAccelX += emitterVectorX * force
          emitterAccelY += emitterVectorY * force
        }
        event.emitter.acceleration.x = emitterAccelX
        event.emitter.acceleration.y = emitterAccelY
        */

        //update particles
        /*
        for ( local p = 0; p < event.emitter.particles.len(); p++ ) {
          local fieldAccelX = 0
          local fieldAccelY = 0
          for ( local i = 0; i < fields.len(); i++ ) {
            //find dist between particle and field
            local vectorX = fields[i].position.x - event.emitter.particles[p].position.x
            local vectorY = fields[i].position.y - event.emitter.particles[p].position.y
            local force = fields[i].mass / pow(vectorX*vectorX+vectorY*vectorY,1.5).tofloat()
            fieldAccelX += vectorX * force
            fieldAccelY += vectorY * force
          }
          event.emitter.particles[p].acceleration.x = fieldAccelX
          event.emitter.particles[p].acceleration.y = fieldAccelY
        }
        */
        break
      case ParticleEngineParticle.UPDATE_EVENT:
            local fieldAccelX = 0
            local fieldAccelY = 0
            //find dist between particle and field
            for ( local i = 0; i < fields.len(); i++ ) {
                local vectorX = fields[i].position.x - event.particle.position.x
                local vectorY = fields[i].position.y - event.particle.position.y
                local force = fields[i].mass / pow(vectorX*vectorX+vectorY*vectorY,1.5).tofloat()
                fieldAccelX += vectorX * force
                fieldAccelY += vectorY * force
            }
            event.particle.acceleration.x = fieldAccelX
            event.particle.acceleration.y = fieldAccelY
        break
    }
  }
}
