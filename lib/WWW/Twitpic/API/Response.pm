package WWW::Twitpic::API::Response;
use Moose;

use XML::Simple;
use Data::Dumper;

=head1 NAME

WWW::Twitpic::API::Response - A response from Twitpic

=cut

has 'xml' => (
    is      => 'rw',
    isa     => 'Str',
    trigger => sub { $_[0]->struct( XMLin( $_[1] ) ) }
);

has 'struct' => (
    is        => 'rw',
    isa       => 'HashRef',
    predicate => 'has_struct'
);

=head1 SYNOPSIS


=head1 METHODS

=cut

=head2 is_success

=cut
sub is_success {
    my $self = shift; 
    
    if ( my $status = $self->struct->{'status'} || $self->struct->{'stat'} ) {
        return $status eq 'ok';
    }
    return 0;
}

=head2 error

=cut
sub error {
    my $self = shift; 

    unless ( $self->is_success ) {
        if ( exists $self->struct->{'err'}{msg} ) {
            return $self->struct->{'err'}{msg};
        }
    }

    return undef;
}

sub dump {
    my $self = shift;
    
    return Dumper( $self->struct );
}

sub url {
    my $self = shift;
    
    return $self->is_success ? URI->new( $self->struct->{mediaurl} ) : undef; 
}

sub id {
    my $self = shift;
    
    return $self->is_success ? $self->struct->{mediaid} : undef; 
}
=head1 AUTHOR

Diego Kuperman, C<< <diego at freekeylabs.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-twitpic-api at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Twitpic>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Twitpic


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Twitpic>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Twitpic>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Twitpic>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Twitpic>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Diego Kuperman, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1;
