package Pfacter::hardwaremodel;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        my ( $r );

        /AIX|Darwin|FreeBSD|Linux/ && do {
            if ( -e '/bin/uname' ) {
                $r = qx( /bin/uname -m );
            }
            elsif ( -e 'usr/bin/uname' ) {
                $r = qx( /usr/bin/uname -m );
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
