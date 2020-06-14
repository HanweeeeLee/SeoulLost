//
//  LostItemTabViewModel.swift
//  SeoulLost
//
//  Created by hanwe lee on 2020/06/12.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class LostItemTabViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case loaded([LostArticleModel])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onSelectMovie(Int)
        case onMoviesLoaded([LostArticleModel])
        case onFailedToLoadMovies(Error)
    }
    
    @Published public var state = State.loading
    
    private var bag = Set<AnyCancellable>()
    
    private let input = PassthroughSubject<Event, Never>()
    
    init() {
        print("init!")
        request()
    }
    
    func send(event: Event) {
        input.send(event)
    }
    
    func request() {
        let apiAddr = APIDefine.getLostArticleAPIAddress(startIndex: 1, endIndex: 5, type: .wallet, place: .bus, searchTxt: nil)
        //        print("apiAddr:\(apiAddr)")
        DataApiManager.requestGETURL(apiAddr, headers: nil, success: { (result) in
            //            print("result:\(result)")
            usleep(2 * 1000 * 1000)
            print("받았다")
//            self.state = .idle
            self.send(event: .onAppear)
        }) { (err) in
            print("error :\(err)")
        }
    }
}
