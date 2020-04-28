import SwiftUI

struct ContentView: View {
  
  // @ObservedObject instance of ViewModel
  
  // @State var searchField
  // @State var displayedRepos
  
  var body: some View {
    return NavigationView {
      VStack{
        // TextField (Search Bar)
        // List
        Spacer()
      }.onAppear(perform: self.displayRepos)
    }
  }
  
  func displayRepos() {
    // set displayedRepos appropriately
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
