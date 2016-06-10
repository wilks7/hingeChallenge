# hingeChallenge
Code Challenge for Hinge

Code Test: Large Photo App

Write a simple iOS application in Swift using latest apple’s design guidlines based on the following data feed (https://hinge q-homework.s3.amazonaws.com/client/services/homework.json).

The app should consists of two views:

Homepage View
	- Displays thumbnails of all the images downloaded from the API endpoint above.
	- A user can scroll through thumbnails of all the images.
	- Images should be displayed in the order indicated by the server.
	- Each image should be downloaded asynchronously and in a thread-safe manner.
	- Clicking on a thumbnail should open a Gallery View

Gallery View (Consists of 2 sections) ßßß
  Image View
	..* Should display a single image to fit the area. 
	- Will initially display the image that was clicked on in the previous step.
	- Every two seconds the view should progress to the next image in the list.
	- After the last image is displayed, starting over with the first image in the list.
  Navigation Bar
	- Back arrow button to return back to the Homepage. 
	- Displays image’s position in the list (i.e., “5/16”).
	- Includes a button that removes an image from the list.


Additional Requirements
	- Testing is very important. Show us you know how to test the important pieces of your code.
	- The code should be clean and readable, and you should follow best practices for architecture, code formatting, variable/class names, etc.
	- Please include a README with any steps needed to start, and test your app.
	- Use comments where required. 
	- You can assume we have:
	    XCode
	    Git
	- If there are any other required tools to run the project please specify or include a bundle.
	- The app should cache data for offline use.
	- The app should be attractive if initially started in offline mode.
