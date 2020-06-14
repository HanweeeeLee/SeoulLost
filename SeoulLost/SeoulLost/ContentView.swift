//
//  ContentView.swift
//  SeoulLost
//
//  Created by hanwe on 2020/06/07.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 1 {
        didSet {
            print("selection:\(self.selection)")
        }
    }
    public var lostItemTabView:LostItemTabView = LostItemTabView(viewModel: LostItemTabViewModel())
    
    var body: some View {
        TabView(selection:$selection) {
            self.lostItemTabView
                .viewDidLoad()//이런식으로 라이프사이클?을 만들어버리면 바인딩이 안됨.. 타이밍 문제인듯
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Screen One")
            }.tag(1)
            
            SearchTabView()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Screen Two")
            }.tag(2)
//            Text("Third Content View")
//                .tabItem {
//                    Image(systemName: "3.circle")
//                    Text("Screen Three")
//            }.tag(3)
        }
        .font(.largeTitle)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
