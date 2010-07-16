grammar LASM::Grammar is HLL::Grammar {
    token TOP {
        <labelled-instruction> ** "\n"
    }

    token labelled-instruction {
        | \h* <label> \h*
        | \h* <instruction> \h*
        | \h* <label> \h* <instruction> \h*
    }

    token label {
        <label-name> ":"
    }

    token label-name {
        '&' "'" (\w+) "'"
    }

    proto token instruction {<...>}

    token instruction:sym<no-arg> {
        $<name>=['end' | 'ret']
    }

    token instruction:sym<lab> {
        $<name>='call' \h+ <label-name>
    }

    token instruction:sym<reg> {
        $<name>=<r-op> \h+ <register>
    }

    token r-op {
        'pop' | 'print' | 'push'
    }

    token instruction:sym<reg-const> {
        $<name>='init' \h+ <register> \h+ <constant>
    }

    token instruction:sym<reg-lab> {
        $<name>='if' \h+ <register> \h+ <label-name>
    }

    token instruction:sym<reg-reg> {
        $<name>=<rr-op> \h+ $<dest>=<register> \h+ $<src>=<register>
    }

    token rr-op {
        'coerce'|'not'
    }

    token instruction:sym<reg-reg-reg> {
        $<name>=<rrr-op> \h+ $<dest>=<register> \h+
        $<left>=<register> \h+ $<right>=<register>
    }

    token rrr-op {
        'islt' | 'mul' | 'sub'
    }

    token register {
        $<type>=['I' |  'N' | 'S' | 'P' ] $<number>=[<digit>+]
    }

    proto token constant { <...> }

    token constant:sym<+> {
        <sym> (<digit>+)
    }
}
