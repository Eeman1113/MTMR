//
//  HapticFeedback.swift
//  MTMR
//
//  Created by Anton Palgunov on 09/04/2018.
//  Copyright © 2018 Anton Palgunov. All rights reserved.
//

import IOKit

class HapticFeedback {
    private var actuatorRef: CFTypeRef?
    private var deviceID: UInt64 = 0x200000001000000
    private var error: IOReturn = 0
    
    // Don't know how to do strong is enum one of
    // 1 like backClick
    // 2 (like Click)
    // 3 (week)
    // 4 (medium)
    // 5 (week medium)
    // 6 (strong)
    // 15 (nothing)
    // 16 (nothing)
    
    func tap(strong:Int32) -> Void {
        let actuatorRef = MTActuatorCreateFromDeviceID(deviceID).takeRetainedValue()
        
        // TODO: Need to fix warning
        guard actuatorRef != nil else {
            print("guard actuatorRef == nil")
            return
        }
        
        error = MTActuatorOpen(actuatorRef)
        guard error == kIOReturnSuccess else {
            print("guard MTActuatorOpen")
            return
        }
        
        error = MTActuatorActuate(actuatorRef, strong, 0, 0.0, 0.0)
        guard error == kIOReturnSuccess else {
            print("guard MTActuatorActuate")
            return
        }
        
        error = MTActuatorClose(actuatorRef)
        guard error == kIOReturnSuccess else {
            print("guard MTActuatorClose")
            return
        }
        
        return
    }
}

