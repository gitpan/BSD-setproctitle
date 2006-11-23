# -*- perl -*-
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl BSD-progname.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test ;
BEGIN { plan tests => 5 }
use BSD::setproctitle ':all' ;
ok(1) ;    # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

{
    ( my $progname = $^X ) =~ s:.*/:: ;    # basename argv[0]
    ok( getprogname(), $progname ) ;
    setprogname("aristocat") ;
    ok( getprogname(), "aristocat" ) ;
    $progname = "Rumpelstilzchen" ;
    setprogname $progname;
    ok( getprogname(), $progname ) ;
    $progname = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
}

# lexical variable $progname now went out of scope
ok( getprogname(), "Rumpelstilzchen" ) ;
