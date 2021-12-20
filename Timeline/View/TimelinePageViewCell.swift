//
//  TimelinePageViewCell.swift
//  Timeline
//
//  Created by user on 2021/11/27.
//

import Foundation
import UIKit

class TimelinePageViewCell: UICollectionViewCell, ReusableCollectionViewCell {
    static var reuseIdentifier = "TimelinePageViewCell"

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(
            TimelineMemoLogViewCell.self,
            forCellWithReuseIdentifier: TimelineMemoLogViewCell.reuseIdentifier
        )
        collectionView.register(
            TimelineImageLogViewCell.self,
            forCellWithReuseIdentifier: TimelineImageLogViewCell.reuseIdentifier
        )
        collectionView.register(
            TimelineDateInfoViewCell.self,
            forCellWithReuseIdentifier: TimelineDateInfoViewCell.reuseIdentifier
        )
        collectionView.register(
            TimelineAddInfoViewCell.self,
            forCellWithReuseIdentifier: TimelineAddInfoViewCell.reuseIdentifier
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private var viewModel: TimelinePageViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("This is not allowed!")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        collectionView.reloadData()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    private func configureLayout() {
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    public func configure(viewModel: TimelinePageViewModel) {
        self.viewModel = viewModel
    }
}

extension TimelinePageViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel?.logs.count ?? 0
        case 1:
            return 1
        default:
            assertionFailure("wrong section")
            return 0
        }

    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let currentLogViewModel = viewModel?.logs[safe: indexPath.row] else { return UICollectionViewCell() }

            var cell: TimelineLogCellProtocol?
            switch currentLogViewModel {
            case is TimelineMemoLogViewModel:
                cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TimelineMemoLogViewCell.reuseIdentifier,
                    for: indexPath
                ) as? TimelineMemoLogViewCell

            case is TimelineImageLogViewModel:
                cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TimelineImageLogViewCell.reuseIdentifier,
                    for: indexPath
                ) as? TimelineImageLogViewCell

            default:
                cell = nil
            }

            guard let timelineLogCell = cell else { return UICollectionViewCell() }

            timelineLogCell.configure(viewModel: currentLogViewModel)
            return timelineLogCell

        }
        else {
            if let dateInfoViewModel = viewModel?.nextPageDate {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TimelineDateInfoViewCell.reuseIdentifier,
                    for: indexPath
                ) as? TimelineDateInfoViewCell else { return UICollectionViewCell() }

                cell.configure(viewModel: dateInfoViewModel)
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TimelineAddInfoViewCell.reuseIdentifier,
                    for: indexPath
                ) as? TimelineAddInfoViewCell else { return UICollectionViewCell() }

                cell.configure()
                return cell

            }
        }
    }

}

extension TimelinePageViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        var cellHeight: CGFloat = 0
        if indexPath.section == 0 {
            cellHeight = viewModel?.logs[safe: indexPath.row]?.type.cellHeight ?? 0
        }
        else {
            let totalLogHeight = viewModel?.totalLogHeight ?? 0
            cellHeight = collectionView.frame.height - totalLogHeight
        }
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
}
