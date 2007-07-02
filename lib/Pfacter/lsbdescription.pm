package Pfacter::lsbdescription;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /Linux/ && do {
            my ( $d, @i );

            if ( -e '/bin/lsb_release' ) {
                open( F, '/bin/lsb_release -d |' );
            }
            elsif ( -e '/usr/bin/lsb_release' ) {
                open( F, '/usr/bin/lsb_release -d |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;
            close( F );

            foreach ( @F ) {
                return $1 if /\:\s+(.*)$/
            }
        };

        return qq((kernel not supported));
    }
}

1;
