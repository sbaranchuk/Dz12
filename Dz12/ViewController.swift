//
//  ViewController.swift
//  Dz12
//
//  Created by Admin on 29/12/2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Properties

    private var isWorkTime = true
    private var isStarted = false

    private var timer = Timer()
    private var time = 25
    private var accurateTimerCount = 1000

    // MARK: - UI Elements

    private lazy var clockFaceLable: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        return label
    }()

    private lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = UIColor.systemGray
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 60), forImageIn: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()

    private lazy var labelButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.addArrangedSubview(clockFaceLable)
        stack.addArrangedSubview(startStopButton)
        return stack
    }()

    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 10

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setupTime()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .black
    }

    private func setupHierarchy() {
        view.addSubview(labelButtonStack)
        setUpCircularProgressBarView()
    }

    private func setupLayout() {
        labelButtonStack.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }

        circularProgressBarView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
    }

    // MARK: - Actions

    func setUpCircularProgressBarView() {
        // set view
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        // create CircularPath
        circularProgressBarView.createCircularPath()
        // call the animation with circularViewDuration
        circularProgressBarView.progressAnimation(duration: circularViewDuration)
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
    }

    @objc func startAndStopTimer() {
    }

    func formatTimer() -> String {
        let time = Double(time)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter.string(from: time) ?? "00:00"
    }

    func setupTime() {
        clockFaceLable.text = formatTimer()
    }

    @objc func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if accurateTimerCount > 0 {
            accurateTimerCount -= 1
            return
        }
        accurateTimerCount = 1000

        if time < 1 {
            // дописать метод смены интерфейса
        }

        time -= 1
        setupTime()
    }

}
