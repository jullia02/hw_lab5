# Swift Repos

---

## Overview

1. In this lab, we will build an application to look at the most popular Swift repisitories on GitHub using the GitHub API and many of the skills we have learned in class. You are allowed and encouraged to use Alamofire and Codable to make it easier to write this lab and to produce cleaner code. The final application will look like this:

   <img src=https://i.imgur.com/cOtGPmp.png?1 width="25%"/>

   ## Setup

   1. Clone the [starter code](https://github.com/stephkananth/67443_SwiftRepos_Starter).

   2. Install [CocoaPods](https://cocoapods.org/) by running the command: `sudo gem install cocoapods`.

   3. Install [Alamofire](https://github.com/Alamofire/Alamofire).

      1. Navigate into the outer `SwiftRepos` directory and run `pod init`. This will create a `Podfile`.

      2. Add the following line to your `Podfile`:

         ```swift
         pod 'Alamofire', '~> 5.0'
         ```

      3. Run the command: `pod install` in your teminal.

      4. You may need to manually `Link Binary With Libraries` as shown below if Xcode does not recognize Alamofire.

         <img src=https://i.imgur.com/7VkGGdX.png?1/>

   4. You are now ready to use Alamofire.

   

   ## Models

   1. Look at the file called `Repository.swift`. Take note of the simple structure of the model.

   2. Here is the [JSON](https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc) we are going to parse. Look at it and take note of its structure, look at the fields you are going to need. Modify `Repository.swift` to better fit the data with a struct called `Repositories` for the highest level of the JSON and the appropriate `enum`s for each struct.

   3. Open up the `Parser.swift`. If you are going to use the [Codable](https://developer.apple.com/documentation/swift/codable) Protocol (which I suggest you do), here is some really great [documentation](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types). Make sure you understand how this protocol works.

      ## View Model

      1. Open up the `ViewModel.Swift`.

      2. Make sure this class inherits from `ObservableObject`, and in this class:

         1. Create an instance of your `Parser` and create `@Published` variables for:

            * `repos`: An array of all the `Repository` objects
            * `searchText`: The search bar text as a `String`
            * `filteredRepos`: An array of the filtered `Repository` objects

         2. Write a method called `update()` that updates the `repos` from the `Parser`'s `update()` method.

         3. Add the following method that will filter the repos:

            ```swift
              func search(searchText: String) {
                self.filteredRepos = self.repos.filter { repo in
                  return repo.name.lowercased().contains(searchText.lowercased())
                }
              }
            ```

## Views

### List Row Cell (`RepositoryRow`)

Create a cell that displays the repository's `name` and `itemDescription` that will be used in the List View. If you are having issues with this, [here](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation) is an excellent resource that will also be helpful for creating the List View.

### List View (`ContentView`)

1. Create an instance of the `ViewModel`. This should be an `@ObservedObject`. Create `@State` variables for the `searchField` and the `displayedRepos`.

2. In the `ContentView.Swift`, create a view with a Search Bar (`TextField`) and List View (`List`) using `displayedRepos`.

3. Fill in the method `displayRepos` to set `displayedRepos` based on the `searchField`.

4. To update the repos responsively (as the user types), we are going to need to create a custom binding for the `searchField` from the search bar:

   ```swift
       let binding = Binding<String>(get: {
         self.searchField
       }, set: {
         self.searchField = $0
         self.viewModel.update()
         self.viewModel.search(searchText: self.searchField)
         self.displayRepos()
       })
   ```

   This goes right under `var body: some View`.

5. Note the `.onAppear(perform: self.displayRepos)`. This is updating the `displayedRepos` when the View appears.

### WebView (`RepositoryDetail`)

This view is given to you. Look it over to see how it works. Make sure each row in the list (in the `ContentView`) links to the appropriate GitHub repo. (hint: use a `NavigationLink`.)

If time allows, you can also explore customizing the views more and cleaning up some of the code.  Feel free to explore further--that's where the real fun and learning is!

Qapla'





