.sub 'main' :main
    .param pmc args
    load_language 'lasm'

    $P0 = compreg 'LASM'
    $P1 = $P0.'command_line'(args)
.end
