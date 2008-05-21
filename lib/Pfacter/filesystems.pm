package Pfacter::filesystems;

#

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    my ( $r );

    for ( $p->{'kernel'} ) {
        /Linux/ && do {
            my ( @l, @fs );

            foreach my $fstype ( qw/ ext2 ext3 reiserfs xfs / ) {
                if ( -e '/bin/mount' ) {
                    open( F, "/bin/mount -t $fstype |" );
                    foreach ( <F> ) { 
                        @l = split( / /, $_ );
                        push @fs, "$l[0]=$l[2]";
                    }
                    close( F );
                }
            }
            $r = join ( ' ', sort @fs );
        };

        /AIX/ && do {
            foreach my $fstype ( qw/ jfs2 / ) {
                if ( -e '/usr/sbin/lsfs' ) {
                    open( F, "/usr/sbin/lsfs -c -v $fstype |" );
                    foreach ( <F> ) {
                        next if /^#/;

                        @l = split( /:/, $_ );
                        push @fs, "$l[1]=$l[0]";
                    }
                    close( F );
                }
            }
            $r = join ( ' ', sort @fs );
        };

        if ( $r ) { return( $r ); }
        else      { return( 0 ); }
    }
}

1;
