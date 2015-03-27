package Vurl::Command::Net;

use strict;
use warnings;
use 5.014;

use URI::Find;
use URI::Title;

my $last_url;

sub import {
    my $caller = (caller)[0];

    $caller->declare_command(title => \&title);
    $caller->declare_autocommand(\&remember_url);
}

sub title {
    my ($self, $command, $text) = @_;

    $text ||= $last_url;

    return URI::Title::title($text);
}

sub remember_url {
    my $self = shift;
    my $message = shift;

    URI::Find->new(sub { $last_url = $_[1] })->find(\$message);
    return; # avoid saying anything
}

1;
