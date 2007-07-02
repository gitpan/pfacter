package Pfacter::hostname;

sub pfact {
    my ( $r );

    if ( -e '/bin/hostname' ) {
        $r = qx( /bin/hostname );
    }

    if ( $r ) {
        chomp( $r );

        $r = $1 if $r =~ /^(\w+)\..*$/;

        return $r;
    }
    else {
        return qq((kernel not supported));
    }
}

1;
