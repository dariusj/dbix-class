use strict;
use warnings;

use Test::More;
use Test::Warn;
use lib qw(t/lib);
use DBICTest;

my $schema = DBICTest->init_schema();

my $cd_rs = $schema->resultset("CD");

warnings_exist( sub {
    $cd_rs->search_rs( undef, { cols => [ { name => 'artist.name' } ], join => [ 'artist' ] })
}, qr/Resultset specifies the 'cols' attribute/,
'deprecation warning when passing include_cols attribute');

warnings_exist( sub {
    $cd_rs->search_rs( undef, {
        include_columns => [ { name => 'artist.name' } ], join => [ 'artist' ]
    })
}, qr/Resultset specifies the 'include_columns' attribute/,
'deprecation warning when passing include_columns attribute');

done_testing;
