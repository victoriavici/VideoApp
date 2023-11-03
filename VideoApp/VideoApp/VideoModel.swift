//
//  VideoModel.swift
//  VideoApp
//
//  Created by Victoria Galikova on 02/11/2023.
//

import Foundation

struct VideoResponse : Decodable, Identifiable {
    var id: UUID?
    var lessons: [Video]
    
}

struct Video : Decodable, Identifiable {
    
    let id : Int
    let name : String
    let description : String
    let thumbnail : String
    let video_url : String
    
}


