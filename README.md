# FirebaseDemoApp

Features:

Display a list of issues to the user
Order by most-recently updated issue first
Issue titles and first 140 characters of the issue body should be shown in the list
on issue detail screen containing all comments for that issue
Detail screen contains comment body, user name of each comment and avatar image
issues are only fetched once in 24 hours. The current data is shown to user and old data should be discarded
A guarantee that the same URL won't be call several times for issue list till 24 hours
A guarantee that main thread will never be blocked
Additional modules:

Integration with 3rd party libraries

SDWebImage- for asynchronous image downloader
Requirements:

iOS 10.0 or later
Xcode 10.0 or later
Approach taken to develop this App:

MVVM architecture- View Model(FirebaseIssuesViewModel) that represents the data for the view and the business logic. View (FirebaseIssuesListVC) will consists of a simple UITableView control, which uses the default UITableView cell for display. Model (FirebaseModel) will consists of properties that can provide the title, description
Core Data- Core data is used to store firebaseIssuesList data(body, number, title, comments_url) inside SQLite.
SDWebImage library for image catching
NSUrlSession for network call in ApiRequest class.
