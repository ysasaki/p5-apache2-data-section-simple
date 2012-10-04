use 5.010000;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME           => 'Apache2::Data::Section::Simple',
    VERSION_FROM   => 'lib/Apache2/Data/Section/Simple.pm',
    ABSTRACT_FROM  => 'lib/Apache2/Data/Section/Simple.pm',
    AUTHOR         => 'Yoshihiro Sasaki <ysasaki at cpan.org>',
    LICENSE        => 'perl',
    PREREQ_PM      => {
        'Apache2::RequestUtil'  => 0,
    },
    BUILD_REQUIRES => {
        'Test::MockObject'      => 0,
        'Data::Section::Simple' => 0,
    },
    META_MERGE     => {
        resources => {
            license => 'http://dev.perl.org/licenses/',
            bugtracker =>
                'https://github.com/ysasaki/p5-apache2-data-section-simple/issues',
            repository => 'git://github.com/ysasaki/p5-apache2-data-section-simple.git',
        },
        release_status => 'unstable',
    },
);
