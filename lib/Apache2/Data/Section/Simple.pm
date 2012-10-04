package Apache2::Data::Section::Simple;

use 5.010000;
use strict;
use warnings;

use Apache2::RequestUtil;

use base qw(Exporter);
our @EXPORT_OK = qw(get_data_section);
 
sub new {
    my($class, $pkg) = @_;
    bless {
        r       => Apache2::RequestUtil->request,
        all     => undef,
    }, $class;
}
 
sub get_data_section {
    my $self = ref $_[0] ? shift : __PACKAGE__->new;
 
    if (@_) {
        return $self->get_data_section->{$_[0]};
    }

    my $all = $self->{all};

    # use cache
    return $all if $all;

    # read DATA section from current script
    my $data = $self->_slurp($self->{r}->filename);

    # copied from Data::Section::Simple
    $data =~ s/^.*\n__DATA__\n/\n/s; # for win32
    $data =~ s/\n__END__\n.*$/\n/s;
    my @data = split /^@@\s+(.+?)\s*\r?\n/m, $data;
    shift @data; # trailing whitespaces

    while (@data) {
        my ($name, $content) = splice @data, 0, 2;
        $all->{$name} = $content;
    }

    $self->{all} = $all;
    return $all;
}

sub _slurp {
    my $self = shift;
    my $filename = shift;

    open my $fh, '<', $filename or die "Cannot open $filename: $!";
    my $content = do { local $/; <$fh> };
    close $fh or die "Cannot close $filename: $!";

    return $content;
}
 
1;

__END__

=encoding utf-8

=for stopwords

=head1 NAME

Apache2::Data::Section::Simple - Read data from __DATA__ for mod_perl2

=head1 SYNOPSIS

    # in your script

    use strict;
    use warnings;
    use feature 'say';
    use CGI;
    use Apache2::Data::Section::Simple qw(get_data_section);

    my $r = shift;
    my $q = CGI->new($r);

    print $q->header( -type => 'text/plain', -charset => 'utf-8' );

    my $data = get_data_section();
    for ( keys %$data ) {
        say "-----------";
        say $_;
        say $data->{$_};
    }

    __DATA__

    @@ foo

    fooooooooooooo

    @@ bar

    baaaaaaaaaaaar

=head1 WARNING

B<This is an experimental module. You should not use this module>.

=head1 DESCRIPTION

Apache2::Data::Section::Simple is L<Data::Section::Simple> for mod_perl2. This is a simple module to extract data from C<__DATA__> section of the file.

This module's interface is same as L<Data::Section::Simple>.

=head1 AUTHOR

Yoshihiro Sasaki E<lt>ysasaki at cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2012 Yoshihiro Sasaki

Almost code of this module is based on Data::Section::Simple:
Copyright 2010- Tatsuhiko Miyagawa

And a part of Data::Section::Simple is based on Mojo::Command get_all_data:
Copyright 2008-2010 Sebastian Riedel

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Data::Section::Simple>

=cut
