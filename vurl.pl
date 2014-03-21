#!/usr/bin/env perl

use strict;
use warnings;

$|=1;

use Vurl;

my $vurl = Vurl->new(
    server => "irc.quakenet.org",
    port   => "6667",
    channels => ["#internets"],

    nick      => "vurl3",
    alt_nicks => ["lolbot", "cmdbot"],
    username  => "vurl3",
    name      => "Vurl Three Point Oh",
    address   => 1,
);

$SIG{INT} = sub {$vurl->shutdown};

$vurl->run;
