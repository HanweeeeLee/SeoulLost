//
//  LostItemTabView.swift
//  SeoulLost
//
//  Created by hanwe lee on 2020/06/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI

struct LostItemTabView: View {
    
    @State private var isShowLoaidng:Bool = true {
        didSet {
            print("?")
        }
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $isShowLoaidng) {
                Text("hello")
            }
//            LoadingView(isShowing: $isShowLoaidng, content: {
//
//            })
        }
        .onAppear {
            print("LostItemTabView onAppear")
            
        }
        .onDisappear() {
            print("LostItemTabView onDisappear")
        }
        
        
    }
    
    public func viewDidLoad() -> LostItemTabView  {
        let apiAddr = APIDefine.getLostArticleAPIAddress(startIndex: 1, endIndex: 5, type: .wallet, place: .bus, searchTxt: "지갑")
//        print("apiAddr:\(apiAddr)")
        
        DataApiManager.requestGETURL(apiAddr, headers: nil, success: { (result) in
//            print("result:\(result)")
            usleep(2 * 1000 * 1000)
            self.isShowLoaidng = false
        }) { (err) in
            print("error :\(err)")
        }
        return self
    }

}
