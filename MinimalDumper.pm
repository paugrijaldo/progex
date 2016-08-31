#!/usr/bin/env perl
package MinimalDumper;
use strict;
use Scalar::Util qw(refaddr);
use Exporter qw(import);
our @EXPORT = qw(Dumper);
 
sub Dumper {
    my (@list) =  @_;
    my $out =  "";
    my $counter = 1;
    my $counter2 = 0;
	my %hash;

    foreach my $yay (@list) {
        if (ref($yay) eq 'HASH') {
            my $temp = Dumper(%$yay);
	        my $print = pretty_print('hash', $temp);
            if ($hash{refaddr($yay)}) {
				$out .= "\$VAR$counter";
			} else {
				$out .= "\$VAR$counter = $print;\n";
				$hash{refaddr($yay)} =  '$VAR'.$counter.'->{'.$counter2.'}';
				$counter2++;
        	}
		} elsif (ref($yay) eq 'ARRAY') {
            my $temp = Dumper(@$yay);
            my $print = pretty_print('array', $temp);
            if ($hash{refaddr($yay)}) {
				$out .= $hash{refaddr($yay)};
			} else {
				$out .= "\$VAR$counter = $print;\n";
				$hash{refaddr($yay)} =  '$VAR'.$counter.'->['.$counter2.']'; 
				$counter2++;
        	}
        } elsif (ref($yay) eq 'SCALAR') {
    	    $out = $out . Dumper($$yay) . ";";
        } elsif (ref($yay) eq 'REF') { 
		    #self-referential akfkf	
			$out = "sdfffffff\n";
		} else {
	    print ref($yay);
            $out .= "\$VAR$counter = '$yay'; \n";
        }
        $counter++;
    }
    return $out;
}

sub pretty_print {
    my ($haha1, $haha2) = @_;
    my $out = "";
    $_ = $haha2;
    s/(\$VAR[0-9]+ = )//gi;
    s/(;)//gi;
    my @hi= split("\n", $_);

    if ($haha1 eq 'hash') {
        my $counter = 1;
        $out .= "{";
        foreach my $a (@hi) {
            if (($counter % 2) eq 0) {
                $out .= "=> $a";
                if ($a ne $hi[-1]) {
                    $out .= ",";
                } 
				#$out .= "\n";
            } else {
                $out .= " $a";
            }
            ++$counter; 
        } 
        $out .= "}";
    } elsif ($haha1 eq 'array') {
        $out .= "[";
        foreach my $a (@hi) {         
            $out .= "$a";
            if ($a ne $hi[-1]) {
                $out .= ",";
            }
			#$out .= "\n";
        }
        $out .= "]";
      
    }
    $_ = $out;
#	s/(\n)/\n\t/gi;
#	s/(\t\t)/\t /gi;
#	s/([\t]+$)//gi;
    return $_;
}
