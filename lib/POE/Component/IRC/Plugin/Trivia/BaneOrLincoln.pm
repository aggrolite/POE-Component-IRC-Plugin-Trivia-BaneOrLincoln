package POE::Component::IRC::Plugin::Trivia::BaneOrLincoln;

use Moose;
our $VERSION = '0.01';

use POE::Component::IRC::Plugin qw( :ALL );
with 'POE::Component::IRC::Plugin::Role';

our %quotes = (
    q{"Let us not stand on ceremony."} => 'bane',
    q{"Behind you stands a symbol of oppression."} => 'bane',
    q{"Speak of the devil and he shall appear."} => 'bane',
    q{"Though it's imperceptible in the darkness, I have an intuition that we're headed towards a shore."} => 'lincoln',
    q{"Do you think we choose the times into which we are born?"} => 'lincoln',
    q{"The oppressors of generations who have kept you down with myths of opportunity, and we give it back to you... the people."} => 'bane',
    q{"If you can look into the seeds of time and say which grain will grow and which will not, speak then to me."} => 'lincoln',
    q{"Peace has cost you your strength! Victory has defeated you!"} => 'bane',
    q{"Shall we stop this bleeding?"} => 'lincoln',
    q{"Step forward those who would serve."} => 'bane',
);

our %answers;

sub new {
    my ($class, %args) = @_;

    $args{players} = {};
    $args{playing} = 0;
    $args{answer} = '';
    $args{rounds} ||= 5;
    $args{alarm} = '';

    return bless \%args, $class;
}

use threads (
    'yield',
    'stack_size' => 64 * 4096,
    'exit'       => 'threads_only',
    'stringify'
);

sub _foo {
    warn 1;
}

sub S_public {
    my ($self, $irc) = splice @_, 0, 2;

    # Parameters are passed as scalar-refs including arrayrefs.
    my $nick    = (split /!/, ${$_[0]})[0];
    my $channel = ${$_[1]}->[0];
    my $msg     = ${$_[2]};

    #if ($
    #$irc->delay_remove( $alarm_id );
    my $thr = threads->create('_foo', 'argument');
    $thr->join();

    #my $alarm_id;

    #if ($msg =~ /^!BaneOrLincoln\b/i and not $self->{playing}) {
    #    $irc->yield(privmsg => $channel => "BANE OR LINCOLN? has been started by $nick");
    #    $irc->yield(privmsg => $channel => "Type !join to join the game!");
    #    $self->{players}{$nick}++;
    #    $self->{playing} = 1;
    #    return PCI_EAT_PLUGIN;
    #}

    #return PCI_EAT_NONE unless $self->{playing};

    #if ($self->{playing} == 2) {
    #    if (exists $self->{players}{$nick}) {
    #        $msg =~ s/^\s+!?|\s+$//g;
    #        $answers{$nick} = lc $msg;
    #        $irc->yield(privmsg => $channel => "$nick has guessed " . uc $msg . "!");
    #    }
    #    return PCI_EAT_PLUGIN;
    #}


    #if ($msg =~ /!rules\b/i) {
    #    $irc->yield(privmsg => $channel => "You must guess if a given quote was said by Bane (from Batman) or Lincoln (the US president)");
    #    $irc->yield(privmsg => $channel => "Type either bane or lincoln to guess");
    #    return PCI_EAT_PLUGIN;
    #}

    #elsif ($msg =~ /!join\b/i and $self->{playing} == 1) {
    #    my $reply = $self->{players}{$nick}++ ? "$nick, you have already joined the game" : "$nick has joined the game!";
    #    $irc->yield(privmsg => $channel => $reply);
    #    return PCI_EAT_PLUGIN;
    #}

    #elsif ($msg =~ /!start\b/i and $self->{playing} == 1) {
    #    if (exists $self->{players}{$nick}) {
    #        $self->{playing} = 2;
    #        my $quote = (keys %quotes)[rand keys %quotes];
    #        $self->{answer} = $quotes{$quote};
    #        $irc->yield(privmsg => $channel => "You will have 15 seconds to guess after the quote has been given");
    #        $irc->delay([privmsg => $channel => $quote],4);
    #        #$irc->yield(privmsg => $channel => "The round has ended! Correct answer: ". uc $self->{answer});
    #        #$irc->yield(privmsg => $channel => "$nick has guessed $msg!");
    #    }
    #    else {
    #        $irc->yield(privmsg => $channel => "$nick, only players who have joined can start the game");
    #    }
    #    return PCI_EAT_PLUGIN;
    #}

    #if ($reply) {
    #    $irc->yield(privmsg => $channel => "$nick: $reply");
    #    return PCI_EAT_PLUGIN;
    #}

    # Default action is to allow other plugins to process it.
    return PCI_EAT_NONE;
}


1;
__END__

=encoding utf-8

=head1 NAME

POE::Component::IRC::Plugin::Trivia::BaneOrLincoln - Blah blah blah

=head1 SYNOPSIS

  use POE::Component::IRC::Plugin::Trivia::BaneOrLincoln;

=head1 DESCRIPTION

POE::Component::IRC::Plugin::Trivia::BaneOrLincoln is

=head1 AUTHOR

Curtis Brandt E<lt>curtis@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2013- Curtis Brandt

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
