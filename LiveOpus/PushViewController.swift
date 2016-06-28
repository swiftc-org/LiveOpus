//
//  PushViewController.swift
//  LiveAudio
//
//  Created by 成杰 on 16/6/28.
//  Copyright © 2016年 swiftc.org. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {
    
    // private let urlStr = "rtmp://swiftc.org/live/livestream"
    private let urlStr = "rtmp://192.168.1.107/live/livestream"
    private let rtmpClient = RTMPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(connectButton)
        
        view.addSubview(pushButton)
        
        rtmpClient.setLogLevel = RTMP_LOGDEBUG //RTMP_LOGALL
    }
    
    private let commonBtnW = CGFloat(100)
    private let commonBtnH = CGFloat(40)
    
    private var connectButton: UIButton {
        
        let buttonY = view.bounds.height - commonBtnH
        let buttonF = CGRect(x: 0,
                             y: buttonY,
                             width: commonBtnW,
                             height: commonBtnH)
        
        let button = UIButton(frame: buttonF)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("connect", forState: .Normal)
        button.addTarget(self,
                         action: #selector(connect),
                         forControlEvents: .TouchUpInside)
        
        return button
    }
    
    private var pushButton: UIButton {
        
        let buttonX = view.bounds.width - commonBtnW
        let buttonY = view.bounds.height - commonBtnH
        let buttonF = CGRect(x: buttonX,
                             y: buttonY,
                             width: commonBtnW,
                             height: commonBtnH)
        
        let button = UIButton(frame: buttonF)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("push", forState: .Normal)
        button.addTarget(self,
                         action: #selector(push),
                         forControlEvents: .TouchUpInside)
        
        return button
    }
    
    dynamic func connect() {
        
        if rtmpClient.connect(urlStr) {
            print("connect succeed")
        } else {
            print("connect failed")
        }
    }
    
    dynamic func push() {
        
        guard rtmpClient.isConnected else {
            print("have not connected")
            return
        }
        
        rtmpClient.readAudio()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
