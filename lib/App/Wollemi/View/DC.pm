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
    my $stash = {
        c => $c,
        %{ $c->stash }
    };

    my $file = $c->request->uri->path;
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
    elsif ( $c->request->params->{bem} ) {
        $get = $c->request->params->{bem_type}
            ? 'get_' . $c->request->params->{bem_type}
            : 'get';
    }

    my $output = $dc->$get( $path, $stash );

    if ( $get eq 'get' ) {
        $output = JSON->new->utf8->shrink->encode($output);
    }

    $c->response->body( $output );

    $c->response->content_type(
        $get eq 'get_html'      ? 'text/html'
        : $get eq 'get_scripts' ? 'text/javascript'
        : $get eq 'get_styles'  ? 'text/css'
        : $get eq 'get'         ? 'application/json'
        :                         die "Unknown type"
    );

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

Ivan Wills

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

