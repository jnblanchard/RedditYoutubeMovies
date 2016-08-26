# Setup
* Clone repo and switch to test branch.
* Run a pod install.

# Summary
Finish the implementation of an iOS app that provides a platform for watching movies posted on [Reddit Youtube Movies](https://www.reddit.com/r/fullmoviesonyoutube).

Parse (https://www.reddit.com/r/fullmoviesonyoutube) and provide a simple display for choosing a movie to watch. Only need to provide a display for the first page of the subreddit.

Selected movies are loaded with the Youtube ID. [Youtube Player Helper Docs](https://developers.google.com/youtube/v3/guides/ios_youtube_helper)


# Goals
* libxml2 installation (If you want to use TFHpple for HTML/XML page parser) OPTIONAL
* Parse https://www.reddit.com/r/fullmoviesonyoutube and pull movie titles/Youtube IDs. Dequeue tableview cell to hold movie titles
* Selecting a cell will create a new ViewController that loads a movie using the Youtube player helper.
