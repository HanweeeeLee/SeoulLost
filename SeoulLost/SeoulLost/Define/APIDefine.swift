//
//  APIDefine.swift
//  SeoulLost
//
//  Created by hanwe on 2020/06/07.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit

enum LostArticleType:String {
    case wallet = "지갑"
    case shoppingBag = "쇼핑백"
    case briefcase = "서류봉투"
    case bag = "가방"
    case backpack = "베낭"
    case cellPhone = "핸드폰"
    case clothing = "옷"
    case book = "책"
    case file = "파일"
    case etc = "기타"
}

enum LostPlaceType:String {
    case bus = "b1" //버스
    case villageBus = "b2" //마을버스
    case corporateTaxi = "t1" //법인택시
    case privateTaxi = "t2" //개인택시
    case subway1_4 = "s1" //지하철(1~4호선)
    case subway5_8 = "s2" //지하철(5~8호선)
    case subway9 = "s4" //지하철(9호선)
    case korail = "s3" //코레일
}

class APIDefine: NSObject {
    static let SEOUL_API_SERVER_ADDR                   = "http://openAPI.seoul.go.kr:8088"
    static let SEOUL_API_KEY                           = "63595468556c686133396249724949" // 제발 이상한짓 하지 말아주세요ㅠㅠ
    
    
    static let GET_LOST_ARTICLE_ORIGIN_API                    = String(format: "%@/%@/json/SearchLostArticleService",SEOUL_API_SERVER_ADDR,SEOUL_API_KEY)
    static let GET_LOST_ARTICLE_IMAGE_ORIGIN_API              = String(format: "%@/%@/json/SearchLostArticleImageService",SEOUL_API_SERVER_ADDR,SEOUL_API_KEY)
    
    static func getLostArticleAPIAddress(startIndex:Int,endIndex:Int,type:LostArticleType,place:LostPlaceType,searchTxt:String?) -> String {
        var apiAddr:String = ""
        apiAddr = GET_LOST_ARTICLE_ORIGIN_API + "/" + String(startIndex) + "/" + String(endIndex) + "/" + type.rawValue + "/" + place.rawValue
        
        if searchTxt != nil {
            apiAddr = apiAddr + "/" + searchTxt!
        }
        let encodedString = apiAddr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return encodedString
    }
    
    static func getLostArticleImageAPIAddress(startIndex:Int,endIndex:Int,lostArticleID:String?) -> String {
        var apiAddr:String = ""
        apiAddr = GET_LOST_ARTICLE_IMAGE_ORIGIN_API + "/" + String(startIndex) + "/" + String(endIndex)
        
        if lostArticleID != nil {
            apiAddr = apiAddr + "/" + lostArticleID!
        }
        let encodedString = apiAddr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return encodedString
    }
    
}
