package Vurl::Command::Id;

use strict;
use warnings;
use 5.014;

sub import {
    my $caller = (caller)[0];

    $caller->declare_command(say => \&i_say);
    $caller->declare_command(vurl => \&vurl);
    $caller->declare_command(decide => \&decide);
    $caller->declare_command(atbash => \&atbash);
}

sub decide {
    my ($self, $cmd, $message) = @_;

    my @choices = $message =~ /\bor\b/
        ? split /\s+or\s+/, $message
        : qw/Yes No/;

    return $choices[rand @choices];
}

sub vurl {
    my ($self, $cmd, $message) = @_;

    $message //= '';
    my $adverbs = $self->{config}->{adverbfile};
    my $verbs = $self->{config}->{verbfile};

    my $nick = ($message =~ s/^\s+|\s+$//gr) || $self->{command}->{who};

    my $adverb = $adverbs->[rand @$adverbs];
    my $verb = $verbs->[rand @$verbs];

    $verb =~ /(?<!&)\Q&(_)/ or $verb .= ' &(_)';

    $adverb =~ s/(?<!&)\K\Q&(_)/$nick/g;

    if ($adverb =~ /^'s/) {
        $verb =~ s/(?<!&)\K\Q&(_)/$nick$adverb/g;

        $self->emote(
            body => $verb,
            channel => $self->{command}->{channel}
        );
    }
    else {
        $verb =~ s/(?<!&)\K\Q&(_)/$nick/g;

        $self->emote(
            body => "$verb $adverb",
            channel => $self->{command}->{channel}
        );
    }

    # this command emotes so avoid saying anything
    return;
}

sub atbash {
    my ($self, $cmd, $message) = @_;

    my %repl;
    @repl{'A'..'Z'} = reverse 'A'..'Z';
    @repl{'a'..'z'} = reverse 'a'..'z';

    $message =~ s/([a-z])/$repl{$1}/gire;
}

sub i_say {
    my ($self, $cmd, $message) = @_;

    return $self->parse_message($message);
}

1;
