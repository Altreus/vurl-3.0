package Vurl::Command::Util;

use strict;
use warnings;

sub import {
    my $caller = (caller)[0];

    $caller->declare_command(tell => \&tell);
    $caller->declare_autocommand(\&inform);
}

my %tell;
sub tell {
    my ($self, $command, $text) = @_;
    my $who = $self->{command}->{who};

    my ($tell, $message) = split ' ', $text, 2;
    $tell{$tell} = {
        who => $who,
        what => $message
    };

    return "Okidoki";
}

sub inform {
    my ($self) = @_;

    my $who = $self->{command}->{who};
    if (my $tell = delete $tell{$who}) {
        return sprintf "%s: %s said %s",
            $who, $tell->{who}, $tell->{what};
    }
}
1;
