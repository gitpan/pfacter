package Pfacter::macaddress;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            my ( $d, @i );

            if ( -e '/usr/bin/netstat' ) {
                open( F, '/usr/bin/netstat -ia |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    $d = $1 if /^(\w+)\s+/;
                    push @i, "$d=$1" if /(\w+\:\w+\:\w+\:\w+\:\w+\:\w+)/;
                }

                return join ' ', sort @i;
            }
        };

        /Darwin|FreeBSD|Linux/ && do {
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
                $p->{'kernel'} =~ /Darwin|FreeBSD/ && do {
                    $d = $1 if /^(\w+)\:/;
                    push @i, "$d=$1" if /ether\s+(\w+\:\w+\:\w+\:\w+\:\w+\:\w+)/;
                };

                $p->{'kernel'} =~ /Linux/ && do {
                    $d = $1 if ( /^(\w+)\s+/ || /^(\w+:\d+)\s+/ );
                    push @i, "$d=$1" if /HWaddr\s+(\w+\:\w+\:\w+\:\w+\:\w+\:\w+)/;
                };
            }

            return join ' ', sort @i;
        };

        return qq((kernel not supported));
    }
}

1;
