//
//  LostArticleModel.swift
//  SeoulLost
//
//  Created by hanwe on 2020/06/07.
//  Copyright © 2020 hanwe. All rights reserved.
//

import UIKit
import SwiftyJSON

class LostArticleModel: NSObject {
    var position:String
    var name:String
    var getDate:String
    var place:String
    var lostID:String
    
    override init() {
        self.position = ""
        self.name = ""
        self.getDate = ""
        self.place = ""
        self.lostID = ""
    }
    
    convenience init(item:JSON) {
        self.init()
        self.position = item["GET_POSITION"].stringValue
        self.name = item["GET_NAME"].stringValue
        self.getDate = item["GET_DATE"].stringValue
        self.place = item["TAKE_PLACE"].stringValue
        self.lostID = item["ID"].stringValue
    }
}
