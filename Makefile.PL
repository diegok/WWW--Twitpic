use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::Twitpic',
    AUTHOR              => 'Diego Kuperman <diego@freekeylabs.com>',
    VERSION_FROM        => 'lib/WWW/Twitpic.pm',
    ABSTRACT_FROM       => 'lib/WWW/Twitpic.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-Twitpic-*' },
);
