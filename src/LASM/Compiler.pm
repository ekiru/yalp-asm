INIT {
    pir::load_bytecode('nqp-rx.pbc');
    pir::load_bytecode('LOST.pbc');
}

class LASM::Compiler is HLL::Compiler {

}

INIT {
    pir::load_bytecode('LASM/Grammar.pbc');
    LASM::Compiler.language('LASM');
    LASM::Compiler.parsegrammar(LASM::Grammar);
}
