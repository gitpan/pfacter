package Pfacter::architecture;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        my ( $r );

        if ( -e '/bin/uname' ) {
            $r = qx( /bin/uname -p );
        }
        elsif ( -e '/usr/bin/uname' ) {
            $r = qx( /usr/bin/uname -p );
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
