//
//  ViewController.swift
//  Timeline
//
//  Created by user on 2021/11/26.
//

import UIKit

class TimelineViewController: UIViewController {
    struct Layout {
        static let lineWidth = CGFloat(5)
    }

    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor.clear
//
//        collectionView.register(
//            StoryViewerViewCell.self,
//            forCellWithReuseIdentifier: StoryViewerViewCell.reuseIdentifier
//        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    let timelineOverlayView: TimelineOverlayView = {
        let view = TimelineOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        addSubviews()
        configureConstraints()

        timelineOverlayView.delegate = self

    }

    private func addSubviews() {
        view.addSubview(lineView)
        view.addSubview(timelineOverlayView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalToConstant: Layout.lineWidth),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.topAnchor.constraint(equalTo: view.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            timelineOverlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timelineOverlayView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            timelineOverlayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timelineOverlayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}

extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        UICollectionViewCell()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {

    }

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {

    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView, withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {

    }
}

extension TimelineViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        view.frame.size
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
extension TimelineViewController: TimelineOverlayViewDelegate {
    func timelineOverlayView(_ :UIView, didTapAddButton: UIButton) {

    }
    func timelineOverlayView(_ :UIView, didTapSettingButton: UIButton) {
        
    }
}

