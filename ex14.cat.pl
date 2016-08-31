#!/usr/bin/env perl
$haha = $#ARGV+1;
for ($i = 0; $haha > 0; $i++) {
    open my $file, '<', $ARGV[$i]
        or die ":c \n";
    while (my $line = <$file>) {
        print $line;
    }
    --$haha;
}
