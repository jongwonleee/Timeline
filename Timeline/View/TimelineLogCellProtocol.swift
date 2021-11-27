//
//  TimelineLogMemoCell.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

protocol TimelineLogCellProtocol {
    static var reuseIdentifier: String { get }
}

extension TimelineLogCellProtocol {
    public static var reuseIdentifier: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
}

class TimelineMemoLogViewCell: UICollectionViewCell, TimelineLogCellProtocol {
    struct Layout {
        static let height = CGFloat(70)
    }

    static var reuseIdentifier = "TimelineMemoLogViewCell"
}

class TimelineImageLogViewCell: UICollectionViewCell, TimelineLogCellProtocol {
    struct Layout {
        static let height = CGFloat(100)
    }

    static var reuseIdentifier = "TimelineImageLogViewCell"
}

class TimelineDateInfoViewCell: UICollectionViewCell {
    struct Layout {
        static let height = CGFloat(50)
    }

    static var reuseIdentifier = "TimelineDateInfoViewCell"
}
