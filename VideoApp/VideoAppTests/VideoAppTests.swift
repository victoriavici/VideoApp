//
//  VideoAppTests.swift
//  VideoAppTests
//
//  Created by Victoria Galikova on 02/11/2023.
//

import XCTest
@testable import VideoApp

final class VideoAppTests: XCTestCase {
    
    func testFetchData() {
        
        let model = MainViewModel()
        XCTAssertNotNil(model.listOfVideos)
        
    }
    
    func testDownloading() {
        
        let video =  Video(id: 1, name: "Bird", description: "A bird in the city", thumbnail: "https://fksoftware.sk/video/video.png", video_url: "https://fksoftware.sk/video/video.mp4")
        
        var controller = DetailViewController(video: video, lessons: [video])
        controller.viewDidLoad()
        controller.viewWillAppear(true)
        controller.downloadButton.sendActions(for: .touchUpInside)
        
        XCTAssertNotNil(controller.downloadTask)
        XCTAssertEqual(controller.downloadButton.title(for: .normal), "Downloading...")
        XCTAssertFalse(controller.downloadButton.isEnabled)
        
        sleep(10)
        
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let videoDirectory = cacheDirectory.appendingPathComponent("videa")
            let videoURL = videoDirectory.appendingPathComponent("\(video.id).mp4")
            
            XCTAssertTrue(FileManager.default.fileExists(atPath: videoURL.path))
        }
    }
    
    func testNextVideo() {
        
        let video1 =  Video(id: 1, name: "Bird", description: "A bird in the city", thumbnail: "https://fksoftware.sk/video/video.png", video_url: "https://fksoftware.sk/video/video.mp4")
        let video2 =  Video(id: 2, name: "Goldfinches eating", description: "Goldfinches eating", thumbnail: "https://fksoftware.sk/video/video_of_goldfinches_eating.png", video_url: "https://fksoftware.sk/video/video_of_goldfinches_eating.mp4")
        
        var controller = DetailViewController(video: video1, lessons: [video1, video2])
        controller.viewDidLoad()
        controller.viewWillAppear(true)
        
        XCTAssertTrue(controller.video == video1)
        controller.nextButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(controller.video == video2)
        controller.nextButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(controller.video == video1)
    }
    
}
