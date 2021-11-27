//
//  TimelineLogModel.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

enum TimelineLogType {
    case memo
    case image

    var cellHeight: CGFloat {
        switch self {
        case .memo:
            return TimelineMemoLogViewCell.Layout.height
        case .image:
            return TimelineImageLogViewCell.Layout.height
        }
    }
}

struct TimelineLogModel {
    var date: Date = Date()
    var memo: String = ""
    var title: String?
    var image: UIImage?
    var type: TimelineLogType = .memo
}
