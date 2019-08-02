#!/usr/bin/perl

use strict;
use warnings;

# shuffler.pl - prefixes all files in a directory with a random, zero padded 5
# digit number <= number of files in that directory.

# usage: shuffler.pl <dir> [ <dir> ... ]

use File::Copy;

while ( my $dir = shift @ARGV )
  {
  opendir DIR, $dir or die "Couldn't opendir $dir: $!\n";

  my $names;
  my @entries = readdir DIR;
  my @res;

  my $num;

  foreach my $entry (@entries)
    {
    if ( ( $entry eq ".." ) || ( $entry eq "." )  ) { next; }

    my $side = int(rand(2));

    if ( $side == 1 )
      {
      unshift @res, $entry;
      }

    if ( $side == 0 )
      {
      push @res, $entry;
      }
    }

  for (my $i=0; $i < scalar(@res); $i++)
    {
    my $old = $res[$i];
    my $raw_new = $old;
    $raw_new =~ s/^\d+__//;

    my $new = sprintf("%.5d__$raw_new", $i); 
    print "$old -> $new\n";
    move("$dir/$old", "$dir/$new");
    }
  }
