#!/usr/bin/perl

use strict;
use warnings;
use 5.006;

use ExtUtils::MakeMaker;

die "OS unsupported" if( $^O eq 'MSWin32' );

WriteMakefile(
    AUTHOR              => 'Barbie <barbie@cpan.org>',
    NAME                => 'cpan-testers-autorun',
    VERSION             => '1.01',
    ABSTRACT            => 'Scripts used to provide backend functionality for CPAN Testers',
    NO_META             => 1,
    PREREQ_PM => {

        # prereqs
        'CPAN::Testers::Data::Generator'        => 1.21,
        'CPAN::Testers::Data::Uploads'          => 0.21,
        'CPAN::Testers::Data::Uploads::Mailer'  => 0.06,

        'CPAN::Testers::WWW::Development'       => 2.09,
        'CPAN::Testers::WWW::Reports'           => 3.60,
        'CPAN::Testers::WWW::Reports::Mailer'   => 0.33,
        'CPAN::Testers::WWW::Statistics'        => 1.23,
        'CPAN::Testers::WWW::Statistics::Excel' => 0.06,

    },
);
