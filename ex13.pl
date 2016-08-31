#!/usr/bin/env perl
#use Data::Dumper;
use MinimalDumper;
my $scalar = 333;
my %hash = ("1" => "a", "2" => "b");
my %hash2 = ("2" => "c", "3" => "d");
my %hash3 = ("4" => \%hash, "5" => \%hash);
my @array = ('hello', 'hi');
my @test = ("hi", \$scalar);
my @arr = (\%hash, \%hash2);
my @arr2 = (\@array, \@array);
my @arr3 = (\@arr, \@arr2);

print (Dumper(%hash));
print (Dumper(@arr3));
print (Dumper(@arr));
print (Dumper($scalar));
print (Dumper(%hash));
print (Dumper(@hi));
print (Dumper(\%hash3));
print eval(Dumper(\@array));
print eval(Dumper(\%hash));
print eval(Dumper(%hash));
print eval(Dumper(@arr3));
print eval(Dumper(@arr));
print eval(Dumper($scalar));
print eval(Dumper(%hash));
print eval(Dumper(\%hash3));
