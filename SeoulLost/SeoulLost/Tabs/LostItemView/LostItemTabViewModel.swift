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
        case loaded
        case error
    }
    
    enum Event {
        case onAppear
        case onSelectMovie(Int)
        case onMoviesLoaded([LostArticleModel])
        case onFailedToLoadMovies(Error)
    }
    
    @Published var state = State.loading
    @Published var isShowLoading = true
    @Published var data:Array = Array<LostArticleModel>()
    
    private var bag = Set<AnyCancellable>()
    
    private let input = PassthroughSubject<Event, Never>()
    
    init() {
        print("init!")
        loadingStateCheck
//        .receive(on: RunLoop.main)
        .map { valid in
          valid ? true : false
        }
        .assign(to: \.isShowLoading, on: self)
//        .store(in: &cancellableSet)
        
        request()
    }
    
    func send(event: Event) {
        input.send(event)
    }
    
    private var loadingStateCheck: AnyPublisher<Bool, Never> {
        $state
            .map { input in
                return input == .loading
        }
        .eraseToAnyPublisher()
    }
    
    func request() {
        let apiAddr = APIDefine.getLostArticleAPIAddress(startIndex: 1, endIndex: 5, type: .wallet, place: .bus, searchTxt: nil)
        //        print("apiAddr:\(apiAddr)")
        DataApiManager.requestGETURL(apiAddr, headers: nil, success: { (result) in
//            print("result:\(result)")
            usleep(2 * 1000 * 1000)
            print("받았다")
            self.data.removeAll()
            for i in 0..<result["SearchLostArticleService"]["row"].count {
                let item = result["SearchLostArticleService"]["row"][i]
                let model = LostArticleModel(position: item["GET_POSITION"].stringValue,
                                             name: item["GET_NAME"].stringValue,
                                             getDate: item["GET_DATE"].stringValue,
                                             place: item["TAKE_PLACE"].stringValue,
                                             lostID: item["ID"].stringValue)
                self.data.append(model)
            }
            self.state = .idle
            self.isShowLoading = false
//            self.send(event: .onAppear)
        }) { (err) in
            print("error :\(err)")
        }
    }
    
}
