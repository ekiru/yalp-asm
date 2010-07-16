INIT {
    pir::load_bytecode('nqp-rx.pbc');
    pir::load_bytecode('LOST.pbc');
}

class LASM::Compiler is HLL::Compiler {
    method lost ($source, *%adverbs) {
        $source.ast;
    }

    method dump ($source, *%adverbs) {
        if pir::isa__IPP($source, String) {
            sub () {
                say($source);
            }
        } else {
            sub () {
                pir::load_bytecode('dumper.pbc');
                _dumper($source);
            }
        }
    }
}

INIT {
    pir::load_bytecode('LASM/Grammar.pbc');
    pir::load_bytecode('LASM/Actions.pbc');
    LASM::Compiler.language('LASM');
    LASM::Compiler.parsegrammar(LASM::Grammar);
    LASM::Compiler.parseactions(LASM::Actions);

    LASM::Compiler.stages(<parse lost dump>);
}
