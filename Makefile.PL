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
);
