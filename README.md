# Godot VR and Non-VR Example

Basic example of a game that supports VR and non-VR mode.

This example uses a combination of two techniques:

- **OS.set_restart_on_exit**: used to restart the game with OpenXR enabled in release builds.
- **Override config file**: used to let the editor know that the next start has to have OpenXR enabled.

Press **ENTER** to switch to VR mode. The game will close and the next time it starts, it will start in VR.
