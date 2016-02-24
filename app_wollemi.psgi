use strict;
use warnings;
use lib qw/lib/;

use App::Wollemi;

my $app = App::Wollemi->apply_default_middlewares(App::Wollemi->psgi_app);
$app;

