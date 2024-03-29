# Godot VR and Non-VR Example

Basic example of a game that supports VR and non-VR mode.

**IMPORTANT:** You must have enabled OpenXR and XR Shader in the Project Settings at least once before. After that, OpenXR can be disabled in the Project Settings (optionally).

An EditorPlugin is included that adds a CheckButton (toggle) called "XR Enabled" which enables/disables OpenXR when running the project from the editor. It also includes an EditorExportPlugin that forces OpenXR when exporting for Android.

The "RESTART WITH XR" button that shows up when running in desktop mode will close the game and restart with OpenXR enabled (only on exported projects).

In the `main.gd` file, you'll see how to identify when OpenXR was requested, but it failed to start, and it fallsback to desktop mode when that happens.