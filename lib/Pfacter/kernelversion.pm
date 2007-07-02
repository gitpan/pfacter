package Pfacter::kernelversion;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        my ( $r );

        if ( -e '/bin/uname' ) {
            $r = qx( /bin/uname -v );
        }
        elsif ( -e '/usr/bin/uname' ) {
            $r = qx( /usr/bin/uname -v );
        }

        if ( $r ) {
            chomp( $r );

            return $r;
        } else {
            return qq((kernel not supported));
        }
    }
}

1;
