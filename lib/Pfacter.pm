package Pfacter;

sub modulelist {
    my $self   = shift;
    my $kernel = shift;

    my @modules = qw(
    
        architecture
        disk
        domain
        fqdn
        hardwaremanufacturer
        hardwaremodel
        hardwareplatform
        hardwareproduct
        hostname
        ipaddress
        kernel
        kernelrelease
        kernelversion
        localtime
        macaddress
        memory
        memorytotal
        operatingsystem
        processor
        processorcount
        serialnumber
        uniqueid

    );

    # Kernel-specific
    for ( $kernel ) {
        /Linux/ && do {
            push @modules, qw(

                lsbdescription
                lsbid
                lsbrelease

            );
        };
    }

    # Application-specific
    if ( -e '/var/cfengine/bin/cfagent' ) {
        push @modules, qw(

            cfclasses
            cfversion

        );
    }

    return sort @modules;
}

1;
