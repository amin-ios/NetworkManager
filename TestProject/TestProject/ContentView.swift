//
//  ContentView.swift
//  TestProject
//
//  Created by Amin on 08/02/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: TestViewModel = .init()
    
    var body: some View {
        VStack {
            if let image = UIImage(data: viewModel.imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
            } else {
                Image(uiImage: .init(systemName: "photo.on.rectangle") ?? .add)
            }
                
        }
        
        .task {
            try? await viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
