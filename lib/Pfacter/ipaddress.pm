package Pfacter::ipaddress;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX|Darwin|FreeBSD|SunOS/ && do {
            my ( $d, @i );

            if ( -e '/etc/ifconfig' ) {
                open( F, '/etc/ifconfig -a |' );
            }
            elsif ( -e '/sbin/ifconfig' ) {
                open( F, '/sbin/ifconfig -a |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;
            close( F );

            foreach ( @F ) {
                $d = $1 if /^(\w+)\:/;
                push @i, "$d=$1" if /inet\s+(\d+\.\d+\.\d+\.\d+)/;
            };

            return join ' ', sort @i;
        };

        /Linux/ && do {
            my ( $d, @i );

            if ( -e '/sbin/ifconfig' ) {
                open( F, '/sbin/ifconfig -a |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;
            close( F );

            foreach ( @F ) {
                $d = $1 if ( /^(\w+)\s+/ || /^(\w+:\d+)\s+/ );
                push @i, "$d=$1" if /inet addr:(\d+\.\d+\.\d+\.\d+)/;
            }

            return join ' ', sort @i;
        };

        return qq((kernel not supported));
    }
}

1;
