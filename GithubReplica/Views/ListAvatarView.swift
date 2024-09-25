import SwiftUI

struct ListAvatarView: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
}

#Preview {
    ListAvatarView(url: "url")
}
