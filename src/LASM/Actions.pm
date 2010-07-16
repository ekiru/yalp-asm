class LASM::Actions {
    method TOP ($/) {
        my $file := LOST::File.new();
        for $<labelled-instruction> -> $instr {
            if pir::does__IPS($instr.ast, "array") {
                $file.push(|$instr.ast);
            } else {
                $file.push($instr.ast);
            }
        }
        make $file;
    }

    method labelled-instruction ($/) {
        if $<label> && $<instruction> {
            make [ $<label>.ast, $<instruction>.ast ];
        } elsif $<label> {
            make $<label>.ast;
        } else { # It's an <instruction>
            make $<instruction>.ast;
        }
    }

    method label ($/) {
        make $<label-name>.ast;
    }

    method label-name ($/) {
        make LOST::Label.new(:name(~$/[0]));
    }

    method instruction:sym<no-arg> ($/) {
        make LOST::Op.new(:name(~$<name>));
    }

    method instruction:sym<lab> ($/) {
        make LOST::Op.new(:name(~$<name>), $<label-name>.ast);
    }

    method instruction:sym<reg> ($/) {
        make LOST::Op.new(:name(~$<name>), $<register>.ast);
    }

    method instruction:sym<reg-const> ($/) {
        make LOST::Op.new(:name(~$<name>), $<register>.ast, $<constant>.ast);
    }

    method instruction:sym<reg-lab> ($/) {
        make LOST::Op.new(:name(~$<name>), $<register>.ast,
                          $<label-name>.ast);
    }
    
    method instruction:sym<reg-reg> ($/) {
        make LOST::Op.new(:name(~$<name>), $<dest>.ast, $<src>.ast);
    }

    method instruction:sym<reg-reg-reg> ($/) {
        make LOST::Op.new(:name(~$<name>), $<dest>.ast,
                          $<left>.ast, $<right>.ast);
    }

    method register ($/) {
        make LOST::Register.new(:type(~$<type>), :number(+$<number>));
    }

    method constant:sym<+> ($/) {
        make LOST::Constant.new(:type<I>, :value(+$<value>));
    }
}
