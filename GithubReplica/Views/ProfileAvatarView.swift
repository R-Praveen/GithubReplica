import Foundation
import SwiftUI

struct ProfileAvatarView: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            ProgressView()
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .shadow(radius: 10)
    }
}

#Preview {
    ProfileAvatarView(url: "url")
}
