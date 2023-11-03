//
//  VideoAppApp.swift
//  VideoApp
//
//  Created by Victoria Galikova on 02/11/2023.
//

import SwiftUI

@main
struct VideoAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
            
        }
    }
}
