# DHAudioRecorder #

`DHAudioRecorder` is an Objective-C class for recording audio on iOS and managing the related user interface. It connects a record button and a playback button to an audio file using `AVAudioRecorder` and `AVAudioPlayer`.

This repository contains the source for `DHAudioRecorder` and a simple demo project.

## Status ##

Tested with Xcode 7 and iOS 9. The demo is currently excessively basic.

## Usage ##

Add `DHAudioRecorder.h` and `DHAudioRecorder.m` to an iOS project. 

Create and configure two `UIButton`s — one for recording and one for playback. These may be styled and placed in the user interface however desired. Create a new `DHAudioRecorder`, passing your buttons at initialisation along with a file URL at which to save the audio. The path file extension must be supported by `AVAudioRecorder`.

Keep a strong reference to the audio recorder so it is not deallocated.

Run the app, then tap the record and play buttons.

## Licence ##

MIT License — see License.txt
