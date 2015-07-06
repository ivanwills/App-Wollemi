use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'App::Wollemi',
    license           => 'perl',
    dist_author       => 'Ivan Wills <ivan.wills@gmail.com>',
    dist_version_from => 'lib/App/Wollemi.pm',
    requires          => {
        'perl'                             => '5.006',
        'Catalyst'                         => '5.90053',
        'Catalyst::Action::RenderView'     => 0,
        'Catalyst::Model'                  => 0,
        'Catalyst::Plugin::ConfigLoader'   => 0,
        'Catalyst::Plugin::Static::Simple' => 0,
        'Catalyst::Runtime'                => '5.90015',
        'Catalyst::ScriptRunner'           => 0,
        'Catalyst::Test'                   => 0,
        'Catalyst::View'                   => 0,
        'Config::General'                  => 0,
        'Contextual::Return'               => 0,
        'Data::Context'                    => '0.0.6',
        'Data::Context::BEM'               => '0.0.2',
        'JSON'                             => 0,
        'Moose'                            => '2.0',
        'namespace::autoclean'             => 0,
        'version'                          => 0,
    },
    configure_requires => {
        'Module::Build' => 0.38,
    },
    build_requires => {
        'Test::More'           => '0.88',
        'Test::NoWarnings'     => 0,
        'Test::MinimumVersion' => 0,
    },
    add_to_cleanup     => [ 'App-Wollemi-*' ],
    create_makefile_pl => 'traditional',
    create_license     => 1,
    meta_merge         => {
        resources => {
            repository => 'http://github.com/ivanwills/App-Wollemi',
            bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-Wollemi',
        },
    },
);

$builder->create_build_script();
