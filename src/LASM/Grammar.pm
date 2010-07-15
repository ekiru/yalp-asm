grammar LASM::Grammar {
    token TOP {
        [\h* <label>? \h* <instruction>? \h*] ** "\n"
    }

    token label {
        <label-name> ":"
    }

    token label-name {
        '&' "'" \w+ "'"
    }

    proto token instruction {<...>}

    token instruction:sym<call> {
        <sym> \h+ <label-name>
    }

    token instruction:sym<coerce> {
        <sym> \h+ $<dest>=<register> \h+ $<src>=<register>
    }

    token instruction:sym<end> {
        <sym>
    }

    token instruction:sym<if> {
        <sym> \h+ <register> \h+ <label-name>
    }

    token instruction:sym<init> {
        <sym> \h+ <register> \h+ <constant>
    }

    token instruction:sym<islt> {
        <sym> \h+ $<dest>=<register> \h+
        $<left>=<register> \h+ $<right>=<register>
    }

    token instruction:sym<mul> {
        <sym> \h+ $<dest>=<register> \h+
        $<left>=<register> \h+ $<right>=<register>
    }

    token instruction:sym<not> {
        <sym> \h+ $<dest>=<register> \h+ $<src>=<register>
    }

    token instruction:sym<pop> {
        <sym> \h+ <register>
    }

    token instruction:sym<print> {
        <sym> \h+ <register>
    }

    token instruction:sym<push> {
        <sym> \h+ <register>
    }

    token instruction:sym<ret> {
        <sym>
    }

    token instruction:sym<sub> {
        <sym> \h+ $<dest>=<register> \h+
        $<left>=<register> \h+ $<right>=<register>
    }

    token register {
        [ 'I' |  'N' | 'S' | 'P' ] <digit>+
    }

    proto token constant { <...> }

    token constant:sym<+> {
        <sym> (<digit>+)
    }
}
