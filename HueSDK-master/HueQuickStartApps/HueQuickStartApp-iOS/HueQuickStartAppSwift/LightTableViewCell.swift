//
//  LightTableViewCell.swift
//  HueQuickStartAppSwift
//
//  Created by Jorge Castillo solis on 4/30/18.
//  Copyright © 2018 Philips Lighting B.V. All rights reserved.
//

import Foundation
import UIKit

public class LightTableViewCell: UITableViewCell  {
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var statusSwitch:UISwitch!
    
    var lightPoint: PHSLightPoint = PHSLightPoint()
    
    public func setUI (lightPoint: PHSLightPoint) {
        nameLabel?.text = lightPoint.name
        statusSwitch?.isOn = lightPoint.lightState.on.boolValue
        self.lightPoint = lightPoint
    }
    
    @IBAction func switchedTapped(_ sender: UISwitch) {
        let lightState:PHSLightState = PHSLightState()
        
        lightState.on = sender.isOn as NSNumber
        lightPoint.update(lightState, allowedConnectionTypes: .local, completionHandler: { (responses, errors, returnCode) in
        })
    }
    
}
