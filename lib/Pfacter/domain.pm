package Pfacter::domain;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        my ( $d );

        /AIX|FreeBSD|Linux/ && do {
            if ( -e '/bin/hostname' ) {
                return $1 if qx( /bin/hostname ) =~ /\w+\.(.+?\.[a-z]{3})$/;
            }
        };

        /Linux/ && do {
            if ( -e '/bin/dnsdomainname' ) {
                open( F, '/bin/dnsdomainname |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    $d = $1 if /^(.*\.[a-z]{3})$/;
                }

                return $d if $d;
            }
        };

        /AIX|Linux/ && do {
            if ( -e '/etc/resolv.conf' ) {
                open( F, '/etc/resolv.conf' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    $d = $1 if /domain\s+(.*\.[a-z]{3})/;
                }

                return $d if $d;
            }
        };

        /AIX|FreeBSD|Linux/ && do {
            return qq((domain not set));
        };

        return qq((kernel not supported));
    }
}

1;
