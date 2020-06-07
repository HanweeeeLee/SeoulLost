//
//  ContentView.swift
//  SeoulLost
//
//  Created by hanwe on 2020/06/07.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("hello")
        }
        .onAppear {
            print("onAppear")
//            let apiAddr = APIDefine.getLostArticleAPIAddress(startIndex: 1, endIndex: 5, type: .wallet, place: .bus, searchTxt: "지갑")
//            print("apiAddr:\(apiAddr)")
//
//            DataApiManager.requestGETURL(apiAddr, headers: nil, success: { (result) in
//                print("result:\(result)")
//            }) { (err) in
//                print("error :\(err)")
//            }
        }
        .onDisappear() {
            print("onDisappear")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
