
#!/bin/bash
set -e

# Get a build number from TravisCI
if [ "$TRAVIS_BUILD_NUMBER" = "" ]
then
    # Used for local builds
   export BUILD=999
else
   export BUILD=$TRAVIS_BUILD_NUMBER
fi

# Control the Major/Minor here
export MAJOR=0
export MINOR=1
export APP_VERSION=$MAJOR.$MINOR.$BUILD

export APP_FOLDER=splunk-gtfs-add-on

echo "-----------------------------------------------------------"
echo "Major: $MAJOR"
echo "Minor: $MINOR"
echo "Build Number: $BUILD"

# Create/Clean up folder
rm -rf tmp_build

# Make new dir for Add On
mkdir -p tmp_build/$APP_FOLDER

# Copy folders and Assets
cp -r src/bin tmp_build/$APP_FOLDER
cp -r src/default tmp_build/$APP_FOLDER
cp -r src/static tmp_build/$APP_FOLDER

cp README.md tmp_build/$APP_FOLDER/README.md # README from repo

# Set permissions on the app
# chmod -R 755 tmp_build/$APP_FOLDER/bin/get_data.py

# Remove any Python Cache
find tmp_build/$APP_FOLDER -name "*.pyc" -delete

# Remove any hidden files 
find tmp_build/$APP_FOLDER -name '._*' -type f -delete
find tmp_build/$APP_FOLDER -name ".*" -exec rm -rf {} \;

# Increment Build Number
echo "Using version $APP_VERSION"
echo "-----------------------------------------------------------"
bumpversion \
    --current-version 0.0.1 \
    --new-version $APP_VERSION \
    tmp_build/ta-gtfs/default/app.conf \
    --allow-dirty

# Package the app
cd tmp_build
tar -czvf $APP_FOLDER.tgz ta-gtfs
# Back to the root.
cd ..

echo
echo "-----------------------------------------------------------"
echo "Running PyTest"
echo "-----------------------------------------------------------"
py.test test/

echo
echo "-----------------------------------------------------------"
echo "Running Splunk AppInspect"
echo "-----------------------------------------------------------"
splunk-appinspect inspect tmp_build/ta-gtfs.tgz

