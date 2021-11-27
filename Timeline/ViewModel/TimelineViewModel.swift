//
//  TimelineViewModel.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

class TimelineViewModel {
    var pages: [TimelinePageViewModel] = []

    public init(models: [TimelineLogModel], frameHeight: CGFloat) {

        var pageModels: [TimelineLogModel] = []
        var heightSum: CGFloat = 0

        models.sorted(by: { $0.date > $1.date }).forEach { model in
            if heightSum + model.type.cellHeight > frameHeight - TimelineDateInfoViewCell.Layout.height {
                pages.append(TimelinePageViewModel(models: pageModels, nextModel: model))
                pageModels = []
                heightSum = 0
            }

            pageModels.append(model)
            heightSum = heightSum + model.type.cellHeight
        }

        pages.append(TimelinePageViewModel(models: pageModels, nextModel: nil))
        print(pages)
    }
}
