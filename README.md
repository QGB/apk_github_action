# Hello World Android App

This is a simple Hello World Android app built with GitHub Actions using the ni554n/apk-builder-action.

## How to use

1. Push changes to the main branch
2. GitHub Actions will automatically build the APK
3. Download the APK from the Actions tab in GitHub

## Project structure

- `app/src/main/java/com/example/helloworld/MainActivity.java` - Main activity with Hello World code
- `app/src/main/AndroidManifest.xml` - Android manifest file
- `app/build.gradle` - App module build file
- `build.gradle` - Project build file
- `.github/workflows/build-apk.yml` - GitHub Actions workflow file