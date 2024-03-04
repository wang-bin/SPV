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

class PreviewViewController: NSViewController, QLPreviewingController {

    override var nibName: NSNib.Name? {
        return NSNib.Name("PreviewViewController")
    }

    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view.

        //logLevel = .All
        setGlobalOption(name: "MDK_KEY", value:"7047A5E361F780A4CDEC1BEEAE2A424E3C18A3B7D995DA354983ED25B9C17879C775D4ABE2D97201E20AC3A9C7F7FAA0EE005AF13E77E13D5027A1C0F828F60F77475A1C9E087F5B3213E41151D5BDB13C18B9D4B6F8F4582CE78444DDA40E12AE01FAF8B28F5C50AE5CAACCB02880C78F6EA2426E51C646078FFD87AE28F60F")
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
        addChild(vc) // avoid vc deinit immediately
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        vc.play(file: url.path, completionHandler: handler)
    }
}
