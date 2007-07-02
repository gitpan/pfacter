package Pfacter::disk;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /Linux/ && do {
            my ( $d, @i );

            if ( -e '/sbin/fdisk' ) {
                open( F, '/sbin/fdisk -l 2> /dev/null |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;
            close( F );

            foreach ( @F ) {
                if ( /^Disk (.*):\s+(.*),/ ) {
                    my $d = $1;
                    my $i = $2;

                    $i =~ s/MB/m/;
                    $i =~ s/GB/g/;

                    $i =~ s/\s+//g;

                    push @i, "$d=$i";
                }
            }

            return join ' ', sort @i;
        };

        return qq((kernel not supported));
    }
}

1;
