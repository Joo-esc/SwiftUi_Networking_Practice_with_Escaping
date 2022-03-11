import SwiftUI

class PostViewModel: ObservableObject {
     @Published var posts: [PostModel] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        // URL, Optional Type
        guard let url = URL.init(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        
        fetchApi(fromUrl: url) { data in
            if let data = data {
                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                // Background Thread에서 관리
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPost
                    print("API 호출 성공")
                }
            } else {
                print("호출 실패")
            }
        }
    }
    
    // Escape Closure
    func fetchApi(fromUrl url: URL, complectionHnalder: @escaping (_ data: Data?) -> ()) {
        // Networking Api Source 관리 및 예외처리 진행
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                print("API 호출 실패 [fetch 단계]")
                complectionHnalder(nil)
                return
            }
            complectionHnalder(data)
        }
        .resume()
    }
}

