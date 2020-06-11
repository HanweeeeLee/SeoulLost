//
//  SearchTabView.swift
//  SeoulLost
//
//  Created by hanwe lee on 2020/06/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct SearchTabView: View {
    
    @State public var isShowLoaidng:Bool = true {
        didSet {
            print("selection:\(self.isShowLoaidng)")
        }
    }
    
    var body: some View {
        LoadingView(isShowing: .constant(self.isShowLoaidng)) {
            NavigationView {
                VStack {
                    Text("hello~")
                    List(["1", "2", "3", "4", "5"], id: \.self) { row in
                        Text(row)
                    }.navigationBarTitle(Text("A List"), displayMode: .large)
                }
                
            }
        }
        .onAppear {
            print("SearchTabView onAppear")
        }
        .onDisappear() {
            print("SearchTabView onDisappear")
        }
        
    }
    
}
