#!/usr/bin/perl -w
use strict;
use Tk;

my $m = new MainWindow;
require Tk::CodeText;
my $e = $m->Scrolled('CodeText',
	-disablemenu => 1,
	-syntax => 'Perl',
	-scrollbars => 'se',
)->pack(-expand => 1, -fill => 'both');
$m->configure(-menu => $e->menu);

$m->protocol('WM_DELETE_WINDOW', sub {
   if ($e->ConfirmEmptyDocument) { $m->destroy };
});

$m->MainLoop;

