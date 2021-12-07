//
//  TimelineLogMemoCell.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

protocol TimelineLogCellProtocol: ReusableCollectionViewCell {
    func configure(viewModel: TimelineLogViewModel)
}

class TimelineDefaultLogViewCell: UICollectionViewCell {
    private struct Layout {
        static let dotViewSize: CGFloat = 10
    }
    var centerDotView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Layout.dotViewSize / 2
        view.layer.masksToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubview(centerDotView)

        NSLayoutConstraint.activate([
            centerDotView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            centerDotView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            centerDotView.heightAnchor.constraint(equalToConstant: Layout.dotViewSize),
            centerDotView.widthAnchor.constraint(equalToConstant: Layout.dotViewSize),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("wrong initalizer")
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
