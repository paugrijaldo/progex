#!/usr/bin/env perl
use Date::Calc;
my $reg = qr/^\S*/;
my $reg2 = qr/\(([0-9]+\+)*[0-9]+:[0-9]+\)/; #regexp for muni nga format days+hours:min
my $reg3 = qr/\+/; #regexp mag check if may days
my %stuff;
my $users = {};
while (my $test = <>) {
    if ($test =~ /($reg)/) {
        my $username = $1;
        if ($stuff{$username}) {
            if ($test =~ /($reg2)/) {
                my $time1 = $stuff{$username};
                my $time2 = $1;
                $time2 =~ s/[()]//g; #remove ang parenthesis

                my @time1_new = split(":", $time1);
                my @time2_new = split(":", $time2);

                 if ($time1_new[0] =~ /($reg3)/) {                
                    @time1_new2 = split("\Q+", $time1_new[0]);                 
                 }
                 if ($time2_new[0] =~ /$reg3/) {
                    @time2_new2 = split("\Q+", $time2_new[0]);                
                 }

                $time1_days = 1;
                $time1_hours = $time1_new[0];
                $time1_minutes = $time1_new[1];               

                $time2_days = 1; 
                $time2_hours = $time2_new[0];
                $time2_minutes = $time2_new[1];
   
                if ($time1_new[0] =~ /($reg3)/) {
                    $time1_days += $time1_new2[0];
                    $time1_hours = $time1_new2[1];                  
                }                   
                 
                if ($time2_new[0] =~ /($reg3)/) {
                    $time2_days += $time2_new2[0];
                    $time2_hours = $time2_new2[1];
                }             
              # print "$username: ($time1_days-1) + $time2_days   $time1_hours + $time2_hours   $time1_minutes + $time2_minutes \n";
                @new_time = Date::Calc::XS::Add_Delta_DHMS(1996,1,$time1_days,  $time1_hours,$time1_minutes,0, +$time2_days,+$time2_hours,+$time2_minutes,0);      

                $new_time_joined = join(":", $new_time[3], $new_time[4]);
                $new_time[2] -= 2;
                if ($new_time[2] > 0) {
                    $new_time_joined = join("+", $new_time[2], $new_time_joined);
                }
                $stuff{$username} = $new_time_joined;
            }
        } else {
            if ($test =~ /($reg2)/) {
                my $time = $1;
                $time =~ s/[()]//g;
                $stuff{$username} = $time;
                push(@users, $username);
            }
        }
    }
}

foreach $u (@users) {
    print "$u $stuff{$u}\n";
}
