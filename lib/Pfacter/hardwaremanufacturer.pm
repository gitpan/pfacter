package Pfacter::hardwaremanufacturer;

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
                    if ( /modelname\s(.*),/ ) {
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
                        if ( /Manufacturer:\s+(.*)\s+/ ) {
                            my $m = $1;

                            $m =~ s/\s+/ /g;
                            $m =~ s/\s+$//g;

                            return $m;
                        }
                    }
                }
            }
        };

        return qq((kernel not supported));
    }
}

1;
