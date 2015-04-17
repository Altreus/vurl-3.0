package Vurl;

use strict;
use warnings;

use Bot::BasicBot::CommandBot qw(command);

use base 'Bot::BasicBot::CommandBot';

use Vurl::Command::Id;
use Vurl::Command::Maths;
use Vurl::Command::Net;
use Vurl::Command::Util;
use Tie::File;

sub new {
    my $class = shift;
    my %opts = @_;

    my $vurlopts = delete $opts{vurl};

    my $self = $class->SUPER::new(%opts);

    my (@verbs, @adverbs);
    tie @verbs, 'Tie::File', $vurlopts->{verbfile};
    tie @adverbs, 'Tie::File', $vurlopts->{adverbfile};

    $vurlopts->{verbfile} = \@verbs;
    $vurlopts->{adverbfile} = \@adverbs;

    $self->{config} = $vurlopts;

    return $self;
}

1;
