package Pfacter::uniqueid;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            my $r = qx(

                /usr/bin/uname -f

            );

            chomp( $r );

            return lc( $r );
        };

        /Linux/ && do {
            my $r = qx(

                /usr/bin/hostid

            );

            chomp( $r );

            return $r;
        };

        return qq((kernel not supported));
    }
}

1;
