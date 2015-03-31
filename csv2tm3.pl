#!/usr/bin/perl
#
# Copyright (c) 2007 by Raffael Marty
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#  
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# Title: 	CSV to TM3
#
# File: 	csv2tm3.pl
#
use strict vars;

my @out;
my $firstLine = 1;
while (<STDIN>) {
    chomp;
	my $line = $_;

    my @tokens = split /,/,$line;
    # print header line first
    if ($firstLine) {
        print "COUNT";
        my $x = 1;
        for my $t (@tokens) {
            print "\tCOL".$x++;
        }
        print "\nINTEGER";
        for my $t (@tokens) {
            print "\tSTRING";
        }
        print "\n";
        $firstLine = 0;
    } 
    $_ = $line;
    s/,/\t/g;
    push (@out,$_);
}
my %unique = ();
foreach my $item (@out)
{
    $unique{$item} ++;
}
for my $line (sort keys %unique) {
    print $unique{$line}."\t".$line."\n";
}
