package Vurl::Command::Maths;

use strict;
use warnings;

use List::Util qw(sum0);

# qr// gets messed up if you use a hash so don't
my @commands;

sub import {
    my $caller = (caller)[0];

    $caller->declare_command($_->[0], $_->[1]) for @commands;
}

push @commands, [ add => sub {
    my ($self, $cmd, $message) = @_;

    return sum0(split ' ', $message);
}];


1;
