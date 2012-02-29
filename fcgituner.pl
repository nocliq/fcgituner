#!/usr/bin/perl

use strict;
use warnings;
use Math::Round;

my $version = "0.1";
my $phpver = `php -v | awk \'\{print \$2\}\' | head -1`;
my $MPM = `httpd -V | grep MPM: | awk \'\{print \$3\}\'`;

my $FCGI = "";
my $FCGI_mod = `httpd -M 2> /dev/null | grep fcgid_module`;
if ( $FCGI_mod eq "" ) {
	$FCGI = "disabled"
} else {
	$FCGI = "enabled"
}

my @RAM = `head -2 /proc/meminfo | awk \'\{print \$2\}\'`;
chomp(@RAM);
$RAM[0] /= 1000;
$RAM[1] /= 1000;
# Do some information gthering

print "\nFCGI Tuner - by NocLiq\n";
print "Version: " . $version . "\n";
print "----------------------\n";
print "PHP Version: " . $phpver;
print "MPM Handler: " . $MPM ;
print "FCGI: " . $FCGI . "\n"; 
print "Total RAM: " . round($RAM[0]) . " Mb\n";
print "Free RAM: " . round($RAM[1]) . " Mb\n";


my $prefork = "Prefork";
chomp($MPM);

# make some suggestions based on the info gathered
# 1) Low memory system => suggest suphp
# 2) Medium memory system => print one set of FCGI values






if (lc($MPM) eq lc($prefork) && $FCGI eq "enabled" ) {

	print "\n\nWarning: $MPM MPM + FCGI = BAD IDEA!!!\n\n";
} else {
	print "\n\n$MPM MPM OK.\n\n";
}

exit;
