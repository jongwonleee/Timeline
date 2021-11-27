//
//  TimelineLogMemoCell.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

protocol TimelineLogCellProtocol {
    var identifier: String { get }
}

class TimelineMemoLogViewCell: UICollectionViewCell, TimelineLogCellProtocol {
    struct Layout {
        static let height = CGFloat(70)
    }

    var identifier = "TimelineMemoLogViewCell"
}

class TimelineImageLogViewCell: UICollectionViewCell, TimelineLogCellProtocol {
    struct Layout {
        static let height = CGFloat(100)
    }

    var identifier = "TimelineImageLogViewCell"
}

class TimelineDateInfoViewCell: UICollectionViewCell {
    struct Layout {
        static let height = CGFloat(50)
    }

    var identifier = "TimelineDateInfoViewCell"
}
