package Pfacter::fqdn;

sub pfact {
    my $self  = shift;
    my ( $p ) = shift->{'pfact'};

    unless ( $p->{'domain'} ) {
        return qq((domain not set));
    }

    return $p->{'hostname'} . '.' . $p->{'domain'};
}

1;
