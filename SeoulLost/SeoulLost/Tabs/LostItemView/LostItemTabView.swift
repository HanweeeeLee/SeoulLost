//
//  LostItemTabView.swift
//  SeoulLost
//
//  Created by hanwe lee on 2020/06/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct LostItemTabView: View {
    @ObservedObject var viewModel: LostItemTabViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                content
            }
        }
        .onAppear {
            print("LostItemTabView onAppear")
        }
        .onDisappear() {
            print("LostItemTabView onDisappear")
        }
    }
    
    private var content: some View {
        return LoadingView(isShowing: self.$viewModel.isShowLoading) {
            Text("test")
        }
    }
    
    public func viewDidLoad() -> LostItemTabView  {
        return self
    }
    
}
