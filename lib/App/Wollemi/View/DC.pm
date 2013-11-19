package App::Wollemi::View::DC;
use Moose;
use namespace::autoclean;
use Data::Context::BEM;
use JSON;

extends 'Catalyst::View';

has dc => (
    is      => 'rw',
    isa     => 'Data::Context::BEM',
);

sub process {
    my ($self, $c, @args) = @_;
    my $dc = $self->dc || $self->init_dc($c);

    my $file = 'root' . $c->request->uri->path;
    $c->log->info($file);
    if ( -f $file ) {
        $c->response->body( 'Page not found' );
        $c->response->status(404);
        return;
    }

    my $path = $c->request->uri->path;
    $path .= 'index' if $path =~ m{/$};

    my $get = 'get_html';

    if ( my ($type) = $path =~ /[.](css|js)$/ ) {
        $get = 'get_' . ( $type eq 'js' ? 'scripts' : 'styles' );
    }
    elsif ( $c->request->params->{bem} && $c->request->params->{bem_type} ) {
        $get = 'get_' . $c->request->params->{bem_type};
    }

    $c->response->content_type(
        $get eq 'get_html'      ? 'text/html'
        : $get eq 'get_scripts' ? 'text/javascript'
        : $get eq 'get_styles'  ? 'text/css'
        :                         die "Unknown type"
    );

    my $output = $dc->$get( $path, $c->stash );

    $c->response->body( $output );
    return;

    my $dc_data = $dc->get( $c->request->uri->path, $c->stash );

    $c->response->content_type('application/json');
    $c->response->body( JSON->new->utf8->shrink->encode($dc_data) );

    return;
}

sub init_dc {
    my ($self, $c) = @_;

    my $dc = Data::Context::BEM->new(
        %{ $c->config->{'Data::Context::BEM'} },
        log => $c->log,
    );
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

