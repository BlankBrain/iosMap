//
//  ViewController.swift
//  iosMap
//
//  Created by Md. Mehedi Hasan on 6/2/20.
//  Copyright © 2020 Md. Mehedi Hasan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 5000

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }

    func checkLocationServices() {
         if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
         } else {
            print("turn on location !")
           }
     }
    func setupLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
       }
    func checkLocationAuthorization() {
         switch CLLocationManager.authorizationStatus() {
         case .authorizedWhenInUse:
             mapView.showsUserLocation = true
             print("it works!")
             centerViewOnUserLocation()
             locationManager.startUpdatingLocation()
             break
         case .denied:
             // Show alert instructing them how to turn on permissions
             break
         case .notDetermined:
             locationManager.requestWhenInUseAuthorization()
         case .restricted:
             // Show an alert letting them know what's up
             break
         case .authorizedAlways:
             break
         }
     }
     
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
 

}
extension ViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
          mapView.setRegion(region, animated: true)
      }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}
