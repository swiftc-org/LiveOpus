//
//  RTMPClient.swift
//  LivePush
//
//  Created by 成杰 on 16/6/2.
//  Copyright © 2016年 swiftc.org. All rights reserved.
//

import UIKit

class RTMPClient {
    
    private let rtmp = RTMP_Alloc()
    
    var isConnected: Bool {
        
        return RTMP_IsConnected(rtmp) != 0
    }
    
    var setLogLevel: RTMP_LogLevel! {
        willSet {
            RTMP_LogSetLevel(newValue)
        }
    }
    
    init() {
        
        // Allocate rtmp context object
        RTMP_Init(rtmp)
    }
    
    /// Open rtmp connection to the given URL
    func connect(urlStr: String) -> Bool {
        
        let setupUrlResult = RTMP_SetupURL(rtmp, urlStr.asciiString)
        guard setupUrlResult != 0 else { // 0 means failed
            print("RTMP_SetupURL failed")
            return false
        }
        
        let connectResult = RTMP_Connect(rtmp, nil)
        guard connectResult != 0 else {
            print("RTMP_Connect failed")
            return false
        }
        
        let streamResult = RTMP_ConnectStream(rtmp, 0)
        guard streamResult != 0 else {
            print("RTMP_ConnectStream failed")
            return false
        }
        
        return isConnected
    }
    
    func readAudio() {
        
        var packet = RTMPPacket()
        while RTMP_ReadPacket(rtmp, &packet) != 0 {
            print("packet:\(packet)")
            //RTMPPacket_Dump(&packet)
            RTMPPacket_Free(&packet)
        }
        
    }
    
    func close() {
        
        guard isConnected else {
            print("rtmp is not connected")
            return
        }
        
        RTMP_Close(rtmp)
        RTMP_Free(rtmp)
    }
}
