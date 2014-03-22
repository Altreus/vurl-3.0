#!/usr/bin/env perl

use strict;
use warnings;

$|=1;

use Vurl;

my $vurl = Vurl->new(
    server => "irc.quakenet.org",
    port   => "6667",
    channels => ["#internets"],

    nick      => "v3k",
    alt_nicks => ["lolbot", "cmdbot"],
    username  => "vurl3000",
    name      => "Vurl Three Point Oh",
    address   => 1,
);

$SIG{INT} = sub {$vurl->shutdown};

$vurl->run;
