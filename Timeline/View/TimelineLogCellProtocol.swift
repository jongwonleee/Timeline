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

class TimelineMemoLogViewCell: TimelineDefaultLogViewCell, TimelineLogCellProtocol {
    struct Layout {
        static let height = CGFloat(70)
        static let labelMargin: CGFloat = 10
    }

    static var reuseIdentifier = "TimelineMemoLogViewCell"

    private let memoLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 4
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    var constraintsLayout: [NSLayoutConstraint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(memoLabel)

        NSLayoutConstraint.activate([
            memoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("wrong initalizer")
    }

    func configure(viewModel: TimelineLogViewModel) {
        guard let viewModel = viewModel as? TimelineMemoLogViewModel else { return }
        memoLabel.text = viewModel.memo

        NSLayoutConstraint.deactivate(constraintsLayout)
        switch viewModel.location {
        case .left:
            memoLabel.textAlignment = .left
            constraintsLayout = [
                memoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.labelMargin),
                memoLabel.trailingAnchor.constraint(equalTo: centerDotView.leadingAnchor, constant: -Layout.labelMargin),
            ]
        case .right:
            memoLabel.textAlignment = .right
            constraintsLayout = [
                memoLabel.leadingAnchor.constraint(equalTo: centerDotView.trailingAnchor, constant: Layout.labelMargin),
                memoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.labelMargin),
            ]
        }
        NSLayoutConstraint.activate(constraintsLayout)
        setNeedsLayout()
    }
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
