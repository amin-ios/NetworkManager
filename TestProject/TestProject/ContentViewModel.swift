//
//  ContentViewModel.swift
//  TestProject
//
//  Created by Amin on 08/02/2026.
//

import Foundation
import Combine
import NetworkManager

class TestViewModel: ObservableObject {
    @Published var imageData: Data = .init()
    
    
    @MainActor
    func fetch() async throws {
        do {
            let data = try await APIClient().execute(request: TestEndPoint.fetchImages)
            imageData = data
        } catch {
            print(error.localizedDescription)
        }
    }
}
