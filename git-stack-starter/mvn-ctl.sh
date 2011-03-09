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

mvn clean deploy site-deploy "$@" \
		-DbuildDate=$DATE \
		-DbuildRevision=$REVISION \
		-DbuildUrl=$SVNURL \
		-P controlled 1> $LOG

if [ "$?" != "0" ]; then
   cat $LOG
   rm $LOG
   exit 1
fi

# Variables used to copy artifacts. Put them in one place for convenience.
export PORTFOLIO={Put the portfolio name here}
export PROD=reference
export VERSION=1.0

# Copy the artifact to ICSLIB and give it a unique revision and date stamp
echo "[INFO] *******************************************************************" 1>> $LOG
echo "[INFO] Copying deploy zip file to ICSLIB." 1>> $LOG
echo "[INFO] *******************************************************************" 1>> $LOG
echo "[INFO]" 1>> $LOG
scp deploy/target/*.zip bldmgr@code.lds.org:/opt/LDSDev/html/artifacts/$PORTFOLIO/$PROD/$VERSION/$PROD-Rev$REVISION-$DATE.zip 1>> $LOG

if [ -f db/target/*.zip ]; then
   echo "[INFO] *******************************************************************" 1>> $LOG
   echo "[INFO] Copying zip file to ICSLIB." 1>> $LOG
   echo "[INFO] *******************************************************************" 1>> $LOG
   echo "[INFO]" 1>> $LOG
   scp db/target/*.zip bldmgr@code.lds.org:/opt/LDSDev/html/artifacts/$PORTFOLIO/$PROD/$VERSION/$PROD-Rev$REVISION-$DATE-db.zip 1>> $LOG
fi

if [ -f qa/target/*tests.jar ]; then
   echo "[INFO] *******************************************************************" 1>> $LOG
   echo "[INFO] Copying tests jar to ICSLIB." 1>> $LOG
   echo "[INFO] *******************************************************************" 1>> $LOG
   echo "[INFO]" 1>> $LOG
   scp qa/target/*tests.jar bldmgr@code.lds.org:/opt/LDSDev/html/artifacts/$PORTFOLIO/$PROD/$VERSION/$PROD-Rev$REVISION-$DATE-tests.jar 1>> $LOG
fi

grep "FAILURE" $LOG > /dev/null      # Scan for test failures
if [ "$?" = "0" ]; then
   echo "[INFO] TEST FAILURES FOUND" 1>> $LOG
else
   echo "[INFO] NO TEST FAILURES FOUND" 1>> $LOG
fi

cat $LOG                             # Cat out the results
rm $LOG

