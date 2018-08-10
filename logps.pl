#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: logps.pl
#
#        USAGE: ./logps.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Heince Kurniawan
#       EMAIL : heince.kurniawan@itgroupinc.asia
# ORGANIZATION: IT Group Indonesia
#      VERSION: 1.0
#      CREATED: 08/10/18 15:32:34
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

$SIG{INT}       = "catch_interrupt";
my $interval    = 10; #in seconds
my $output      = $ENV{HOSTNAME} . '_ps_output';
my @format      = qw/pid ppid priority flags state uid user vsize size rss pcpu stime time etime cmd/;
my $cmd         = 'ps -eo ' . join ',' => @format;

open my $fh, '>>', $output or die "$!\n";

while (1)
{
    my $result = `$cmd`;

    if ($? == 0)
    {
        print $fh 'itg-' . time . "\n";
        print $fh $result;
    }
    else
    {
        die "something wrong: $!\n";
    }

    sleep $interval;
}

close $fh;

sub catch_interrupt
{
    close $fh;
    exit 0;
}
