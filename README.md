# vurl 3000 #

Vurl am de bot Tim once wrote as an irssi script. Vurl 2 was an improved irssi
script.

Vurl 3000 is shrugging off the yoke of irssi and is now a free bird, running
independently of shackles and bonds

## Install ##

First install [cpanm](http://cpanmin.us).

Then install the rest.

    cpanm --installdeps .

You may benefit from `local::lib` first:

    cpanm --local-lib=~/perl5 local::lib \
      && echo 'eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)' >> ~/.bashrc \
      && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

## Configure ##

Create a file called local.yaml that looks like this:

    server: "irc.quakenet.org"
    port: "6667"
    channels:
     - "#internets-dev"
    nick: "v3k"
    username: "vurl3000"

Replace these values as relevant.

## Extend ##

Docs for creating new commands are in Bot::BasicBot::CommandBot -
[https://github.com/Altreus/Bot-BasicBot-CommandBot](https://github.com/Altreus/Bot-BasicBot-CommandBot)
- but check below on Modules.

## Run ##

Vurl3k is a set of modules designed for use with Bot::BasicBot::CommandBot.
That module is itself not released and so is bundled with vurl3k at the moment.

An example vurl is provided in the form of vurl.pl, but you can pretty much do
anything that will run an instance of vurl.

    perl -Ilib vurl.pl

or

    use Vurl;
    Vurl->new->run;

See Bot::BasicBot::CommandBot for `new`

## Modules ##

Vurl's been split into one module per functional area. Normally a command would
be set up with `command foo => sub { }` but by splitting them into modules we
have to pretend that `command` was called from the context of Vurl.pm.

This is doable because `command` is just a wrapper around `declare_command`, and
`declare_command` is called with `->` and, hence, receives the package to register
it with.

That's why inside the `import` function in the command modules, it uses `(caller)[0]`
- this will be `'Vurl'` here, but it means you can import Vurl commands into any
Bot::BasicBot::CommandBot.

To add commands to vurl3k either use `command` inside `Vurl.pm`, or follow suit with
existing modules using the caller trick above.
