#!/usr/bin/env perl
my $yay = 1;
my $counter = 0;
my $temp = 0;
my $out = "";

printf("%08X  ", $counter);
while (my $line = <>) {
    my @words = split("", $line); #split to get each individual character
    foreach $char (@words) {
        my $test = unpack("H*", $char);
        chomp($temp = $temp . $char);
        print "$test ";
        $out .= "$test ";
        if ($yay eq 8) {
            print " ";
	        $out .= " ";
            $yay += 1;
        } elsif ($yay eq 16) {
            print " |$temp|\n";
	        $out .= " |$temp|\n";
            $counter += 16;
            printf("%08X  ", $counter);
            $temp = "";
            $yay = 1;
        } else {
           $yay += 1;
        }
    }
} 

print "|$temp |";

print "\n";
close $file;

open my $file, '>', 'hexdump.txt'
    or die "aw";
print $file $out;
close $file;
