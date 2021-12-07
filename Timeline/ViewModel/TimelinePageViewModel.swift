//
//  TimelinePageViewModel.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

class TimelinePageViewModel {
    var logs: [TimelineLogViewModel] = []
    var nextPageDate: TimelineDateInfoViewModel?
    let totalLogHeight: CGFloat

    public init(models: [TimelineLogModel], nextModel: TimelineLogModel?, totalHeight: CGFloat, startIndex: Int) {
        totalLogHeight = totalHeight

        var isLogLocationLeft = (startIndex % 2 == 0)
        models.forEach { model in
            let logLocation: LogLocation = isLogLocationLeft ? .left : .right
            switch model.type {
            case .memo:
                logs.append(TimelineMemoLogViewModel(model: model, location: logLocation))
            case .image:
                logs.append(TimelineImageLogViewModel(model: model, location: logLocation))
            }
            isLogLocationLeft = !isLogLocationLeft
        }

        if let nextModel = nextModel,
           let previousModel = models.last {
            nextPageDate = TimelineDateInfoViewModel(previousModel: previousModel, nextModel: nextModel)
        }
    }
}
