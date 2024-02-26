//
//  PM.swift
//  SPV
//
//  Created by WangBin on 2021/4/5.
//

import IOKit.pwr_mgt

fileprivate var pmid = IOPMAssertionLevel(kIOPMNullAssertionID)

func SetPowerManageMent(_ value : Bool) {
    if value {
        if pmid == kIOPMNullAssertionID {
            return
        }
        IOPMAssertionRelease(pmid)
        pmid = IOPMAssertionLevel(kIOPMNullAssertionID)
    } else {
        if pmid != kIOPMNullAssertionID {
            return
        }
        IOPMAssertionCreateWithName(kIOPMAssertionTypePreventUserIdleDisplaySleep  as CFString, IOPMAssertionLevel(kIOPMAssertionLevelOn), "com.mediadevkit.video_playing"  as CFString, &pmid)
    }
}
