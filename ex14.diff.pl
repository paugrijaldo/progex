if (($#ARGV + 1) ne 2) {
    die "2 arguments :c";
}
my @file1;
my @file2;

open my $file1, '<', @ARGV[0]
    or die ":c";
open my $file2, '<', @ARGV[1]
    or die ":c";

while (my $line = <$file1>) {
    push @file1, $line;
}
while (my $line = <$file2>) {
    push @file2, $line;
}

if (scalar @file2 > scalar @file1) {
    $counter1 = scalar @file2;
    $counter2 = scalar @file1;
    my $test = \@file2;
} else {
    $counter1 = scalar @file1;
    $counter2 = scalar @file2;
    my $test = \@file1;
}

for ($j = 0; $j < $counter2; $j++) {
    if ($file1[$j] ne $file2[$j]) {
        print "- $file1[$j]";
        print "+ $file2[$j]";
    } else {
        print " $file1[$j]";
    }
}

for ($i = $counter2; $i < $counter1; $i++) {
    print "+ $$test[$i]"; 
} 
