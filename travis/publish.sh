rm -rf out

# 1. Run Validate and Check for Completeness
wget http://mirror.oxygenxml.com/InstData/Editor/All/oxygen.tar.gz
tar -zxvf oxygen.tar.gz

cp resources/scriptinglicensekey.txt oxygen/scriptinglicensekey.txt

oxygen/validateCheckDITA.sh -i $DITAMAP -s resources/settings.xml -r report.xml

# Apply an XSLT for a little styling
java -cp oxygen/lib/saxon9ee.jar net.sf.saxon.Transform  -s:report.xml -xsl:resources/result.xsl -o:out/result.html

#cp report.xml out/report.xml


# Run DITA Metrics Report



# Genreate WebHelp responsive
wget http://mirror.oxygenxml.com/InstData/Editor/Webhelp/oxygen-webhelp.zip
unzip oxygen-webhelp.zip 



wget https://github.com/dita-ot/dita-ot/releases/download/2.2.3/dita-ot-2.2.3.zip
unzip dita-ot-2.2.3.zip 

cp -R com.oxygenxml.* dita-ot-2.2.3/plugins/
mv dita-ot-2.2.3/plugins/com.oxygenxml.webhelp/plugin_2.x.xml dita-ot-2.2.3/plugins/com.oxygenxml.webhelp/plugin.xml
# Add the editlink plugin
git clone https://github.com/ctalau/ditaot-editlink-plugin dita-ot-2.2.3/plugins/com.oxygenxml.editlink/

cd dita-ot-2.2.3/
bin/ant -f integrator.xml 
cd ..

cp resources/licensekey.txt dita-ot-2.2.3/plugins/com.oxygenxml.webhelp/licensekey.txt

REPONAME=`basename $PWD`
PARENTDIR=`dirname $PWD`
USERNAME=`basename $PARENTDIR`

# Send some parameters to the "editlink" plugin as system properties
export ANT_OPTS="$ANT_OPTS -Dditamap.path=$DITAMAP"
export ANT_OPTS="$ANT_OPTS -Dcwd=`pwd`"
export ANT_OPTS="$ANT_OPTS -Drepo.url=github://getFileContent/$USERNAME/$REPONAME/$TRAVIS_BRANCH/"
export ANT_OPTS="$ANT_OPTS -Dwebapp.url=https://www.oxygenxml.com/webapp-demo-aws/"
export ANT_OPTS="$ANT_OPTS -Dwebhelp.show.changes.and.comments=yes"


dita-ot-2.2.3/bin/dita -i $DITAMAP -f webhelp-responsive 
