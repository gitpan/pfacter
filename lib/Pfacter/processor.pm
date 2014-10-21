package Pfacter::processor;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            if ( -e '/usr/sbin/lsattr' ) {
                open( F, '/usr/sbin/lsattr -El proc0 |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;

            close( F );

            my ( $n ) = 0;

            foreach ( @F ) {
                if ( /type\s+(.+?)\s/ ) { $n = $1; last; }
            }

            $n =~ s/\s+$//;

            return $n;
        };

        /Darwin/ && do {
            if ( -e '/usr/bin/hostinfo' ) {
                open( F, '/usr/bin/hostinfo |' );
                my ( @F )  = <F>;
                close( F );

                foreach ( @F ) {
                    return $1 if /Processor\stype:\s(.*)/;
                }
            }
        };

        /Linux/ && do {
            my ( $c ) = 0;

            open( F, '/proc/cpuinfo' );
            my ( @F ) = <F>;
            close( F );

            foreach ( @F ) { $c = $1 if /model name\s+:\s+(.+?)$/; }

            $c =~ s/\s+$//;

            return $c;
        };

        /SunOS/ && do {
            if ( -e '/usr/sbin/prtdiag' ) {
                open( F, '/usr/sbin/prtdiag |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    return $1 if /SUNW,(.+?)\s+\d+/;
                }
            }
        };

        return qq((kernel not supported));
    }
}

1;
