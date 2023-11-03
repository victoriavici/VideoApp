//
//  DetailUIKitView.swift
//  VideoApp
//
//  Created by Victoria Galikova on 03/11/2023.
//

import SwiftUI

struct DetailUIKitView: UIViewControllerRepresentable {
    let video: Video

    func makeUIViewController(context: Context) -> DetailViewController {
        return DetailViewController(video: video)
    }

    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {
        //todo
    }
}
