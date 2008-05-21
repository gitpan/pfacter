package Pfacter::swap;

#

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    my ( $r );

    for ( $p->{'kernel'} ) {
    /AIX/ && do {
            if ( -e '/usr/sbin/lsps' ) {
                open( F, '/usr/sbin/lsps -s |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    if ( /(\d+)(\w+)\s+\d+/ ) {
                        my $s = $1;
                        my $u = $2;

                        if ( $u eq 'MB') { $r = $s*1024; last; }
                    }
                }
            }
        };

        /Linux/ && do {
            if ( -e '/proc/meminfo' ) {
                open( F, '/proc/meminfo' );
                my ( @F ) = <F>;
                close( F );
 
                foreach ( @F ) {
                    if ( /SwapTotal:\s+(\d+)\s+\w+/ ) { $r = $1; last; }
                }
            }
        };

        if ( $r ) { return( $r ); }
        else      { return( 0 ); }
    }
}

1;
