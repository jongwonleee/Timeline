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
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never

        collectionView.register(
            TimelinePageViewCell.self,
            forCellWithReuseIdentifier: TimelinePageViewCell.reuseIdentifier
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let timelineOverlayView: TimelineOverlayView = {
        let view = TimelineOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var viewModel: TimelineViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        addSubviews()
        configureConstraints()

        timelineOverlayView.delegate = self
        viewModel = TimelineViewModel(models: addMockModels, frameHeight: view.frame.height)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private var addMockModels: [TimelineLogModel]{
        var date = Date()
        var models: [TimelineLogModel] = []
        for _ in 0..<100 {
            let interval = -86400 * Int.random(in: 3..<15)
            date = date.addingTimeInterval(Double(interval))
            var model = TimelineLogModel()

            model.date = date
            model.memo = "hihi!!" + interval.formatted()
            if models.capacity % 3 == 0 {
                model.type = .memo
            } else {
                model.type = .image
                model.title = "this is title"
                model.image = UIImage()
            }

            models.append(model)
        }
        return models
    }


    private func addSubviews() {
        view.addSubview(lineView)
        view.addSubview(collectionView)
//        view.addSubview(timelineOverlayView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalToConstant: Layout.lineWidth),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.topAnchor.constraint(equalTo: view.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            timelineOverlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            timelineOverlayView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            timelineOverlayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            timelineOverlayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.pages.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        guard let pageViewModel = viewModel?.pages[safe: indexPath.row],
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TimelinePageViewCell.reuseIdentifier,
                for: indexPath
              ) as? TimelinePageViewCell else {  return UICollectionViewCell() }

        cell.configure(viewModel: pageViewModel)

        return cell
    }

//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//    }
//
//    func scrollViewWillEndDragging(
//        _ scrollView: UIScrollView, withVelocity velocity: CGPoint,
//        targetContentOffset: UnsafeMutablePointer<CGPoint>
//    ) {
//
//    }
}

extension TimelineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionView.frame.size
    }
}
extension TimelineViewController: TimelineOverlayViewDelegate {
    func timelineOverlayView(_ :UIView, didTapAddButton: UIButton) {

    }
    func timelineOverlayView(_ :UIView, didTapSettingButton: UIButton) {
        
    }
}

