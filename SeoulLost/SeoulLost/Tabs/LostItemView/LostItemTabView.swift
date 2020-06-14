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
    @State private var isShowLoaidng:Bool = true
    
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
        switch self.viewModel.state {
        case .idle:
            print("idle")
            return LoadingView(isShowing: $isShowLoaidng) {
                Text("test")
            }
        case .loading:
            print("loading")
            return LoadingView(isShowing: $isShowLoaidng) {
                Text("test")
            }
            
        case .error(let error):
            print("error")
            return LoadingView(isShowing: $isShowLoaidng) {
                Text("test")
            }
        case .loaded(let movies):
            print("loaded")
            return LoadingView(isShowing: $isShowLoaidng) {
                Text("test")
            }
        }
    }
    
    public func viewDidLoad() -> LostItemTabView  {
        return self
    }
    
}
