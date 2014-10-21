package Pfacter::hardwareproduct;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            if ( -e '/usr/sbin/lsattr' ) {
                open ( F, '/usr/sbin/lsattr -l sys0 -E -a modelname 2>/dev/null |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    if ( /modelname\s.*,(.*)\sMachine/ ) {
                        return $1;
                    }
                }
            }
        };

        /Linux/ && do {
            if ( -e '/usr/sbin/dmidecode' ) {
                my ( $f );

                local $/;
                $/ = /^Handle \d+x/;

                open( F, '/usr/sbin/dmidecode 2>/dev/null |' );
                my ( @F ) = <F>;
                close( F );

                # Multi-version dmidecode compat
                if ( @F == 1 ) { @F = split /Handle/, $F[0]; }

                foreach ( @F ) {
                    if ( /type 1,/ ) {
                        if ( /Product Name:\s+(.*)\s+/ ) {
                            my $p = $1;

                            $p =~ s/\s+/ /g;
                            $p =~ s/\s+$//g;

                            return $p;
                        }
                    }
                }
            }
        };

        return qq((kernel not supported));
    }
}

1;
