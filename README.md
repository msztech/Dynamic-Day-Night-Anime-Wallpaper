# Dynamic Day Night Anime Wallpaper Tool

![Image of Interface](https://s3-us-west-1.amazonaws.com/public-sharing-storage/2.png)

## What is it?
This is a demo of Core ML 🤖. Simply drag your favorite anime wallpapers, and the machine learning module will automatically recognize the daylight condition (whether day or night) of the image, and change your wallpaper accordingly at different times of a day.

## How to use?
- You can compile and run the sources directly.
- Or you can download [releases](https://github.com/msztech/Dynamic-Day-Night-Anime-Wallpaper/releases) directly
- When running: Select a folder that contains only the images (with no sub-directories) -> Wait for ML to recognize -> Correct the wrong recognitions by clicking on the image name -> And, Minimize the program (do not close the window)

## What does the Machine Learning Module recognize?
It's trained with a limited set of features in the anime wallpaper, like the sky, the cloud, and nearby environment to help the machine differentiate between daytime and night.

![Image of Interface](https://s3-us-west-1.amazonaws.com/public-sharing-storage/3.png)

## Views

### [ViewController.swift](https://github.com/msztech/Dynamic-Day-Night-Anime-Wallpaper/blob/master/Dynamic%20Anime%20Wallpaper/ViewController.swift)
Presents the user basic interface and file selector to allow users to choose a path. After a path is chosen, it will proform a ML Vision request for the images, and show a progress bar.

### [confirmView.swift](https://github.com/msztech/Dynamic-Day-Night-Anime-Wallpaper/blob/master/Dynamic%20Anime%20Wallpaper/confirmView.swift)
This view shows the result of the ML Vision recognition through a TableView. You can click on the cell (image name) to switch its status (day/ night)

## Why make this app?
I make a lot of other apps and have projects. This project is built just for fun and for experimenting the possible applications of Core ML.

## License
MIT License

Copyright (c) [2019] [Shunzhe Ma]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
