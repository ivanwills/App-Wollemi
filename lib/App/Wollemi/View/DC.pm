package App::Wollemi::View::DC;
use Moose;
use namespace::autoclean;
use Data::Context;
use JSON;

extends 'Catalyst::View';

has dc => (
    is      => 'rw',
    isa     => 'Data::Context',
);

sub process {
    my ($self, $c, @args) = @_;
    my $dc = $self->dc || $self->init_dc($c);

    $c->log->info(Dumper $dc, $c->request->uri->path);
    my $dc_data = $dc->get( $c->request->uri->path, $c->stash );

    $c->response->body(JSON->new->utf8->shrink->encode($dc_data) );

    return;
}

sub init_dc {
    my ($self, $c) = @_;

    my $dc = Data::Context->new( $c->config->{'Data::Context'} );
    $self->dc($dc);

    return $dc;
}

__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

App::Wollemi::View::DC - Catalyst View

=head1 DESCRIPTION

Catalyst View.

=head1 AUTHOR

ivan,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

