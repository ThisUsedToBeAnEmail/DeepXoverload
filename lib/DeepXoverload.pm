package DeepXoverload;

use 5.006;
use strict;
use warnings;
use UNIVERSAL::Object;
use Scalar::Util qw/reftype blessed/;

use overload "x" => "deepx";

our @ISA;
BEGIN { @ISA = 'UNIVERSAL::Object' }

our %HAS;

BEGIN {
    %HAS = (
        data  => sub { '' },
        store => sub { [] },
        stash => sub { {} },
    );
}

sub deepx {
    my ( $obj, $times ) = @_;

    my @array;
    for ( 1 .. $times ) {
        my $copy = _copy($obj);
        push @array, $copy;
    }
    return \@array;
}

sub _copy {
    my ($to_copy) = @_;

    my $blessed = blessed $to_copy;
    my $copy    = _deep_copy($to_copy);
    return $blessed ? bless $copy, $blessed : $copy;
}

sub _deep_copy {
    my ($to_copy) = @_;
    if ( reftype( \$to_copy ) eq 'SCALAR' ) {
        return $to_copy;
    }
    elsif ( reftype($to_copy) eq 'HASH' ) {
        return { map +( $_ => _copy( $to_copy->{$_} ) ), keys %$to_copy };
    }
    elsif ( reftype($to_copy) eq 'ARRAY' ) {
        return [ map _copy($_), @$to_copy ];
    }
    return $to_copy;
}

sub data {
    return $_[0]->{data};
}

1;

__END__

=head1 NAME

DeepXoverload - The great new DeepXoverload!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use DeepXoverload;

    my $foo = DeepXoverload->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

LNATION, C<< <thisusedtobeanemail> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-deepxoverload at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=DeepXoverload>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc DeepXoverload


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=DeepXoverload>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/DeepXoverload>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/DeepXoverload>

=item * Search CPAN

L<http://search.cpan.org/dist/DeepXoverload/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2017 LNATION.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of DeepXoverload
