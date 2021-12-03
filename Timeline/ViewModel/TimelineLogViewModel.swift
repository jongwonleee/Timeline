//
//  TimelineLogViewModel.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

class TimelineLogViewModel {
    let date: Date
    let memo: String
    let type: TimelineLogType

    init(model: TimelineLogModel) {
        date = model.date
        memo = model.memo
        type = model.type
    }
}

class TimelineMemoLogViewModel: TimelineLogViewModel {
    var title: String?
    override init(model: TimelineLogModel) {
        title = model.title
        super.init(model: model)

        guard model.type == .memo else {
            assertionFailure("wrong model type")
            return
        }
    }
}

class TimelineImageLogViewModel: TimelineLogViewModel {
    var image: UIImage?
    var title: String = ""

    override init(model: TimelineLogModel) {
        super.init(model: model)

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
