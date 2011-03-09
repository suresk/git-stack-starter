#!/bin/bash

export JAVA_HOME=/usr/java/jdk1.6.0_14
export M2_HOME=/usr/maven/maven-2.2.1
export PATH=/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:/home/bldmgr/bin:$M2_HOME/bin:$JAVA_HOME/bin:.
export MAVEN_OPTS="-Xms256m -Xmx1024m -XX:MaxPermSize=128M"
export DISPLAY=`cat /var/xvfb/DISPLAY` XAUTHORITY=/var/xvfb/XAUTHORITY

LOG=/tmp/mvnout.$$

svn update

DATE=`date +%m%d%H%M`
REVISION=`svn info | grep Revision | awk '{ print $2 }'`
SVNURL=`svn info | grep URL | awk '{ print $2 }'`

echo "Building and gathering test results, please wait..."

mvn clean install "$@" \
		-DbuildDate=$DATE \
		-DbuildRevision=$REVISION \
		-DbuildUrl=$SVNURL \
		-P continuous 1> $LOG


grep "FAILURE" $LOG > /dev/null      # Scan for test failures
if [ "$?" = "0" ]; then
	echo "[INFO] TEST FAILURES FOUND" 1>> $LOG
else
	echo "[INFO] NO TEST FAILURES FOUND" 1>> $LOG
fi

cat $LOG                             # Cat out the results
rm $LOG
