//
//  MainView.swift
//  VideoApp
//
//  Created by Victoria Galikova on 02/11/2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel : MainViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Videá")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 18)
                    .padding(.top, 18)
                    .padding(.bottom,8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                List {
                    ForEach(viewModel.listOfVideos) { video in
                        videoListItem(video: video)
                    }
                }.listStyle(.plain)
            }
        }
    }
}

extension MainView {
    
    func videoListItem(video: Video) -> some View {
           VStack {
               NavigationLink(destination: DetailView()) {
                   HStack (spacing: 5) {
                       if let imageURL = URL(string: video.thumbnail) {
                           AsyncImage(url: imageURL){ phase in
                               switch phase {
                               case .empty:
                                   ProgressView()
                                       .frame(width: 104, height: 58)
                                       .padding(.trailing, 8)
                               case .success(let image):
                                   image
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 104, height: 58)
                                       .cornerRadius(3)
                                       .padding(.trailing, 8)
                               default:
                                   EmptyView()
                               }
                           }
                       }
                       
                       Text(video.name)
                           .font(.subheadline)
                       
                   }
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(.top, 6)
                   .padding(.bottom, 6)
               }
           }
       }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel()) 
    }
}
