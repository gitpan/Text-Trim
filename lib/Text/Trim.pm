package Text::Trim;

use strict;
use warnings;

our $VERSION = '1.00';

=head1 NAME

Text::Trim - remove leading and trailing whitespace from strings

=head1 SYNOPSIS

    use Text::Trim;

    $text = "\timportant data\n";
    $data = trim $text;
    # now $data contains "important data" and $text is unchanged
    
    # or:
    trim $text; # work in place, $text now contains "important data"

    @lines = <STDIN>;
    rtrim @lines; # remove trailing whitespace from all lines

    # Alternatively:
    @lines = rtrim <STDIN>;

    while (<STDIN>) {
        trim; # Change $_ in place
        # ...
    }

=head1 DESCRIPTION

This module provides functions for removing leading and/or trailing whitespace
from strings.

=head1 EXPORTS

All functions are exported by default.

=cut

use Exporter;

our @ISA = qw( Exporter );
our @EXPORT = qw( rtrim ltrim trim );

=head1 CONTEXT HANDLING

=head2 void context

Functions called in void context change their arguments in-place

    trim(@strings); # All strings in @strings are trimmed in-place

    ltrim($text); # remove leading whitespace on $text

    rtrim; # remove trailing whitespace on $_

No changes are made to arguments in non-void contexts.

=head2 list context

Values passed in are changed and returned without affecting the originals.

    @result = trim(@strings); # @strings is unchanged

    @result = rtrim; # @result contains rtrimmed $_

    ($result) = ltrim(@strings); # like $result = ltrim($strings[0]);

=head2 scalar context

As list context but multiple arguments are stringified before being returned.
Single arguments are unaffected.  This means that under these circumstances, the
value of $" ($LIST_SEPARATOR) is used to join the values. If you don't want
this, make sure you only use single arguments when calling in scalar context.

    @strings = ("\thello\n", "\tthere\n");
    $trimmed = trim(@strings);
    # $trimmed = "hello there"

    local $" = ', ';
    $trimmed = trim(@strings);
    # Now $trimmed = "hello, there"

    $trimmed = rtrim;
    # $trimmed = $_ minus trailing whitespace

=head1 FUNCTIONS

=head2 trim

Removes leading and trailing whitespace from all arguments, or $_ if none are
provided.

=cut

sub trim {
    @_ = @_ ? @_ : $_ if defined wantarray;

    for (@_ ? @_ : $_) { s/\A\s+//; s/\s+\z// }

    return wantarray ? @_ : "@_";
}

=head2 rtrim 

Like trim() but removes only trailing (right) whitespace.

=cut

sub rtrim {
    @_ = @_ ? @_ : $_ if defined wantarray;

    for (@_ ? @_ : $_) { s/\s+\z// }

    return wantarray ? @_ : "@_";
}

=head2 ltrim

Like trim() but removes only leading (left) whitespace.

=cut

sub ltrim {
    @_ = @_ ? @_ : $_ if defined wantarray;

    for (@_ ? @_ : $_) { s/\A\s+// }

    return wantarray ? @_ : "@_";
}

1;

__END__

=head1 AUTHOR

Matt Lawrence E<lt>mattlaw@cpan.orgE<gt>

=cut

vim: ts=8 sts=4 sw=4 sr et
