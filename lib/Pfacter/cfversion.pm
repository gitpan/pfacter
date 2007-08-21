package Pfacter::cfversion;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX|Linux/ && do {
            my ( $d, @i );

            if ( -e '/var/cfengine/bin/cfagent' ) {
                my ( $v );

                open( F, '/var/cfengine/bin/cfagent -V |' );
                foreach ( <F> ) { $v = $1 if /GNU cfengine (\d.*)$/; }
                close( F );

                return $v;
            }
            else {
                return qq((kernel not supported));
            }
        };

        return qq((kernel not supported));
    }
}

1;
