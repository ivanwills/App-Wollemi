package App::Wollemi::Model::MongoDB;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

=head1 NAME

App::Wollemi::Model::MongoDB - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

Ivan Wills

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
