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

    private var amountWorkingTime = 10
    private var amountRestTime = 5

    private var timer = Timer()
    private var time = 10
    private var accurateTimerCount = 1000

    // MARK: - UI Elements

    private lazy var clockFaceLable: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        return label
    }()

    private lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.tintColor = UIColor.systemGray
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 60), forImageIn: .normal)
        button.addTarget(self, action: #selector(startAndStopTimer), for: .touchUpInside)
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
        changeColorGreen()
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
        circularProgressBarView.createCircularPath(tintColor: UIColor.green.cgColor)
        // add this view to the view controller
        view.addSubview(circularProgressBarView)
    }

    @objc func startAndStopTimer() {
        if !isStarted {
            isStarted = true
            startTimer()
            startStopButton.setImage(UIImage(systemName: "pause"), for: .normal)
            circularProgressBarView.progressAnimation(duration: TimeInterval(time))
        } else {
            timer.invalidate()
            if let presentation = circularProgressBarView.progressLayer.presentation() {
                circularProgressBarView.progressLayer.strokeEnd = presentation.strokeEnd
            }
            circularProgressBarView.progressLayer.removeAnimation(forKey: "progressAnim")
            isStarted = false
            startStopButton.setImage(UIImage(systemName: "play"), for: .normal)
        }
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
        setupTime()
        if accurateTimerCount > 0 {
            accurateTimerCount -= 1
            return
        }

        accurateTimerCount = 1000

        if time == 0 {
            changeOperatingMode()
            timer.invalidate()
            circularProgressBarView.progressLayer.removeAnimation(forKey: "progressAnim")
            startStopButton.setImage(UIImage(systemName: "play"), for: .normal)
            isStarted = false
            return
        }

        time -= 1
        setupTime()
    }

    func changeOperatingMode() {
        accurateTimerCount = 1000
        if isWorkTime {
            isWorkTime = false
            time = amountRestTime
            setupTime()
            changeColorWhite()
            circularProgressBarView.progressAnimation(duration: TimeInterval(time))
        } else {
            isWorkTime = true
            time = amountWorkingTime
            setupTime()
            changeColorGreen()
            circularProgressBarView.progressAnimation(duration: TimeInterval(time))
        }
        setupTime()
    }

    func changeColorGreen() {
        clockFaceLable.textColor = UIColor.green
        startStopButton.tintColor = UIColor.green
        circularProgressBarView.changeColorGreen()
    }

    func changeColorWhite() {
        clockFaceLable.textColor = UIColor.white
        startStopButton.tintColor = UIColor.white
        circularProgressBarView.changeColorWhite()
    }

}
