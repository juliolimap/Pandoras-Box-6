fe.do_nut("scriptmod/modules/utils.nut");
fe.do_nut("scriptmod/modules/animate2/animations/particles/engine.nut");
class ParticleAnimation extends Animation {
    engine = null;
    function constructor( param1 = null, param2 = null ) {
        base.constructor( param1, param2 );
        engine = ParticleEngine(opts.target);
        print("ParticleAnimation initialized");
    }

    function addEmitter(props) {
        engine.addEmitter();
    }

    function addModifier(props) {
        engine.addModifier(props);
    }
    /*
    function update() {
        base.update();
        engine.update(elapsed);
    }
    */
}