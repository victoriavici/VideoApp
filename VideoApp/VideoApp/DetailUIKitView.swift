//
//  DetailUIKitView.swift
//  VideoApp
//
//  Created by Victoria Galikova on 03/11/2023.
//

import SwiftUI

struct DetailUIKitView: UIViewControllerRepresentable {
    
    let video: Video
    let lessons: [Video]

    func makeUIViewController(context: Context) -> DetailViewController {
        return DetailViewController(video: video, lessons: lessons)
    }

    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {
        if uiViewController.video != video {
                uiViewController.video = video
            }

        if uiViewController.lessons != lessons {
                uiViewController.lessons = lessons
        }
    }
    
}
