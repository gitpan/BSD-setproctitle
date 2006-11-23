use 5.00503 ;
use ExtUtils::MakeMaker ;
use Config ;
require DynaLoader ;

my @libs = () ;
push @libs, $Config{libc} if $Config{libc} && -s $Config{libc} ;
push @libs, '-lc' ;
my $libcname = DynaLoader::dl_findfile(@libs) ;
die "cannot figure out your shared C library's path" unless $libcname ;
my $libc = DynaLoader::dl_load_file($libcname) ;
die "cannot dlopen $libcname" unless $libc ;

my ( @defines, %symbols ) ;
foreach (qw( getprogname setprogname setproctitle )) {
    my $sym = DynaLoader::dl_find_symbol( $libc, $_ ) ;
    if ($sym) {
	$symbols{$_} = $sym ;
	push @defines, "-DHAVE_" . uc($_) . "=1" ;
    }
}
die "You do not have setproctitle(3) in the '$libcname' library.\n"
  . "Maybe $^O is not among the supported operating systems?\n"
  . "Please consult the README file!\n"
  . "Sorry, but I cannot continue.\n"
  unless $symbols{setproctitle} ;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    ABSTRACT_FROM => 'lib/BSD/setproctitle.pm', # retrieve abstract from module
    AUTHOR => 'Martin Kammerhofer <mkamm@gmx.net>',
    DEFINE => join( " ", @defines ),
    INC       => '-I.',                 # e.g., '-I. -I/usr/include/other'
    LIBS      => [''],                  # e.g., '-lm'
    NAME      => 'BSD::setproctitle',
    PREREQ_PM => {},                    # e.g., Module::Name => 1.1
    VERSION_FROM => 'lib/BSD/setproctitle.pm',    # finds $VERSION
) ;
