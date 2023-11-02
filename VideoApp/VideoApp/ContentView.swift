//
//  ContentView.swift
//  VideoApp
//
//  Created by Sebastian Mraz on 02/11/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: VideoAppDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(VideoAppDocument()))
    }
}
