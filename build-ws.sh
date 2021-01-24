#!/bin/sh

set -euox pipefail

FRAMEWORK=UnityFramework
XCPROJ_NAME=Unity-iPhone.xcworkspace
SCHEME_NAME=$FRAMEWORK
PROJECT_DIR=ios_xcode/UnityLibrary
BUILD=build
FRAMEWORK_NAME_WITH_EXT=$FRAMEWORK.framework
DSYM_NAME_WITH_EXT=$FRAMEWORK_NAME_WITH_EXT.dSYM

IOS_ARCHIVE_DIR=Release-iphoneos-archive
IOS_ARCHIVE_FRAMEWORK_PATH=$BUILD/$IOS_ARCHIVE_DIR/Products/Library/Frameworks/$FRAMEWORK_NAME_WITH_EXT
IOS_ARCHIVE_DSYM_PATH=$BUILD/$IOS_ARCHIVE_DIR/dSYMs
IOS_UNIVERSAL_DIR=Release-universal-iOS

echo "### Cleaning up after old builds"

rm -rf ios/$FRAMEWORK.tar.bz2
cd $PROJECT_DIR
rm -Rf $BUILD


echo "### BUILDING FOR iOS"
echo "### Building for device (Archive)"

# iOS build
xcodebuild archive\
           -workspace $XCPROJ_NAME\
           -scheme $SCHEME_NAME\
           -sdk iphoneos\
           -archivePath $BUILD/Release-iphoneos.xcarchive\
           ENABLE_BITCODE=NO\
    | xcpretty


echo "### Copying framework files"

mv $BUILD/Release-iphoneos.xcarchive $BUILD/$IOS_ARCHIVE_DIR
mkdir -p $BUILD/$IOS_UNIVERSAL_DIR

# Copy build products out of built archive
cp -RL $IOS_ARCHIVE_FRAMEWORK_PATH $BUILD/$IOS_UNIVERSAL_DIR/$FRAMEWORK_NAME_WITH_EXT
cp -RL $IOS_ARCHIVE_DSYM_PATH/$DSYM_NAME_WITH_EXT $BUILD/$IOS_UNIVERSAL_DIR/$DSYM_NAME_WITH_EXT


echo "### Copying iOS files into zip directory"

TAR_DIR=../../ios

# Produce tarball
cd $BUILD/$IOS_UNIVERSAL_DIR
tar -cjvf ../../$TAR_DIR/$FRAMEWORK.tar.bz2 $FRAMEWORK_NAME_WITH_EXT $DSYM_NAME_WITH_EXT

echo "### Zipped resulting framework and dSYM to $TAR_DIR/$FRAMEWORK.tar.bz2"
