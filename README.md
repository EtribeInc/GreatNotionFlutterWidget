# flutter_unity_widget

## Installation
 First depend on the library by adding this to your packages `pubspec.yaml`:

```yaml
dependencies:
  flutter_unity_widget: ^4.0.0-beta
```

Now inside your Dart code you can import it.

```dart
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
```
<br />

## Preview

30 fps gifs, showcasing communication between Flutter and Unity:

![gif](https://github.com/juicycleff/flutter-unity-view-widget/blob/master/files/preview_android.gif?raw=true)
![gif](https://github.com/juicycleff/flutter-unity-view-widget/blob/master/files/preview_ios.gif?raw=true)

<br />

## Setup Project
For this, there is also a video tutorial, which you can find a [here](https://www.youtube.com/watch?v=exNPmv_7--Q).

### Add Unity Project

1. Create an unity project, Example: 'UnityDemoApp'.
2. Create a folder named `unity` in flutter project folder.
2. Move unity project folder to `unity` folder.

Now your project files should look like this.

```
.
├── android
├── ios
├── lib
├── test
├── unity
│   └── <Your Unity Project>    // Example: UnityDemoApp
├── pubspec.yml
├── README.md
```

### Configure Player Settings

1. First Open Unity Project.

2. Click Menu: File => Build Settings

Be sure you have at least one scene added to your build.

3. => Player Settings

   **Android Platform**:
    1. Change `Scripting Backend` to IL2CPP.

    2. Mark the following `Target Architectures` :
        - ARMv7        ✅
        - ARM64        ✅
        - x86          ✅ (In Unity Version 2019.2+, this feature is not avaliable due to the lack of Unity Official Support)

<img src="https://raw.githubusercontent.com/juicycleff/flutter-unity-view-widget/master/files/Screenshot%202019-03-27%2007.31.55.png" width="400" />

   **iOS Platform**:
    1. Depending on where you want to test or run your app, (simulator or physical device), you should select the appropriate SDK on `Target SDK`.
      <br />

<br />