//
//  ViewController.swift
//  SPV
//
//  Created by WangBin on 2021/4/4.
//

import Cocoa
import SnapKit

class ViewController: NSViewController {

    private let player = Player()
    private var videoView : MTLVideoView!
    private var playTimer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        videoView = MTLVideoView(player: player)
        view.addSubview(videoView)
        videoView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(posView)
        view.addSubview(playSlider)
        view.addSubview(durationView)
        view.addSubview(playBtn)
        posView.snp.makeConstraints { (make) in
            make.right.equalTo(playSlider.snp.left).offset(-4)
            make.centerY.equalTo(playSlider)
        }
        playSlider.snp.makeConstraints { (make) in
            make.left.equalTo(80)
            make.right.equalTo(-80)
            make.height.equalTo(20)
            make.bottom.equalTo(-20)
        }
        durationView.snp.makeConstraints { (make) in
            make.left.equalTo(playSlider.snp.right).offset(4)
            make.centerY.equalTo(playSlider)
        }
        playBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(playSlider)
            make.bottom.equalTo(playSlider.snp.top)
        }
        // Do any additional setup after loading the view.
        
        /*
        player.media = "https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/gear1/prog_index.m3u8"
        player.prepare(from: 1000, complete: {
            [weak player] from, boost in
            boost = true
            guard let info = player?.mediaInfo else {
                return true
            }
            print("MediaInfo: \(info)")
            return true
        })
        player.state = .Playing*/
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(onClick))
        videoView.addGestureRecognizer(gesture)
        
        initPlayer()
    }
    
    override func viewWillDisappear() {
        player.state = .Stopped
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    func play(file: String) {
        view.window?.title = String(file[file.index(after: file.lastIndex(of: "/")!)...])
        player.media = file
        player.state = .Playing
        
        resetUi()
        playTimer?.invalidate()
        playTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.syncUi()
        })
    }
    
    private func initPlayer() {
        player.onStateChanged { (state) in
            print(".....State changed to \(state)....")
            DispatchQueue.main.async {
                self.updateUi(state: state)
            }
            switch state {
            case .Stopped:
                SetPowerManageMent(true)
            default:
                SetPowerManageMent(false)
            }
        }
    }
    
    private func resetUi() {
        playSlider.maxValue = 0
        playSlider.doubleValue = 0
        posView.stringValue = Int64(0).timeStringMs()
    }
    
    private func syncUi() {
        posView.stringValue = player.position.timeStringMs()
        if playSlider.maxValue == 0 {
            playSlider.maxValue = Double(player.mediaInfo.duration)
            durationView.stringValue = player.mediaInfo.duration.timeStringMs()
        }
        playSlider.doubleValue = Double(player.position)
        
    }
    
    private func updateUi(state: State) {
        switch state {
        case .Playing:
            playBtn.title = "||"
        default:
            playBtn.title = ">"
        }
    }
    
    @objc func posChangeByUi(_ slider: NSSlider) {
        _ = player.seek(Int64(slider.doubleValue), flags: .FromStart, callback: nil)
    }
    
    @objc func onPlayBtn(_ btn: NSButton) {
        if player.state == .Playing {
            player.state = .Paused
        } else {
            player.state = .Playing
        }
    }
    
    @objc func onClick() {
        playSlider.isHidden = !playSlider.isHidden
        posView.isHidden = !posView.isHidden
        durationView.isHidden = !durationView.isHidden
        playBtn.isHidden = !playBtn.isHidden
    }
    
    lazy private var playSlider : NSSlider = {
        let slider = NSSlider()
        slider.target = self
        slider.isContinuous = true
        slider.action = #selector(posChangeByUi(_:))
        return slider
    }()
    
    private func newTimeLabel() -> NSTextField {
        let view = NSTextField()
        view.alignment = .right
        view.font = NSFont.pfRegular(size: 14)
        view.backgroundColor = .clear
        // transparent background
        view.textColor = .white
        view.isEditable = false
        view.drawsBackground = false
        view.isBezeled = false
        return view
    }

    private lazy var posView : NSTextField = {
        let view = newTimeLabel()
        view.alignment = .right
        return view
    }()
    
    private lazy var durationView : NSTextField = {
        let view = newTimeLabel()
        view.alignment = .left
        return view
    }()
    
    private lazy var playBtn : NSButton = {
        let btn = NSButton()
        btn.title = ">"
        btn.font = NSFont.pfSemibold(size: 20)
        btn.target = self
        btn.action = #selector(onPlayBtn(_:))
        // clear background
        /*
        btn.isBordered = false
        btn.wantsLayer = true
        btn.layer?.backgroundColor = NSColor.clear.cgColor*/
        return btn
    }()
}


extension ViewController {
    override var acceptsFirstResponder: Bool { true }
    
    override func keyDown(with event: NSEvent) {
        interpretKeyEvents([event])
        print("code: \(event.keyCode), char: \(String(describing: event.characters)), modifiers: \(event.modifierFlags)")
        switch event.charactersIgnoringModifiers {
        case " ":
            player.state = player.state == .Paused ? .Playing : .Paused
        case "q":
            NSApp.terminate(nil)
        default:
            break
        }
    }
    
    override func moveLeft(_ sender: Any?) {
        _ = player.seek(player.position - 10000, callback: nil)
    }
    
    override func moveRight(_ sender: Any?) {
        _ = player.seek(player.position + 10000, callback: nil)
    }
}
