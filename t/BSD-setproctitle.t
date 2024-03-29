# -*- perl -*-
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl BSD-setproctitle.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test ;
BEGIN { plan tests => 5 }
use BSD::setproctitle ;
ok(1) ;    # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

setproctitle("testing the module...") ;
ok( qx:/bin/ps: =~ 'testing the module\.\.\.' ) ;
setproctitle("-testing this module again...") ;
ok( qx:/bin/ps: =~ 'testing this module again\.\.\.' ) ;
setproctitle("") ;    # setproctitle(NULL)
ok( qx:/bin/ps: !~ 'testing this module again\.\.\.' ) ;
ok( qx:/bin/ps: =~ 'BSD-setproctitle\.t' ) ;
