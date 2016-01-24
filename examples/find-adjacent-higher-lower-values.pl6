#!/usr/bin/env perl6

use v6;

=begin pod
=head1 NAME

find-adjacent-higher-lower-values.pl6

=head1 DESCRIPTION

For a given array of integers find the nearest higher and lower
values for a single integer value.

=head1 SYNOPSIS

	find-adjacent-nums([10,20,30,40,50], 33).say;
  # output
  closest => 30, higher => 40, lower => 30 

=head1 AUTHOR

Sam Morrison

=head1 LICENSE

This script is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

sub find-adjacent-nums (@nums, Int $num) {
  my ($max, $min) = [@nums.max, @nums.min];
  my $num_count = @nums.elems;
  my %results = lower => $min,
                higher => $max,
                closest => $num;
  
	for @nums.sort.kv -> $i, $v {
    if ($num >= $v) { %results<lower> = $v; };
    if ($num <= $v) { %results<higher> = $num < $min ?? @nums[$i+1] !! @nums[$i]; last; };
  };

  %results<closest> = ($num - %results<lower>).abs < (%results<higher> - $num).abs ?? %results<lower> !! %results<higher>;

  return %results;

}

my @nums = [100,103...130];
my @ints = [100...125];

@nums.say;
@nums.elems.say;
for @ints {
	"For $_: ".say;
	find-adjacent-nums(@nums,$_).say;
}
