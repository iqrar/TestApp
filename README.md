# iOS-JSON-Parse

Specification

Create an iPhone app which:

	•	Ingests a json feed from https://api.myjson.com/bins/42be7
	•	The touchJSON library can be used to parse this json if desired.
	•	The feed contains a title and a list of rows

	•	Displays the content in a UITableView
	•	The title in the navbar should be updated from the json
	•	Each row should be the right height to display its own content and no taller. No content should be clipped. This means some rows will be larger than others.

	•	Loads the images lazily
	•	Don't download them all at once, but only as needed
	•	Refresh function
	•	Either place a refresh button or use pull down to refresh.
	•	Should not block UI when loading the data from the json feed.

Guidelines

	•	Use Git to manage the source code. Clear Git history is required.
	•	Do not use any .xib files
	•	Do not use ARC. Memory should be alloced/released.
	•	Should perform well on an iPhone 4
	•	Scrolling the table view should be smooth, even as images are downloading and getting added to the cells
	•	Support back to iOS 6.0
	•	If threading is used, do no spawn threads manually by using performSelectorOnBackgroundThread. Use GCD queues instead.
	•	Comment your code when necessary.
	•	Try to polish your code as much as possible.
	•	Style your code according to these Google guidelines (links)
	•	Variable_Names
	•	Member_Variables_Should_Be_@private
	•	Keep_the_Public_API_Simple
	•	Prefer_To_autorelease_At_Time_of_Creation
	•	Properties
	•	Automatically_Synthesized_Instance_Variables


Finally, each row of the table should look roughly like the following image. It does not need to be exact, but should have a title at the top in blue, the description underneath it in black, and the image (when one exists) somewhere on the right.
