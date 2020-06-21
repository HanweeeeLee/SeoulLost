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
    //MARK: Enum
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
    
    //MARK: published propertys
    @Published var state = State.loading
    @Published var isShowLoading = false
    @Published var data:Array = Array<LostArticleModel>()
    @Published var place:LostPlaceType = .bus
    @Published var lostArticleType:LostArticleType = .wallet
    
    @Published var placeTxt:String = ""
    @Published var lostArticleTypeTxt:String = ""
    
    //MARK: propertys
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
    private var currentListIndex:Int = 0
    
    private var loadingStateCheck: AnyPublisher<Bool, Never> {
        $state
            .map { input in
                return input == .loading
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: lifecycle
    init() {
        request()
        initTextProperty()
    }
    
    //MARK: func
    func send(event: Event) {
        input.send(event)
    }
    
    private func initTextProperty() {
        switch self.place {
        case .bus:
            self.placeTxt = "버스"
            break
        case .corporateTaxi:
            self.placeTxt = "법인택시"
            break
        case .korail:
            self.placeTxt = "코레일"
            break
        case .privateTaxi:
            self.placeTxt = "개인택시"
            break
        case .subway1_4:
            self.placeTxt = "지하철(1~4호선)"
            break
        case .subway5_8:
            self.placeTxt = "지하철(5~8호선)"
            break
        case .subway9:
            self.placeTxt = "지하철(9호선)"
            break
        case .villageBus:
            self.placeTxt = "마을버스"
            break
        }
        
        switch self.lostArticleType {
        case .backpack:
            self.lostArticleTypeTxt = LostArticleType.backpack.rawValue
            break
        case .bag:
            self.lostArticleTypeTxt = LostArticleType.bag.rawValue
            break
        case .book:
            self.lostArticleTypeTxt = LostArticleType.book.rawValue
            break
        case .briefcase:
            self.lostArticleTypeTxt = LostArticleType.briefcase.rawValue
            break
        case .cellPhone:
            self.lostArticleTypeTxt = LostArticleType.cellPhone.rawValue
            break
        case .clothing:
            self.lostArticleTypeTxt = LostArticleType.clothing.rawValue
            break
        case .etc:
            self.lostArticleTypeTxt = LostArticleType.etc.rawValue
            break
        case .file:
            self.lostArticleTypeTxt = LostArticleType.file.rawValue
            break
        case .wallet:
            self.lostArticleTypeTxt = LostArticleType.wallet.rawValue
            break
        case .shoppingBag:
            self.lostArticleTypeTxt = LostArticleType.shoppingBag.rawValue
            break
        }
    }
    
    
    
    //MARK: rest api func
    func request() {
        self.isShowLoading = true
        let apiAddr = APIDefine.getLostArticleAPIAddress(startIndex: self.currentListIndex, endIndex: self.currentListIndex + 10, type: self.lostArticleType, place: self.place, searchTxt: nil)
        //        print("apiAddr:\(apiAddr)")
        DataApiManager.requestGETURL(apiAddr, headers: nil, success: { (result) in
//            print("result:\(result)")
            self.currentListIndex += 10
            usleep(1 * 1000 * 1000) // 로딩을 보여주기위한 타이머 사실 쓸모없는 코드
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
