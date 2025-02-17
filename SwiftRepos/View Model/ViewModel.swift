import Foundation

class ViewModel: ObservableObject {
  
  // instance of parser
  
  // MARK: Fields
    @Published var repos: [Repository] = []
    @Published var searchText: String = ""
    @Published var filteredRepos: [Repository] = []
  
  // MARK: Methods
  
  func search(searchText: String) {
      filteredRepos = repos.filter { repo in
          return repo.name.lowercased().contains(searchText.lowercased())
      }

  }
}
