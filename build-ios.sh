#!/bin/sh

set -euox pipefail

UNITY_BUILD_SCRIPT_METHOD_NAME=Build.DoBuildIOS
UNITY_PROJECT_PATH=unity/GreatNotionAR

FRAMEWORK=UnityFramework
XCPROJ_NAME=Unity-iPhone.xcodeproj
SCHEME_NAME=$FRAMEWORK
PROJECT_DIR=ios_xcode/UnityLibrary
BUILD=build
FRAMEWORK_NAME_WITH_EXT=$FRAMEWORK.framework
DSYM_NAME_WITH_EXT=$FRAMEWORK_NAME_WITH_EXT.dSYM

IOS_ARCHIVE_DIR=Release-iphoneos.xcarchive
IOS_ARCHIVE_FRAMEWORK_PATH=$BUILD/$IOS_ARCHIVE_DIR/Products/Library/Frameworks/$FRAMEWORK_NAME_WITH_EXT
IOS_ARCHIVE_DSYM_PATH=$BUILD/$IOS_ARCHIVE_DIR/dSYMs
IOS_UNIVERSAL_DIR=Release-universal-iOS

echo "### Performing iOS UnityLibrary export"
#/Applications/Unity/Hub/Editor/2019.3.6f1/Unity.app/Contents/MacOS/Unity -quit -batchmode -executeMethod $UNITY_BUILD_SCRIPT_METHOD_NAME -projectPath $UNITY_PROJECT_PATH

echo "### Cleaning up after old builds"

rm -rf ios/$FRAMEWORK_NAME_WITH_EXT
cd $PROJECT_DIR
rm -Rf $BUILD

echo "### BUILDING FOR iOS"
echo "### Building for device (Archive)"

# iOS build
xcodebuild archive\
           -project $XCPROJ_NAME\
           -scheme $SCHEME_NAME\
           -sdk iphoneos\
           -archivePath $BUILD/Release-iphoneos.xcarchive\
            ENABLE_BITCODE=YES\
    | xcpretty

#echo "### Copying framework files"

cp -RL $IOS_ARCHIVE_FRAMEWORK_PATH ../../ios/$FRAMEWORK_NAME_WITH_EXT
cp -RL $IOS_ARCHIVE_DSYM_PATH/$DSYM_NAME_WITH_EXT ../../ios/$DSYM_NAME_WITH_EXT