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
    public init(models: [TimelineLogModel], nextModel: TimelineLogModel?, totalHeight: CGFloat) {
        totalLogHeight = totalHeight

        models.forEach { model in
            switch model.type {
            case .memo:
                logs.append(TimelineMemoLogViewModel(model: model))
            case .image:
                logs.append(TimelineImageLogViewModel(model: model))
            }
        }

        if let nextModel = nextModel,
           let previousModel = models.last {
            nextPageDate = TimelineDateInfoViewModel(previousModel: previousModel, nextModel: nextModel)
        }
    }
}
