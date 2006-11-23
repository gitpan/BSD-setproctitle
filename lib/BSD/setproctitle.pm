package BSD::setproctitle ;

use 5.00503 ;
use strict ;
use Carp ;

require Exporter ;
require DynaLoader ;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $__progname) ;
@ISA = qw(Exporter
  DynaLoader) ;

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

@EXPORT      = qw( setproctitle ) ;
%EXPORT_TAGS = ( 'all' => [qw( getprogname setprogname setproctitle )] ) ;
@EXPORT_OK   = ( @{ $EXPORT_TAGS{'all'} } ) ;
$VERSION     = '0.01' ;

bootstrap BSD::setproctitle $VERSION;

# Preloaded methods go here.

# Because setprogname(3) stores the pointer rather than a copy of the
# string we have to make sure the actual string does not go out of
# scope!
sub setprogname($) {
    my $newprogname = shift ;

    if ( defined($newprogname) && length($newprogname) ) {
	$__progname = $newprogname ;
	_setprogname($__progname) ;
    } else {
	carp "cannot set empty progname" ;
    }
}

1 ;
__END__

=head1 NAME

BSD::setproctitle - Perl interface to BSD's setprogname(3) and setproctitle(3)

=head1 SYNOPSIS

  use BSD::setproctitle ':all';
  setprogname "zonkodaemon";
  setproctitle "listening on port XY";
  system "/bin/ps", $$;

=head1 DESCRIPTION

This module provides a Perl interface to the C<getprogname>,
C<setprogname> and C<setproctitle> routines found in modern BSD
variants. Other than the C function our C<setproctitle> takes only a
single string argument (to be immune against format string attacks).

=head2 EXPORT

The C<setproctitle> routine is exported by default.  The
C<getprogname> and C<setprogname> routines are exported on request.

=head1 SEE ALSO

Manpages L<setprogname> and L<setproctitle>.

=head1 AUTHOR

Martin Kammerhofer, E<lt>mkamm@gmx.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Martin Kammerhofer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
