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
# Title:    CSV to TM3
#
# File:     csv2tm3.pl
#
# Updates
# 
# 11/5/15   Fixing output so that trailing tabs are inserted for short line
#

use strict vars;

my @out;
my $firstLine = 1;
my $longest = 0;
while (<STDIN>) {
    chomp;
    my $line = $_;

    my @tokens = split /,/,$line;
    $_ = $line;
    s/,/\t/g;
    push (@out,$_);
    if (scalar(@tokens) > $longest) { $longest = scalar(@tokens); print $longest; }
}
# print header line first
print "COUNT";
for (my $x=1; $x<=$longest; $x++) {
    print "\tCOL".$x;
}
print "\nINTEGER";
for (my $x=1; $x<=$longest; $x++) {
    print "\tSTRING";
}
print "\n";

my %unique = ();
foreach my $item (@out)
{
    $unique{$item} ++;
}

for my $line (sort keys %unique) {
    my $tokens = scalar(split/\t/,$line);
    my $residual;
    if ($tokens < $longest) { $residual = "\t" x ($longest-$tokens);}
    print $unique{$line}."\t".$line.$residual."\n";
}

