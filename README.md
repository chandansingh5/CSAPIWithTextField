# SwiftSerchWithAPI

# Goal :- 
If search operations can be carried out very rapidly, it is possible to update the search results as the user is typing by implementing the searchBar:textDidChange: method on the delegate object. However, if a search operation takes more time, you should wait until the user taps the Search button before beginning the search in the searchBarSearchButtonClicked: method. Always perform search operations a background thread to avoid blocking the main thread. This keeps your app responsive to the user while the search is running and provides a better user experience.
