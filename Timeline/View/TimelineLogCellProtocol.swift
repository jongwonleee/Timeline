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

class TimelineImageLogViewCell: TimelineDefaultLogViewCell, TimelineLogCellProtocol {
    struct Layout {
        static let height: CGFloat = 100
        static let logViewMargin: CGFloat = 10
        static let imageViewSize: CGFloat = 60
        static let labelMargin: CGFloat = 5
    }

    static var reuseIdentifier = "TimelineImageLogViewCell"

    private let titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.lineBreakMode = .byClipping
        return label
    }()


    private let memoLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail

        return label
    }()


    private let imageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    private let logView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    var constraintsLayout: [NSLayoutConstraint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(logView)
        logView.addSubview(memoLabel)
        logView.addSubview(titleLabel)
        logView.addSubview(imageView)

        NSLayoutConstraint.activate([
            logView.topAnchor.constraint(equalTo: contentView.topAnchor),
            logView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.centerYAnchor.constraint(equalTo: logView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Layout.imageViewSize),
            imageView.widthAnchor.constraint(equalToConstant: Layout.imageViewSize),
            titleLabel.topAnchor.constraint(equalTo: logView.topAnchor),
            memoLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            memoLabel.bottomAnchor.constraint(equalTo: logView.bottomAnchor),
            memoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            memoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("wrong initalizer")
    }

    func configure(viewModel: TimelineLogViewModel) {
        guard let viewModel = viewModel as? TimelineImageLogViewModel else { return }
        memoLabel.text = viewModel.memo
        titleLabel.text = viewModel.title
        imageView.image = viewModel.image

        NSLayoutConstraint.deactivate(constraintsLayout)
        switch viewModel.location {
        case .left:
            memoLabel.textAlignment = .left
            constraintsLayout = [
                logView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.logViewMargin),
                logView.trailingAnchor.constraint(equalTo: centerDotView.leadingAnchor, constant: -Layout.logViewMargin),
                imageView.leadingAnchor.constraint(equalTo: logView.leadingAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Layout.labelMargin),
                titleLabel.trailingAnchor.constraint(equalTo: logView.trailingAnchor),
            ]
        case .right:
            memoLabel.textAlignment = .right
            constraintsLayout = [
                logView.leadingAnchor.constraint(equalTo: centerDotView.trailingAnchor, constant: Layout.logViewMargin),
                logView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.logViewMargin),
                imageView.trailingAnchor.constraint(equalTo: logView.trailingAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: logView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Layout.labelMargin),
            ]
        }
        NSLayoutConstraint.activate(constraintsLayout)
        setNeedsLayout()
    }
}

class TimelineDateInfoViewCell: UICollectionViewCell, ReusableCollectionViewCell {
    struct Layout {
        static let height = CGFloat(50)
    }

    static var reuseIdentifier = "TimelineDateInfoViewCell"

    private let dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("wrong initalizer")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
    }

    func configure(viewModel: TimelineDateInfoViewModel) {
        dateLabel.text = viewModel.dateInfo
    }
}

class TimelineAddInfoViewCell: UICollectionViewCell, ReusableCollectionViewCell {

    static var reuseIdentifier = "TimelineAddInfoViewCell"

    func configure() {
        backgroundColor = .gray
    }
}
