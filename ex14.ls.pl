#!/usr/bin/env perl
use Cwd;
my $location = (@ARGV[0]) ? @ARGV[0] : cwd();
opendir my $dir, $location;
my $test = qr/^\./;
while (readdir $dir) {
    if ($_ =~ /($test)/) {
        print "";
    } else {
        print "$_ \t";  
    }
}
print "\n";
closedir $dir;
