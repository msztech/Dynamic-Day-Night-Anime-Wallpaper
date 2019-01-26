# Dynamic Day Night Anime Wallpaper Tool

![Image of Interface](https://s3-us-west-1.amazonaws.com/public-sharing-storage/2.png)

## What is it?
With Core ML 🤖, you can drag your favorite anime wallpapers. The machine learning will automatically recognize the daylight condition (whether day or night) of the image, and change your wallpaper accordingly at different times of a day.

## How to use?
- You can compile and run the sources directly.
- Or you can download [releases](https://github.com/msztech/Dynamic-Day-Night-Anime-Wallpaper/releases) directly
- When running: Select a folder that contains only the images (with no sub-directories) -> Wait for ML to recognize -> Correct the wrong recognitions by clicking on the image name -> Minimize the program (do not close the window)

## What does the Machine Learning Module recognize?
It's trained with a limited set of features in the anime wallpaper, like the sky, the cloud, and nearby environment to help the machine differentiate between daytime and night.

![Image of Interface](https://s3-us-west-1.amazonaws.com/public-sharing-storage/3.png)

## What can be improved? (TO-DO)
- PR is welcomed! ;-)
- The ML module was only trained with a limited amount of images. Could add more images. Also, it's possible to train additional images to help it recognize other types of images.
- The app should be able to run in the background with a icon and menu on the system bar.
- The UI interface needs more work.

## Important Views

### [ViewController.swift](https://github.com/msztech/Dynamic-Day-Night-Anime-Wallpaper/blob/master/Dynamic%20Anime%20Wallpaper/ViewController.swift)
Presents the user basic interface and file selector to allow users to choose a path. After a path is chosen, it will proform a ML Vision request for the images, and show a progress bar.

### [confirmView.swift](https://github.com/msztech/Dynamic-Day-Night-Anime-Wallpaper/blob/master/Dynamic%20Anime%20Wallpaper/confirmView.swift)
This view shows the result of the ML Vision recognition through a TableView. You can click on the cell (image name) to switch its status (day/ night)
