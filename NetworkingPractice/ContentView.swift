import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = PostViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach (vm.posts) { post in
                    VStack (alignment: .leading, spacing: 10) {
                        Text(post.title)
                            .font(Font.title.bold())
                        Text(post.body)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Fetch API")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
