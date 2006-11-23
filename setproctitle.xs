#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#ifndef HAVE_SETPROGNAME
# include <string.h>
#endif

static const char *
our_getprogname() {
#ifndef HAVE_GETPROGNAME
	extern const char * __progname;	/* in the C run-time startup code */

	return __progname;
#else
	return getprogname();
#endif
}

static void
our_setprogname(const char *newprogname)
{
#ifndef HAVE_SETPROGNAME
	extern const char * __progname;	/* in the C run-time startup code */
	const char *base;

	base = strrchr(newprogname, '/');
	if (base != NULL)
		__progname = base + 1;
	else
		__progname = newprogname;
#else
	setprogname(newprogname);
#endif
}

MODULE = BSD::setproctitle	PACKAGE = BSD::setproctitle

PROTOTYPES: ENABLE

char *
getprogname()
    CODE:
	RETVAL = (char *)our_getprogname();
    OUTPUT:
	RETVAL


void
_setprogname(newprogname)
	char *newprogname
    CODE:
	our_setprogname(newprogname);
	

void
setproctitle(newtitle)
	char *newtitle
    CODE:
	if (*newtitle == '\0')
		setproctitle(NULL);
	else if (*newtitle == '-')
		setproctitle("-%s", newtitle+1);
	else
		setproctitle("%s", newtitle);

