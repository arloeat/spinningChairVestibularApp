//
//  ViewController.swift
//  spinningChairVestibularApp
//
//  Created by Arlo Erdaka on 18/07/19.
//  Copyright © 2019 Arlo Erdaka. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var userPrompt: UILabel!
    @IBOutlet weak var mascotView: UIImageView!
    
    let locationManager = CLLocationManager()
    var trueHeading = CLLocationDirection ()
    var lastEventTime : NSDate?
    var lastCoordinate = 0.0
    var spinCount = 0.0
    
    //    var headingArray:[Date:Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //get coordinates
        let coordinates = newHeading.trueHeading
        let angle = coordinates * .pi / 180
        let difference = abs(coordinates-lastCoordinate)
        
        //get time interval
        let now = NSDate()
        if let lastEventTime = self.lastEventTime {
            let timeSinceLast = now.timeIntervalSince(lastEventTime as Date)
            let dps = difference/timeSinceLast
            //            rotationPerMinute.text = "\(dps)"
            
            switch dps {
            case 60.1...100: userPrompt.text = "Keep this pace"
            case 100...1000: userPrompt.text = "Slow Down"
            default: userPrompt.text = "A bit faster"
            }
            
            print("difference: \(difference)), time since last move: \(timeSinceLast) seconds, degrees per second: \(dps)")
            
            //get spin count
            self.spinCount = spinCount + difference
            //            spinCounter.text = "\(spinCount)"
        }
        
        
        //calculate RPM
        //        let RPM =  coordinates - lastCoordinate
        //        print("\(RPM)")
        
        
        self.lastEventTime = now
        self.lastCoordinate = coordinates
        //headingArray?.updateValue(coordinates, forKey: lastEventTime)
        
        
        //print ("\(coordinates) degrees, \(lastEventTime) time, \(elapsed)")
        
        //let RPM = headingArray[
        
        UIImageView.animate(withDuration: 0.5){
            self.mascotView.transform = CGAffineTransform(rotationAngle: -CGFloat(angle))
        }
        
        
    }
    
    
    
}

