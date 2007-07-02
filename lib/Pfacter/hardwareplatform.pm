package Pfacter::hardwareplatform;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        my ( $r );

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
