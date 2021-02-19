# flutter_unity_widget

## Develop
### Setup Unity Project
1. Initialize git submodule
    ```bash
        $ git submodule init 
    ```
2. Open the project in path (`unity/GreatNotionAR`) in the unity app
3. In unity from the file menu, select `💚 Etribe/Flutter/Export Android` for Android export and `💚 Etribe/Flutter/Export iOS`.
4. Finally run this command in the soot of the repository
    ```bash
        $ sh build-ios.sh
    ```

### Make a release
The release is based on git tags

1. Stash your git changes and create a git tag, then push the tags to github
    ```bash
        $ git tag v1.0.0-example
        $ git push origin tag v1.0.0-example
    ```

## Integration
### Installation
 1. First depend on the library by adding this to your packages `pubspec.yaml`:

    ```yaml
    dependencies:
      flutter_unity_widget:
        git:
            url: https://github.com/EtribeInc/GreatNotionFlutterWidget
            ref: v1.3.0
    ```

### Setup iOS

Now lets initialize unity in Flutter iOS project. Go to `ios/Runner/AppDelegate.swift` and update it

```swift
import UIKit
import Flutter
import flutter_unity_widget

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, PickedImageAcceptable, PayTokenValidatable {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Init flutter unity
        InitUnityIntegrationWithOptions(argc: CommandLine.argc, argv: CommandLine.unsafeArgv, launchOptions)
    }
}
```
<br />

### Setup Android

Now lets initialize unity in Flutter Android project. Go to `android/settings.gradle` and update it

```gradle
include ':app'

def localPropertiesFile = new File(rootProject.projectDir, "local.properties")
def properties = new Properties()

assert localPropertiesFile.exists()
localPropertiesFile.withReader("UTF-8") { reader -> properties.load(reader) }

def flutterProjectRoot = rootProject.projectDir.parentFile.toPath()

def plugins = new Properties()
def pluginsFile = new File(flutterProjectRoot.toFile(), '.flutter-plugins')
if (pluginsFile.exists()) {
    pluginsFile.withReader('UTF-8') { reader -> plugins.load(reader) }
}

plugins.each { name, path ->
    def pluginDirectory = flutterProjectRoot.resolve(path).resolve('android').toFile()
    include ":$name"
    project(":$name").projectDir = pluginDirectory

    if (name == 'flutter_unity_widget') {
        include ":unityLibrary"
        project(":unityLibrary").projectDir=flutterProjectRoot.resolve(path).resolve('android/unityLibrary').toFile()
    }
}
```
<br />

Now you can run your build