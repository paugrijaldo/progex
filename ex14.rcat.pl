#!/usr/bin/env perl
use Data::Dumper;
my @arrayyy;
$haha = $#ARGV+1;
if ($haha ne 1) {
    die "Error: 1 argument only";
}
while (my $line = <>) {       
    push @arrayyy, $line;
}
while (scalar @arrayyy) {
    print pop @arrayyy;
}
