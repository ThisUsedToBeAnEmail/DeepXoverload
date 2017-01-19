use DeepXoverload;
use Test::More;
my $base = DeepXoverload->new({ data => 'Base Element' });

my $z = 'Base Element';
my $x = 'something else';

is($base->data, $z, "expecting $z");

my $copies = $base x 5;
is(scalar @$copies, 5, 'count 5');

is($copies->[0]->{data}, $z, "expecting $z");

$copies->[0]->{data} = 'something else';

is($copies->[0]->data, $x, "expecting $x");

is($copies->[1]->data, $z, "expecting $z");

$base->{store} = $copies;

my $ok = $base x 5;

is(scalar @$ok, 5, 'count 5');

$copies->[1]->{data} = $x;

is($copies->[0]->data, $x, "expecting $x");
is($copies->[1]->data, $x, "expecting $x");

is($ok->[0]->{store}->[0]->data, $x, "expecting $x");
is($ok->[0]->{store}->[1]->data, $x, "expecting $x");

done_testing();
