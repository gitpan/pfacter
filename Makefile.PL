#!/usr/bin/perl

use strict;
use ExtUtils::MakeMaker;

WriteMakefile( NAME            => 'Pfacter',
               VERSION_FROM    => 'pfacter',
               EXE_FILES       => [ 'pfacter' ],
               PREREQ_PM       => {
                   'Getopt::Long' => 0
               },
               ABSTRACT_FROM   => 'pfacter',
               AUTHOR          => 'Scott Schneider <scott@loserfish.org>'
);
