//
//  MTLVideoView.swift
//  SwiftApp
//
//  Created by WangBin on 2021/3/15.
//

import MetalKit

// MARK: Metal Stuff

class MTLVideoView: MTKView {
    private var cmdQueue : MTLCommandQueue!
    private var player : Player!

    var hdr : Bool = false {
        didSet {
            if hdr {
                player.set(colorSpace: .Unknown, vid: self)
            } else {
                player.set(colorSpace: .BT709, vid: self)
            }
        }
    }

    init(player : Player) {
        super.init(frame: .zero, device: MTLCreateSystemDefaultDevice())
        // Make sure we are on a device that can run metal!
        guard let defaultDevice = device else {
            fatalError("Device loading error")
        }
        self.player = player
        createRenderer(device: defaultDevice)

        registerForDraggedTypes([.fileURL, .URL])
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }

    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pb = sender.draggingPasteboard
        if let urls = pb.readObjects(forClasses: [NSURL.self]) as? [URL] {
            player.media = urls.first!.path
            return true
        }
        return false
    }

    func createRenderer(device: MTLDevice){
        cmdQueue = device.makeCommandQueue()
        delegate = self
        player.addRenderTarget(self, commandQueue: cmdQueue)

        enableSetNeedsDisplay = true
        if enableSetNeedsDisplay {
            player.setRenderCallback { [weak self] in
                DispatchQueue.main.async {
                    self?.setNeedsDisplay(.zero)
                }
            }
        }

        let scrW = NSScreen.main?.frame.width ?? 1920
        player.videoDecoders = ["VT:copy=0", "BRAW:BRAW:gpu=auto:copy=1:scale=\(scrW)", "hap", "VideoToolbox"]

        player.setTimeout(0, callback: { timeout in
            print("timeout detected \(timeout)!!!!")
            return true
        })
        player.onMediaStatusChanged {
            print(".....Status changed to \($0)....")
            return true
        }
        setGlobalOption(name: "videoout.clear_on_stop", value: 1)
    }

}

extension MTLVideoView: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        player.setVideoSurfaceSize(size.width, size.height, vid: view)
    }

    func draw(in view: MTKView) {
        let _ = player.renderVideo(vid: view)
        //print("draw view: \(view)")
        //NSLog("@ buffered: %d", player.buffered())
        guard let d = view.currentDrawable else {
            return
        }
        let cmdBuf = cmdQueue.makeCommandBuffer()
        cmdBuf?.present(d)
        cmdBuf?.commit()
    }
}
