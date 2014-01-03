CC?=gcc
INC=-I./lib
CFLAGS=-g $(INC) -D_FILE_OFFSET_BITS=64
LIBS=-lelf
BUILDDIR=build
TESTIMAGE=$(BUILDDIR)/image.file
EMBEDDEDNAME=embeddedimage

buildapp:
	# create workspace
	-mkdir $(BUILDDIR)

	# create test file to embed
	test -s image.file || dd if=/dev/zero of=$(TESTIMAGE) bs=1 count=1500

	# compile embedded wrapper
	$(CC) $(CFLAGS) lib/*.c app.c -o $(BUILDDIR)/appskel $(LIBS)

	# add in section
	objcopy --add-section $(EMBEDDEDNAME)=$(TESTIMAGE) $(BUILDDIR)/appskel $(BUILDDIR)/app

	# remove temp files
	-rm -f $(BUILDDIR)/appskel

clean:
	rm -rf $(BUILDDIR)

