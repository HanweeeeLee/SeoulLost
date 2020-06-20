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
//    @State private var isShowLoaidng:Bool = true
//    @Binding var test:Bool
    var body: some View {
        NavigationView {
            VStack {
                content
            }
        }
        .onAppear {
            print("LostItemTabView onAppear")
//            self.isShowLoaidng = viewModel.$state.map({
//                switch viewModel.state {
//                case .load
//                }
//            })
//            self.isShowLoaidng = $viewModel.isShowLoading
            self.$viewModel.isShowLoading
        }
        .onDisappear() {
            print("LostItemTabView onDisappear")
        }
    }
    
    private var content: some View {
//        switch self.viewModel.state {
//        case .idle:
//            print("idle")
//            return LoadingView(isShowing: self.$viewModel.isShowLoading) {
//                Text("test")
//            }
////            return Text("hi")
//        case .loading:
//            print("loading")
//            return LoadingView(isShowing: self.$viewModel.isShowLoading) {
//                Text("test")
//            }
//
//        case .error:
//            print("error")
//            return LoadingView(isShowing: self.$viewModel.isShowLoading) {
//                Text("test")
//            }
//        case .loaded:
//            print("loaded")
//            return LoadingView(isShowing: self.$viewModel.isShowLoading) {
//                Text("test")
//            }
//        }
        return LoadingView(isShowing: self.$viewModel.isShowLoading) {
            Text("test")
        }
    }
    
    public func viewDidLoad() -> LostItemTabView  {
        return self
    }
    
}
