import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var searchField = ""
    @State var displayedRepos = [Repository]()
  
  var body: some View {
      let binding = Binding<String>(get: {
          self.searchField
      }, set: {
          self.searchField = $0
          self.viewModel.search(searchText: self.searchField)
          self.displayRepos()
      })
    
      return NavigationView{
          VStack{
              TextField("Search", text: binding)
                  .padding(.leading)
                  .padding(.top,5)
              List(displayedRepos) { repository in
                  NavigationLink(destination: WebView(request: URLRequest(url: URL(string: repository.htmlURL)!))) {
                      RepositoryRow(repository: repository)
                  }
              }
              .navigationBarTitle("SwiftRepos", displayMode: .inline)
              Spacer()
          }.onAppear{
              Task {
                  await loadData()
              }
          }
      }
  }
    func loadData() async{
        let repos = await Parser().fetchRepositories()
        self.viewModel.repos = repos
        self.displayedRepos = repos
    }
  func displayRepos() {
    // set displayedRepos appropriately
      if searchField == "" {
          displayedRepos = viewModel.repos
      } else {
          displayedRepos = viewModel.filteredRepos
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
