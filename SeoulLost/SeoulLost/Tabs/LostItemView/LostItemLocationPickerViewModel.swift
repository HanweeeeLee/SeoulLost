//
//  LostItemLocationPickerViewModel.swift
//  SeoulLost
//
//  Created by hanwe on 2020/07/05.
//  Copyright © 2020 hanwe. All rights reserved.
//

import SwiftUI
import Combine

class LostItemLocationPickerViewModel: ObservableObject {
    @Published var place:Array = Array<String>()
}
