package Pfacter::kernel;

sub pfact {
    my ( $r );

    if ( -e '/bin/uname' ) {
        $r = qx( /bin/uname -s );
    }
    elsif ( -e '/usr/bin/uname' ) {
        $r = qx( /usr/bin/uname -s );
    }

    if ( $r ) {
        chomp( $r );

        return $r;
    }
    else {
        die qq(Kernel not supported.\n);
    }
}

1;
