package Vurl::Command::Maths;

use strict;
use warnings;
use utf8;

use List::Util qw(reduce);

sub import {
    my $caller = (caller)[0];

    $caller->declare_command(add => \&add);
    $caller->declare_command(sub => \&sub);
    $caller->declare_command(mul => \&mul);
    $caller->declare_command(div => \&div);
    $caller->declare_command(pow => \&pow);
    $caller->declare_command(int => \&int);
    $caller->declare_command(sin => \&sin);
    $caller->declare_command(cos => \&cos);
    $caller->declare_command(tan => \&tan);
    $caller->declare_command(quad => \&quad);
    $caller->declare_command(dot => \&dot);
    $caller->declare_command(cross => \&cross);
}

sub add {
    my ($self, $cmd, $message) = @_;

    return reduce { $a + $b } 0, split ' ', $message;
}

sub sub {
    my ($self, $cmd, $message) = @_;

    return reduce { $a - $b } split ' ', $message;
}

sub mul {
    my ($self, $cmd, $message) = @_;

    return reduce { $a * $b } 1, split ' ', $message;
}

sub div {
    my ($self, $cmd, $message) = @_;

    return reduce { $a / $b } split ' ', $message;
}

sub pow {
    my ($self, $cmd, $message) = @_;

    return reduce { $a ** $b } split ' ', $message;
}

sub int {
    my ($self, $cmd, $message) = @_;

    return int $message;
}

sub sin {
    my ($self, $cmd, $message) = @_;

    return sin $message;
}

sub cos {
    my ($self, $cmd, $message) = @_;

    return cos $message;
}

sub tan {
    my ($self, $cmd, $message) = @_;

    return CORE::sin($message) / CORE::cos($message);
}

sub quad {
    my ($self, $cmd, $message) = @_;

    my ($cxsq, $cx, $c) = split ' ', $message;

    $cxsq == 0 and return "Error: quadratic cannot have 0 as coefficient of x²";

    my $full = "${cxsq}x² + ${cx}x + $c = 0";

    if ($cx ** 2 < 4 * $cxsq * $c) {
        my $real = -$cx / (2 * $cxsq);
        my $imaginary = sqrt( 4 * $cxsq * $c - $cx ** 2) / (2 * $cxsq);
        return sprintf '%s: Two complex roots: x = %2$5f + %3$5fi, or x = %2$5f - %3$5fi', $full, $real, $imaginary;
    }

    if ($cx ** 2 == 4 * $cxsq * $c) {
        my $soln = -$cx / (2 * $cxsq);
        return sprintf '%s: One (repeated) real root: x = %5f', $full, $soln;
    }

    my $solution1 = -$cx + sqrt($cx ** 2 - 4 * $cxsq * $c) / (2 * $cxsq);
    my $solution2 = -$cx - sqrt($cx ** 2 - 4 * $cxsq * $c) / (2 * $cxsq);
    return sprintf '%s: Two real roots: x = %5f, or x = %5f', $full, $solution1, $solution2;
}

sub dot {
    my ($self, $cmd, $message) = @_;

    my ($string1, $string2) = $message =~ m/\(([\d.,]+)\)/g;

    my @vec1 = $string1 =~ m/(-?\d+(?:\.\d+)?)/g;
    my @vec2 = $string2 =~ m/(-?\d+(?:\.\d+)?)/g;

    return "vectors not the same size" if @vec1 != @vec2;

    my $ans;
    for (keys @vec1) {
        $ans += $vec1[$_] * $vec2[$_];
    }

    return $ans;
}

sub cross {
    my ($self, $cmd, $message) = @_;

    my ($ax, $ay, $az, $bx, $by, $bz) = $message = /\(([\d.]+),([\d.]+),([\d.]+)\)/g;
    my $x = $ay * $bz - $az * $by;
    my $y = $az * $bx - $ax * $bz;
    my $z = $ax * $by - $ay * $bx;

    return "($x, $y, $z)";
}

1;
