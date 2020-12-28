# AcheiUSA

## Use case
This channel shows how to load a JSON feed into a ScenGraph RowList in Roku. 
This  channel should be used as a playing the videos selected from the rowlist.
The FeedParser.brs file has the brightscript code to load the feed data.
The data is then translated into an array of items.
Then the data to structured to load into a RowList, which is represented in HomeScene.xml


## How to run this App
- Zip up the entire project directory and deploy to your roku device. 
- Alternatively, open up this project in Eclipse and use the corresponding plugin/package to export/deploy the channel.


## Directory Structure
- **Components:** The Scene Graph components
  - **FeedParser.brs/xml** A task node that is used to load the feed data.
  -**PosterItem.xml:** A poster image to be displayed on homescene background.
  -**DetailsScreen.brs/xml** A detail screen used to display the detail view of the selected videos items and play the video.
  - **HomeScene.brs/xml:** The main scene.
- **Images:** Contains image assets used in the channel
- **Source:** Contains the main brightscript file that runs right when the channel starts
