#!/usr/bin/env parrot-nqp

sub MAIN() {
    # Load distutils library
    pir::load_bytecode('distutils.pbc');

    # ALL DISTUTILS CONFIGURATION IN THIS HASH
    my %cfg := hash(
        # metadata
        setup => 'setup.nqp',
        name                => 'lorito-asm',
        abstract            => 'A prototype assembler for Lorito.',
        keywords            => <parrot lorito>,
        license_type        => 'Artistic License 2.0',
        license_uri         => 'http://www.perlfoundation.org/artistic_license_2_0',
        copyright_holder    => 'Tyler L. Curtis',
        # TODO: add checkout uri and such
        description         => 'A prototype assembler from Lorito to C.',
        # build
        pir_nqp             => unflatten(
            'build/LASM/Grammar.pir',  'src/LASM/Grammar.pm',
            'build/LASM/Compiler.pir', 'src/LASM/Compiler.pm',

            'build/LOST/Node.pir',     'src/LOST/Node.pm',
            'build/LOST/File.pir',     'src/LOST/File.pm',
            'build/LOST/Label.pir',    'src/LOST/Label.pm',
            'build/LOST/Op.pir',       'src/LOST/Op.pm',
            'build/LOST/Value.pir',    'src/LOST/Value.pm',
            'build/LOST/Constant.pir', 'src/LOST/Constant.pm',
            'build/LOST/Register.pir', 'src/LOST/Register.pm',
            'build/LOST.pir',          'src/LOST.pm',
        ),
        pbc_pir             => unflatten(
            'build/LASM/Grammar.pbc',  'build/LASM/Grammar.pir',
            'lasm/lasm.pbc',           'build/LASM/Compiler.pir',
            'lasm.pbc',                'lasm.pir',

            'build/LOST/Node.pbc',     'build/LOST/Node.pir',
            'build/LOST/File.pbc',     'build/LOST/File.pir',
            'build/LOST/Label.pbc',    'build/LOST/Label.pir',
            'build/LOST/Op.pbc',       'build/LOST/Op.pir',
            'build/LOST/Value.pbc',    'build/LOST/Value.pir',
            'build/LOST/Constant.pbc', 'build/LOST/Constant.pir',
            'build/LOST/Register.pbc', 'build/LOST/Register.pir',
            'build/LOST.pbc',          'build/LOST.pir',
        ),

        # install
        inst_lib            => <
            build/LASM/Grammar.pbc

            build/LOST/Node.pbc
            build/LOST/File.pbc
            build/LOST/Label.pbc
            build/LOST/Op.pbc
            build/LOST/Value.pbc
            build/LOST/Constant.pbc
            build/LOST/Register.pbc
            build/LOST.pbc
        >,

        inst_lang           => <
            lasm/lasm.pbc
        >,

        installable_pbc     => hash(parrot-lasm => 'lasm.pbc'),

        # dist
        manifest_includes   => glob('examples/*.pir examples/*.nqp'),
        doc_files           => glob('README docs/*/*.pod docs/*/*/*.pod'),
    );

    # Boilerplate; should not need to be changed
    my @*ARGS := pir::getinterp__P()[2];
    @*ARGS.shift;
    
    setup(|@*ARGS, |%cfg);
}

# Work around minor nqp-rx limitations
sub hash     (*%h ) { %h }
sub unflatten(*@kv) { my %h; for @kv -> $k, $v { %h{$k} := $v }; %h }

MAIN();
