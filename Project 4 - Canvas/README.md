Homework 4
---
###Fourth homework project for CodePath (https://github.com/thecodepath/ios_guides/wiki/Canvas-Homework)

* **How many hours did it take to complete?**
  * ***SO MANY HOURS***
* **Which required and optional stories have you completed?**
  * :white_large_square: Implement scrollable tray of images
    * :white_check_mark: You should be able to drag the tray up or down.
    * :white_large_square: Once the tray is revealed, you shouldn't be able to drag it any more.
    * :white_check_mark: After releasing the tray, it should either move to its hidden position or its revealed position.
  * :white_check_mark: Dragging an image from the tray should create a new copy of the image which can be dragged into the canvas area.
  * :white_check_mark: Pinching images in the canvas area should resize them
  * :white_check_mark: *Optional*: Allow the user to rotate the image
  * :white_large_square: *Optional*: Add a camera icon to the tray
    * :white_large_square: *Optional*: Tapping the camera icon opens the camera.
    * :white_large_square: *Optional*: After taking a picture, the picture is added to the view as a background view
  * **GIF walkthrough of all required and optional stories (using LICEcap)**

| Image                | Description            |
| ------------------- |:-------------------|
| <img width="220" src="http://i.imgur.com/2BUQabR.gif"/>  | Dragging the stickers to the canvas and repositioning them.|
| <img width="220" src="http://i.imgur.com/ExhuboI.gif"/>  | Scaling and rescaling the stickers.|
| <img width="220" src="http://i.imgur.com/ipRaFI1.gif"/>  | Rotating and rotating again with the same initial rotation.|


---

####Notes
This homework was INTENSE.

At the time of submission, I still have some problems.
 - The pan gesture recognizer interferes with the scroll view. My plan was to use the pan gesture recognizer to get the drawer into position, then disable/destroy it in order to let the scroll view's native gestures take over.
 - The rotation/scaling is a little funky. It comes down to a math issue mostly. The rotation is accurate to the finger position (by converting radians), but it lags pretty hard.
 - The variables for scaling/rotation are global, so when I scale&rotate a sticker, the next sticker I size inherits the previous sticker's rotation. Ideally each generated sticker would have it's own variables to track themselves.

 I really wanted to get to implementing the camera, but there simply wasn't enough time. (Even with me calling in some sick time @work).
