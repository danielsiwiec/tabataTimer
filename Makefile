include props.mk

sources = `find source -name '*.mc'`
resources = `find resources -name '*.xml' | tr '\n' ':' | sed 's/.$$//'`
SDK_HOME = /Users/dsiwiec/connect-iq-sdk-1.2.6

build:
	monkeyc --warn --output bin/$(APPNAME).prg -m manifest.xml \
	-z $(resources) -d $(DEVICE)_sim -u $(SDK_HOME)/bin/devices.xml \
	-p $(SDK_HOME)/bin/projectInfo.xml $(sources)

run: build
	connectiq &&\
	sleep 3 &&\
	monkeydo bin/$(APPNAME).prg $(DEVICE)

deploy: build
	cp bin/$(APPNAME).prg /Volumes/GARMIN/GARMIN/APPS/
