use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'App::Wollemi',
    license           => 'perl',
    dist_author       => 'Ivan Wills <ivan.wills@gmail.com>',
    dist_version_from => 'lib/App/Wollemi.pm',
    requires          => {
        perl                               => 5.008,
        'Catalyst::Action::RenderView'     => 0,
        'Catalyst::Plugin::ConfigLoader'   => 0,
        'Catalyst::Plugin::Static::Simple' => 0,
        'Catalyst::Runtime'                => '5.90015',
        'Config::General'                  => 0,
        'Contextual::Return'               => 0,
        'Data::Context'                    => '0.0.6',
        'Moose'                            => 0,
        'namespace::autoclean'             => 0,
        'Path::Class'                      => '0.16',
        'version'                          => 0,
    },
    configure_requires => {
        'Module::Build' => 0.38,
    },
    build_requires => {
        'Test::More'           => 0,
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