package Pfacter::hardwareplatform;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        my ( $r );

        /AIX/ && do {
            if ( -e '/usr/sbin/lsattr' ) {
                open( F, '/usr/sbin/lsattr -El proc0 |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    if ( /type\s+.*_(\w+)\s/ ) { return $1; }
                }
            }
        };

        /Linux/ && do {
            if ( -e '/bin/uname' ) {
                $r = qx( /bin/uname -i );
            }
        };

        if ( $r ) {
            chomp( $r );

            return $r;
        }
        else {
            return qq((kernel not supported));
        }
    }
}

1;
