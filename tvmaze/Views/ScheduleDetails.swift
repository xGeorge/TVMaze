//
//  ScheduleDetails.swift
//  tvmaze
//
//  Created by Jorge Armando Torres Perez on 17/01/21.
//

import UIKit

class ScheduleDetails: UIViewController {

    let showName = UILabel()
    let channelName = UILabel()
    let season = UILabel()
    let number = UILabel()
    let premiered = UILabel()
    let language = UILabel()
    let daySegment: UISegmentedControl
    let labelContainer: UIStackView

    init() {
        let items = Day.allCases.map { $0.rawValue }
        daySegment = UISegmentedControl(items: items)
        daySegment.isUserInteractionEnabled = false
        daySegment.selectedSegmentTintColor = .blue
        labelContainer = UIStackView(arrangedSubviews: [showName, channelName, season, number, premiered, daySegment])
        labelContainer.axis = .vertical
        labelContainer.spacing = 16
        labelContainer.distribution = .equalCentering
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
//        print("deinit ScheduleDetails")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        view.addSubview(labelContainer)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labelContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            labelContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])

    }
    
    func configure(for schedule: Schedule) {
        showName.text = "Show name: " + schedule.displayName
        channelName.text = "Channel: " + schedule.displayChannel
        season.text = "Curent season: \(schedule.season ?? 0)"
        number.text = "Episode: \(schedule.number ?? 0)"
        premiered.text = "Show premier: " + (schedule.show?.premiered ?? "NA")
        language.text = "Show language: " + (schedule.show?.language ?? "NA")
        daySegment.selectedSegmentIndex = Day.allCases.map { Day(rawValue: $0.rawValue) }.firstIndex(of: schedule.show?.schedule?.days?.first) ?? -1
    }
}
