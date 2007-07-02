package Pfacter::operatingsystem;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    for ( $p->{'kernel'} ) {
        /AIX/ && do {
            return 'AIX'
        };

        /Darwin/ && do {
            return 'OSX'
        };

        /FreeBSD/ && do {
            return 'FreeBSD'
        };

        /Linux/ && do {
            if    ( -e '/etc/debian_version' ) { return 'Debian' }
            elsif ( -e '/etc/gentoo-release' ) { return 'Gentoo' }
            elsif ( -e '/etc/fedora-release' ) { return 'Fedora' }
            elsif ( -e '/etc/redhat-release' ) { return 'RedHat' }
            elsif ( -e '/etc/SuSE-release' )   { return 'SuSE' }
        };

        /SunOS/ && do {
            return 'Solaris'
        };

        return qq((kernel not supported));
    }
}

1;
