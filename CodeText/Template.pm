package Tk::CodeText::Template;

use vars qw($VERSION);
$VERSION = '0.1'; #initial rlease

use strict;
use Data::Dumper;

sub new {
	my ($proto, $rules) = @_;
	my $class = ref($proto) || $proto;
	if (not defined($rules)) {
		$rules =  [];
	};
	my $self = {};
	$self->{'stack'} = [];
	$self->{'rules'} = $rules,
	$self->{'snippet'} = '';
	$self->{'out'} = [];
	$self->{'lists'} = {};
	bless ($self, $class);
	return $self;
}

sub lists {
	my $hlt = shift;
	if (@_) { $hlt->{'lists'} = shift; };
	return $hlt->{'lists'};
}

sub listAdd {
	my $hlt = shift;
	my $listname = shift;
	print "listname $listname\n";
	my $lst = $hlt->lists;
	if (@_) {
		$lst->{$listname} = [@_];
	} else {
		$lst->{$listname} = [];
	}
	my $r = $hlt->lists->{$listname};
	print "added tokens\n"; foreach my $f (@$r) { print "   $f\n"; };
}

sub rules {
	my $hlt = shift;
	if (@_) { $hlt->{'rules'} = shift;	}
	return $hlt->{'rules'};
}

sub out {
	my $hlt = shift;
	if (@_) { $hlt->{'out'} = shift; }
	return $hlt->{'out'};
}

sub snippet {
	my $hlt = shift;
	if (@_) { $hlt->{'snippet'} = shift; }
	return $hlt->{'snippet'};
}

sub snippetAppend {
	my ($hlt, $ch) = @_;
	$hlt->{'snippet'} = $hlt->{'snippet'} . $ch;
}

sub snippetParse {
	my $hlt = shift;
	my $out = $hlt->{'out'};
	my $snip = $hlt->snippet;
	if ($snip) {
		push(@$out, length($snip), $hlt->stackTop);
		$hlt->snippet('');
	}
}

sub stack {
	my $hlt = shift;
	return $hlt->{'stack'};
}

sub stackPush {
	my ($hlt, $val) = @_;
#	print "pushing $val\n";
	my $stack = $hlt->stack;
	unshift(@$stack, $val);
}

sub stackPull {
	my ($hlt, $val) = @_;
	my $stack = $hlt->stack;
	return shift(@$stack);
}

sub stackTop {
	my $hlt = shift;
	return $hlt->stack->[0];
}

sub stateCompare {
	my ($hlt, $state) = @_;
	my $h = [ $hlt->stateGet ];
	my $equal = 1;
	if (Dumper($h) ne Dumper($state)) { $equal = 0 };
	return $equal;
}

sub stateGet {
	my $hlt = shift;
	my $s = $hlt->stack;
	return @$s;
}

sub stateSet {
	my $hlt = shift;
	my $s = $hlt->stack;
	@$s = (@_);
}

sub tokenParse {
	my ($hlt, $tkn) = @_;
	$hlt->stackPush($tkn);
	$hlt->snippetParse;
	$hlt->stackPull;
}

sub tokenTest {
	my ($hlt, $test, $list) = @_;
	my $l = $hlt->lists->{$list};
	my $found = 0;
	my $count = 0;
	while (($count < @$l) and (! $found)) {
		if ($l->[$count] eq $test) {
			$found++
		}
		$count++
	}
	return $found;
}
1;

__END__

=head1 NAME

Tk::CodeText::Template - a template for syntax highlighting plugins

=head1 SYNOPSIS


=head1 DESCRIPTION

Tk::CodeText::Template is some kind of a dummy module. All methods
to provide highlighting in a Tk::CodeText widget are there, ready
to do nothing.

It is also a good starting point for writing modules for syntax
highlighting for other languages.

=head1 METHODS

=over 4

=item B<listAdd>(I<'listname'>, I<$item1>, I<$item2> ...);

Adds a list to the 'lists' hash.

=item B<lists>(I<?\%lists?>);

sets and returns the instance variable 'lists'.

=item B<out>(I<?\@highlightedlist?>);

sets and returns the instance variable 'out'.

=item B<rules>(I<?\@rules?>)

sets and returns a reference to a list of tagnames and options.
By default it is set to [].

=item B<snippetAppend>(I<$string>)

appends I<$string> to the current snippet.

=item B<snippetParse>

parses the current snippet of text to the 'out' list, and assigns the tagname
that is returned by B<stackTop> to it. then snippet is set to ''.

=item B<stack>

sets and returns the instance variable 'stack', a reference to an array.

=item B<stackPull>

retrieves the element that is on top of the stack, decrements stacksize by 1.

=item B<stackPush>(I<$tagname>)

puts I<$tagname> on top of the stack, increments stacksize by 1

=item B<stackTop>

retrieves the element that is on top of the stack.

=item B<stateCompare>(\@state);

Compares two lists, \@state and the stack. returns true if they
match.

=item B<stateGet>

Returns a list containing the entire stack.

=item B<stateSet>(I<@list>)

Accepts I<@list> as the current stack.

=item B<tokenParse>(I<'Tagname'>);

Parses the currently build snippet and tags it with 'Tagname'

=item B<tokenTest>(I<'Listname'>, I<$value>);

returns true if $value is and element of 'Listname' in the 'lists' hash

=back

=cut

=head1 AUTHOR

Hans Jeuken (haje@toneel.demon.nl)

=cut

=head1 BUGS

Unknown.

=cut














