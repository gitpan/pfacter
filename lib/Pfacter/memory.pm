package Pfacter::memory;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /Linux/ && do {
            if ( -e '/usr/sbin/dmidecode' ) {
                my ( $f );

                local $/;
                $/ = /^Handle \d+x/;

                open( F, '/usr/sbin/dmidecode 2>/dev/null |' );
                my ( @F ) = <F>;
                close( F );

                # Multi-version dmidecode compat
                if ( @F == 1 ) { @F = split /Handle/, $F[0]; }

                foreach ( @F ) {
                    my ( $l, $m );

                    if ( /Size:\s+(.*)\s+/ ) { $m = $1; }
                    if ( /Locator:.*(\d+)/ )  { $l = $1; }

                    next unless ( ( $l gt -1 ) && ( $m =~ /\d/ ) );

                    $m =~ s/MB/m/;
                    $m =~ s/GB/g/;

                    $m =~ s/\s+//g;

                    push @i, "$l=$m";
                }

                return join ' ', sort @i;
            }
        };

        return qq((kernel not supported));
    }
}

1;
