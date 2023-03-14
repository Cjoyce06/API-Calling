//
//  ContentView.swift
//  API Calling
//
//  Created by Colin Joyce on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var trendingVideos = [TrendingVideo]()
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            List(trendingVideos, id: \.self) { video in
                NavigationLink(destination: VideoView(link: "https://www.youtube.com/embed/\(video.videoId)")) {
                    Text(video.title)
                }
            }
            .navigationTitle("API Categories")
        }
        .task {
            await getTrendingVideos()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the API categories"),
                  dismissButton: .default(Text("OK")))
        }
    }
    func getTrendingVideos() async {
        let headers = [
            "X-RapidAPI-Key": "e159a7b184msh2331a5c0a1ef05ep184e45jsn71fac6388a37",
            "X-RapidAPI-Host": "youtube-trending.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://youtube-trending.p.rapidapi.com/trending?country=US&type=gaming")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        if let (data, response) = try? await URLSession.shared.data(for: request as URLRequest) {
            let dataStr  = String(data: data, encoding: String.Encoding.utf8) as String?
           // print(dataStr)
                if let decodedResponse = try? JSONDecoder().decode([TrendingVideo].self, from: data) {
                    trendingVideos = decodedResponse
                    //print(decodedResponse)
                    return
                }
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



