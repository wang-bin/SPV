//
//  PreviewViewController.swift
//  QLView
//
//  Created by WangBin on 2024/2/26.
//

import Cocoa
import Quartz
import SPVBase
import SnapKit
import os

class PreviewViewController: NSViewController, QLPreviewingController {

    static private let logObj = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "media")
    @available(macOSApplicationExtension 11.0, *)
    static private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "media")
    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.

        logLevel = .All
        setLogHandler { (level, msg) in
            if #available(macOSApplicationExtension 11.0, *) {
                PreviewViewController.logger.log(level: .default, "\(msg, privacy: .public)")
            } else {
                os_log("%@", log: PreviewViewController.logObj, type: .default, msg)
                //OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "media")
            }
        }
    }

    /*
     * Implement this method and set QLSupportsSearchableItems to YES in the Info.plist of the extension if you support CoreSpotlight.
     *
    func preparePreviewOfSearchableItem(identifier: String, queryString: String?, completionHandler handler: @escaping (Error?) -> Void) {
        // Perform any setup necessary in order to prepare the view.

        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        handler(nil)
    }
     */

    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {

        // Add the supported content types to the QLSupportedContentTypes array in the Info.plist of the extension.

        // Perform any setup necessary in order to prepare the view.

        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        let vc = ViewController()
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        vc.play(file: url.path, completionHandler: handler)
    }
}
