package Pfacter::serialnumber;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            if ( -e '/usr/sbin/lsattr' ) {
                open( F, '/usr/sbin/lsattr -El sys0 -a systemid |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;

            close( F );

            my ( $n ) = 0;

            foreach ( @F ) {
                if ( /,(.+?)\s+/ ) { $n = $1; last; }
            }

            $n =~ s/\s+$//;

            return $n;
        };

        /Linux/ && do {
            if ( -e '/usr/sbin/dmidecode' ) {
                open( F, '/usr/sbin/dmidecode 2>/dev/null |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;

            close( F );

            my ( $n ) = 0;

            foreach ( @F ) {
                if ( /Serial Number\:\s+(.+?)$/ ) { $n = $1; last; }
            }

            $n =~ s/\s+$//;

            return $n;
        };

        return qq((kernel not supported));
    }
}

1;
