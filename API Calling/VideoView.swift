//
//  VideoView.swift
//  API Calling
//
//  Created by Colin Joyce on 3/2/23.
//

import SwiftUI
import WebKit

struct VideoView: View {
        var link: String
        var body: some View {
            WebView(url: URL(string: link)!)
        }
    }

    struct WebView: UIViewRepresentable {
        var url: URL
        func makeUIView(context: Context) -> WKWebView  {
            let webView = WKWebView()
            let request = URLRequest(url: url)
            webView.load(request)
            return webView
        }
        func updateUIView(_ uiView: WKWebView, context: Context) {
        }
    }
    extension String {
        var embed: String {
            var strings = self.components(separatedBy: "/")
            let videoId = strings.last ?? ""
            strings.removeLast()
            let embedURL = strings.joined(separator: "/") + "embed/\(videoId)"
            return embedURL
        }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(link: "")
    }
}
