package App::Wollemi::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'App::Wollemi::Schema',

    connect_info => {
        dsn => 'dbi:Pg:dbname=wollemi',
        user => '',
        password => '',
    }
);

=head1 NAME

App::Wollemi::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<App::Wollemi>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<App::Wollemi::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Work Wills

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
