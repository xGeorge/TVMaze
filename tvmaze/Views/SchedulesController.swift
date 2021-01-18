//
//  ViewController.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 16/01/21.
//

import UIKit
import Kingfisher

class SchedulesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    var collectionView: UICollectionView?
    var dataModel: Schedules = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Now Airing"

        setupCollectionView()

        APITvMaze().getSchedules(completion: { [weak self] schedules, error in
            guard let self = self else { return }
            if let error = error {
                //TODO define a proper message
                let alert = UIAlertController(title: "DataTask error", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
            guard let schedules = schedules else { return }
            self.dataModel = schedules
            self.collectionView?.reloadData()
        })
        
//        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.collectionView?.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }

    fileprivate func setupCollectionView() {
        let flowLayout = AutoInvalidatingLayout()
        
        flowLayout.itemSize = CGSize(
            width: ShowCell.cellWidth,
            height: ShowCell.cellHeight)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = ShowCell.space
        flowLayout.minimumLineSpacing = ShowCell.space
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        guard let collectionView = collectionView else { return }
        collectionView.register(ShowCell.self, forCellWithReuseIdentifier: ShowCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

//    @objc func applicationDidBecomeActive(notification: NSNotification) {
//        collectionView?.collectionViewLayout.invalidateLayout()
//    }

    //MARK: CollectionViewCycle
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCell.cellIdentifier, for: indexPath as IndexPath) as? ShowCell else { return UICollectionViewCell() }
        cell.configure(for: dataModel[indexPath.row])
        return cell
    }

    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(
            width: ShowCell.cellWidth,
            height: ShowCell.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: ShowCell.space,
            left: ShowCell.space,
            bottom: ShowCell.space,
            right: ShowCell.space)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let schedule = dataModel[indexPath.row]
        let detailView = ScheduleDetails()
        detailView.configure(for: schedule)
        navigationController?.pushViewController(detailView, animated: false)
        //self.delegate?.didChoosedProduct(item: selectedItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let schedule = dataModel[indexPath.row]
        guard let url = schedule.show?.image?.medium?.urlRepresentation() else {
            return
        }
        let processor = DownsamplingImageProcessor(size: CGSize(
                                                    width: ShowCell.cellWidth,
                                                    height: ShowCell.cellHeight))
                     |> RoundCornerImageProcessor(cornerRadius: 5)
        (cell as? ShowCell)?.backgroundImage.kf.setImage(with: url, options: [.processor(processor)])
    }
}

protocol ScheduleCellDelegate: class {
    func didChoosedSchedule(item: Schedule)
}

