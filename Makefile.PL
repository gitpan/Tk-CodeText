use Tk::MMutil;
use Tk::Config;

$pm = 'CodeText';

Tk::MMutil::TkExtMakefile(
	'PREREQ_PM' => {
		'Syntax::Highlight::Perl' => '1.0',
	},
	'NAME'       => "Tk::$pm",
	'DISTNAME'   => "Tk-$pm",
	'VERSION_FROM' => "$pm.pm",
	'dist'     => { COMPRESS => 'gzip -f9', SUFFIX => '.gz' },
	($] >= 5.005 ?
		(
		'ABSTRACT' => 'Text widget with syntax highlighting',
		'AUTHOR'   => 'Hans Jeuken (haje@toneel.demon.nl)') : (),
	 ),
);




