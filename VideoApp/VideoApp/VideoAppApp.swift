//
//  VideoAppApp.swift
//  VideoApp
//
//  Created by Victoria Galikova on 02/11/2023.
//

import SwiftUI

@main
struct VideoAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
    
}

class AppDelegate: NSObject,UIApplicationDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
}
