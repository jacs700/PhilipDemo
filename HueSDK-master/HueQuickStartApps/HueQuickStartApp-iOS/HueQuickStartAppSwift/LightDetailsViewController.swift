//
//  LightDetailsViewController.swift
//  HueQuickStartAppSwift
//
//  Created by Jorge Castillo solis on 4/30/18.
//  Copyright © 2018 Philips Lighting B.V. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}


public class LightDetailsViewController : UIViewController, SwiftHUEColorPickerDelegate {
   

    @IBOutlet weak var colorPicker: SwiftHUEColorPicker!
    
    @IBOutlet weak var saturationPicker: SwiftHUEColorPicker!
    
    @IBOutlet weak var brightNessPicker: SwiftHUEColorPicker!
    
    @IBOutlet weak var alphaPicker: SwiftHUEColorPicker!
    
    var model = "LCT014"
    var lightPoint: PHSLightPoint?
    var saturation: NSNumber = 0.0
    var brightness: NSNumber = 0.0
    var hue: NSNumber = 0.0
    var alpha: NSNumber = 0.0
    var color: UIColor = UIColor()
    
    override public func viewDidLoad() {
    
        super.viewDidLoad()
        
        if let light = lightPoint {
            saturation = light.lightState.saturation
            brightness = light.lightState.brightness
            hue = light.lightState.hue
            alpha = 1
            color = UIColor(hue: CGFloat(hue.floatValue), saturation: CGFloat(truncating: saturation), brightness: CGFloat(truncating: brightness), alpha: CGFloat(truncating: alpha))
        }

        colorPicker.delegate = self
        colorPicker.direction = .vertical
        colorPicker.type = .color
        
        saturationPicker.delegate = self
        saturationPicker.direction = .vertical
        saturationPicker.type = .saturation
        
        brightNessPicker.delegate = self
        brightNessPicker.direction = .vertical
        brightNessPicker.type = .brightness
        
        alphaPicker.delegate = self
        alphaPicker.direction = .vertical
        alphaPicker.type = .alpha
        
        
    }
  
    
    
    public func valuePicked(_ color: UIColor, type: SwiftHUEColorPicker.PickerType) {
        
        self.color = color
        
        switch type {
        case SwiftHUEColorPicker.PickerType.color:
            saturationPicker.currentColor = color
            brightNessPicker.currentColor = color
            alphaPicker.currentColor = color
            break
        case SwiftHUEColorPicker.PickerType.saturation:
            colorPicker.currentColor = color
            brightNessPicker.currentColor = color
            alphaPicker.currentColor = color
            break
        case SwiftHUEColorPicker.PickerType.brightness:
            colorPicker.currentColor = color
            saturationPicker.currentColor = color
            alphaPicker.currentColor = color
            break
        case SwiftHUEColorPicker.PickerType.alpha:
            colorPicker.currentColor = color
            saturationPicker.currentColor = color
            brightNessPicker.currentColor = color
            break
        }
    }
  
    @IBAction func updateStatus(_ sender: Any) {
        if let light = lightPoint {
            let lightState:PHSLightState = light.lightState
            
            lightState.setXYWith(PHSColor.create(withRed: Int32(color.redValue), green: Int32(color.greenValue), blue: Int32(color.blueValue)))
            
            
            
            //PHSColor(xy: <#T##PHSColorXY?#>, brightness: brightness.doubleValue, model: model, swVersion: light.lightInfo.swVersion)
            
            
            light.update(lightState, allowedConnectionTypes: .local, completionHandler: { (responses, errors, returnCode) in
            })
        }
    }
}
