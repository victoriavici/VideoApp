//
//  MainViewModel.swift
//  VideoApp
//
//  Created by Victoria Galikova on 02/11/2023.
//

import Foundation

class MainViewModel: ObservableObject, Identifiable {
    
    @Published var listOfVideos: [Video] = []
    
    init() {
        load()
    }
    
    func fetchVideosFromAPI() async throws -> [Video] {
        if let url = URL(string: "https://fksoftware.sk/video/data.json") {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(VideoResponse.self, from: data)
            return decoded.lessons
        }
        return []
    }
    
    func load() {
        Task {
            do {
                listOfVideos = try await fetchVideosFromAPI()
            } catch {
                print(error)
            }
        }
    }
    
}

