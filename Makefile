CC?=gcc
INC=-I./lib
CFLAGS=-g $(INC) -D_FILE_OFFSET_BITS=64
LIBS=-lelf
TESTIMAGE=image.file
EMBEDDEDNAME=embeddedimage

buildapp:
	# create workspace
	-mkdir build/

	# create test file to embed
	test -s image.file || dd if=/dev/zero of=$(TESTIMAGE) bs=1 count=1500

	# compile embedded wrapper
	$(CC) $(CFLAGS) lib/*.c app.c -o build/appskel $(LIBS)

	# add in section
	objcopy --add-section $(EMBEDDEDNAME)=$(TESTIMAGE) build/appskel build/app

	# remove temp files
	-rm -f build/appskel

clean:
	rm -rf build

