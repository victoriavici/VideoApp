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

struct Video : Decodable, Identifiable, Equatable {
    
    let id : Int
    let name : String
    let description : String
    let thumbnail : String
    let video_url : String
    
    static func == (lhs: Video, rhs: Video) -> Bool {
           return lhs.video_url == rhs.video_url
               && lhs.id == rhs.id
               && lhs.description == rhs.description
               && lhs.name == rhs.name
       }
    
}


