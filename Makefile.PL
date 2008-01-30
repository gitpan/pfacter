use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'Pfacter',
    VERSION_FROM    => 'pfacter',
    EXE_FILES       => [ 'pfacter' ],
    PREREQ_PM       => {
        'Getopt::Long' => 0,
    },
    ABSTRACT        => 'Collect and display facts about the system'
    AUTHOR          => 'Scott Schneider <sschneid@gmail.com>'
);

