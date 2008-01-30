package Pfacter::disk;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            my ( @i );
            if ( -e '/usr/sbin/lspv') {
                open( F, '/usr/sbin/lspv 2> /dev/null |' );
            }
            else {
                return qq((kernel not supported));
            }

            my ( @F ) = <F>;
            close( F );

            foreach ( @F ) {
                if ( /^(\w+)\s+/ ) {
                    my $d = $1;

                    open( F2, "/usr/sbin/lspv $d 2> /dev/null |" );
                    my ( @F2 ) = <F2>;
                    close( F2 );

                    foreach ( @F2 ) {
                        if ( /TOTAL PPs:\s+\d+\s+\((.*)\)/ ) {
                            my $i = $1;
                            $i =~ s/megabytes/m/g;
                            $i =~ s/\s//g;
                            push @i, "$d=$i";
                        }
                    }
                }
            }

            return join ' ', sort @i;
        };

        /Darwin/ && do {
            if ( -e '/usr/sbin/diskutil' ) {
                open( F, '/usr/sbin/diskutil list 2>/dev/null |' );
                my ( @F ) = <F>;
                close( F );

                foreach ( @F ) {
                    if ( /\s+0:/ ) {
                        my ( $d, $i );
                        if ( /(disk\d+)/ ) { $d = "/dev/$1"; }
                        if ( /\*(.*)B/ )   { $i = $1; }

                        $i =~ s/ M/m/;
                        $i =~ s/ G/g/;

                        push @i, "$d=$i";
                    }
                }

                return join ' ', sort @i;
            }
        };

        /Linux/ && do {
            my ( @i );

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
