//
//  TimelineLogViewModel.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

enum LogLocation {
    case left
    case right
}

class TimelineLogViewModel {
    let date: Date
    let memo: String
    let type: TimelineLogType
    let location: LogLocation
    init(model: TimelineLogModel, location: LogLocation) {
        date = model.date
        memo = model.memo
        type = model.type
        self.location = location
    }
}

class TimelineMemoLogViewModel: TimelineLogViewModel {
    var title: String?
    override init(model: TimelineLogModel, location: LogLocation) {
        title = model.title
        super.init(model: model, location: location)

        guard model.type == .memo else {
            assertionFailure("wrong model type")
            return
        }
    }
}

class TimelineImageLogViewModel: TimelineLogViewModel {
    var image: UIImage?
    var title: String = ""

    override init(model: TimelineLogModel, location: LogLocation) {
        super.init(model: model, location: location)

        guard model.type == .image,
              let modelImage = model.image,
              let modelTitle = model.title
        else {
            assertionFailure("wrong model type")
            return
        }

        image = modelImage
        title = modelTitle
    }
}
