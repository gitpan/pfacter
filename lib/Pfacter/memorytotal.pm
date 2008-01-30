package Pfacter::memorytotal;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            if ( -e '/usr/sbin/lsattr' ) {
                my ( $m ) = 0;

                open( F, '/usr/sbin/lsattr -El sys0 |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) { $m = $1 if /realmem\s+(\d+)/; }

                return $m;
            }
        };

        /Darwin/ && do {
            if ( -e '/usr/bin/hostinfo' ) {
                open( F, '/usr/bin/hostinfo |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    if ( /Primary\smemory\savailable:\s(.*)/ ) {
                        my $m = $1;

                        $m =~ s/\smegabytes/m/g;
                        $m =~ s/\sgigabytes/g/g;

                        $m =~ s/\.00//g;

                        return $m;
                    }
                }
            }
        };

        /FreeBSD/ && do {
            if ( -e '/sbin/dmesg' ) {
                my ( $m ) = 0;

                open( F, '/sbin/dmesg |' );
                my ( @F ) = <F>;
                close ( F );

                foreach ( @F ) { $m = $1 if /real memory.+?(\d+)K/; }

                return $m;
            }
        };

        /Linux/ && do {
            if ( -e '/proc/meminfo' ) {
                my ( $m ) = 0;

                open( F, '/proc/meminfo' );
                my ( @F ) = <F>;
                close( F );
 
                foreach ( @F ) { $m = $1 if /MemTotal:\s+(\d+)\s+\w+/; }

                return $m;
            }
        };

        return qq((kernel not supported));
    }
}

1;
