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

        /Linux/ && do {
            my ( $c ) = 0;

            open( F, '/proc/cpuinfo' );
            my ( @F ) = <F>;
            close( F );

            foreach ( @F ) { $c = $1 if /model name\s+:\s+(.+?)$/; }

            $c =~ s/\s+$//;

            return $c;
        };

        return qq((kernel not supported));
    }
}

1;
