//
//  VideoAppApp.swift
//  VideoApp
//
//  Created by Sebastian Mraz on 02/11/2023.
//

import SwiftUI

@main
struct VideoAppApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: VideoAppDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
