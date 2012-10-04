use strict;
use warnings;
use Test::More;
use Test::MockObject;
use Data::Section::Simple;

use Apache2::RequestUtil;
use Apache2::Data::Section::Simple;

my $mock = Test::MockObject->new;
$mock->fake_module(
    'Apache2::RequestUtil',
    request => sub { bless {}, 'Request::Dummy' }
);

$mock->fake_module(
    'Request::Dummy',
    filename => sub { $0 }
);

my $expected = Data::Section::Simple::get_data_section;

subtest 'OO style' => sub {
    my $dss = new_ok 'Apache2::Data::Section::Simple';
    my $got = $dss->get_data_section;
    is_deeply $got, $expected, 'data section ok'
        or diag explain $got;
};

subtest 'Functional style' => sub {
    my $got = Apache2::Data::Section::Simple::get_data_section;
    is_deeply $got, $expected, 'data section ok'
        or diag explain $got;
};

done_testing;

__DATA__

@@ foo

This is foo.

@@ bar

This is bar.
