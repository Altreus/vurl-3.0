#!/usr/bin/env perl

use strict;
use warnings;

$|=1;

use Config::YAML;
use Vurl;

my $conf = Config::YAML->new(config => 'config.yaml');
$conf->read('local.yaml');

$conf = { %$conf };

delete @{$conf}{ grep /^_/, keys %$conf };

my $vurl = Vurl->new(
    %$conf
);

$SIG{INT} = sub {$vurl->shutdown};

$vurl->run;
