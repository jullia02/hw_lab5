import Foundation
import Alamofire

class Parser {
  
  var repositories: [Repository] = []
  
  required init() {
    AF.request("https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc").responseDecodable(of: Repositories.self) { response in
      if let value: Repositories = response.value {
        self.repositories = value.items
      }
    }
  }
  
  func update() -> [Repository] {
    if repositories.isEmpty {
      _ = type(of: self).init()
    }
    return self.repositories
  }
}
