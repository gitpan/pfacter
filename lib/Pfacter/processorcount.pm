package Pfacter::processorcount;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            if ( -e '/usr/sbin/lsdev' ) {
                my ( $c ) = 0;

                open( F, '/usr/sbin/lsdev -Cc processor |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) { $c++ if /Available/; }

                return $c;
            }
        };

        /FreeBSD/ && do {
            if ( -e '/sbin/dmesg' ) {
                my ( $c ) = 0;

                open( F, '/sbin/dmesg |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) { $c++ if /^CPU/; }

                return $c;
            }
        };

        /Linux/ && do {
            if ( -e '/proc/cpuinfo' ) {
                my ( $c ) = 0;

                open( F, '/proc/cpuinfo' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) { $c++ if /processor\s+:\s+(\d+)/; }

                return $c;
            }
        };

        /SunOS/ && do {
            if ( -e '/usr/sbin/psrinfo' ) {
                open( F, '/usr/sbin/psrinfo |' );
                my ( @F ) = <F>;
                close( F );

                return scalar @F;
            }
        };

        return qq((kernel not supported));
    }
}

1;
