# task_manager_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:
![Screenshot_1739619220](https://github.com/user-attachments/assets/0b8e9848-e509-49e8-8627-880ad6398aa2)
![Screenshot_1739619174](https://github.com/user-attachments/assets/8897ed6b-2850-4caf-81ff-d30f32ff4a53)
![Screenshot_1739619170](https://github.com/user-attachments/assets/aee16564-b9b5-4bf9-b890-fa9bf141168a)
![Screenshot_1739618993](https://github.com/user-attachments/assets/d691c064-2516-4fc6-bac3-2c87b4a15385)
![Screenshot_1739619228](https://github.com/user-attachments/assets/f9957e53-0452-46ca-b781-37db2b0066ba)
![Screenshot_1739619237](https://github.com/user-attachments/assets/be5c7d7b-b8c3-4d45-ac41-df3242539869)
![Screenshot_1739619217](https://github.com/user-attachments/assets/54574fa2-5413-4dac-b005-f6a19c40345d)
![Screenshot_1739619190](https://github.com/user-attachments/assets/d9921266-0bc9-4861-9ab4-00a70b075d2b)
![Screenshot_1739619251](https://github.com/user-attachments/assets/b6c3c8bc-0adb-4907-befe-f518b03cb496)



## Get the Flutter SDK
1.  Download the following installation bundle to get the latest stable release of the Flutter SDK from [here](https://flutter.dev/docs/get-started/install/linux)
2.  Extract the file in the desired location, for example:
```
$ cd ~/development
$ tar xf ~/Downloads/flutter_linux_1.17.5-stable.tar.xz
```
3.  Add the flutter tool to your path:
```
$ export PATH="$PATH:`pwd`/flutter/bin"
```

This command sets your PATH variable for the current terminal window only.
To make it permanent and run flutter commands in any terminal session follow next steps for modifying 
this variable permanently for all terminal sessions are machine-specific. 
Typically you add a line to a file that is executed whenever you open a new window. For example:

1. Determine the directory where you placed the Flutter SDK. You need this in Step 3.
2. Open (or create) the rc file for your shell. For example, Linux uses the Bash shell by default, so edit $HOME/.bashrc. 
If you are using a different shell, the file path and filename will be different on your machine.
3. Add the following line and change [PATH_TO_FLUTTER_DIRECTORY] to be the path where you cloned Flutter’s git repo:
```
$ export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/flutter/bin"
```
4. Run ```source $HOME/.<rc file>``` to refresh the current window, or open a new terminal window to automatically source the file.

Else you can also do the same thing in /etc/profile if you have administrator privileges.

### Run the Doctor
Run the following command to see if there are any dependencies you need to install to complete the setup (for verbose output, add the -v flag):
```
$ flutter doctor -v
```
This command checks your environment and displays a report to the terminal window. The Dart SDK is bundled with Flutter; 
it is not necessary to install Dart separately.
Once you have installed any missing dependencies, run the ```$ flutter doctor``` command again to verify that you’ve set everything up correctly.

Basically by using the doctor option you can check if we need to install further dependencies.

## Android Setup

Flutter relies on a full installation of Android Studio to supply its Android platform dependencies like emulator. However, you can write your Flutter apps in a number of editors; a later step discusses where we'll be writing in VSCode and use the emulator of android studio.
1.  Download and install [Android Studio](https://developer.android.com/studio#downloads).
2.  Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools, which are required by Flutter when developing for Android.

### Add Dart Plugin to Android Studio
If you prefer to use Android Studio as your main IDE to develop Flutter, you have to set dart language support to Android Studio as shown below.

Preferences → Plugins → Browse Repository → type Dart in search bar → Install and Restart android studio.

### Add Flutter Plugin to Android Studio

Preferences → Plugins → Browse Repository → type Flutter in search bar → Install and Restart android studio.

## Set up the Android emulator

*To prepare, run and test your **Flutter app on the Android emulator**, follow these steps:*

* Tools → AVD Manager → Opens a window

* Select → Create Virtual Device

* Phone → [Choose Any] → [Choose System Image, typically the highest one is most preferred] → Android 8.1 → AVD Name(Pixel 2 API 27)

* Choose Graphics → Hardware → Finish

* Select Pixel 2 API 27 emulator → click on Launch AVD(start) button



