//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        map.frame = UIScreen.main.bounds
        
        
        if CLLocationManager.locationServicesEnabled() {
            checkAuthorizationStatus(status: manager.authorizationStatus)
        } else {
            let alert = UIAlertController(title: "Location Permissions Required", message: "Please enable location services in system settings.", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("HERE")
        checkAuthorizationStatus(status: status)
    }
    
    func checkAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                permissionsGranted()
                break
            case .notDetermined:
                let locationManager = CLLocationManager()
                locationManager.requestWhenInUseAuthorization()
                break
            case .denied, .restricted:
                permissionsDenied()
                break
            default:
                break
        }
    }
    
    func permissionsDenied() {
        let alert = UIAlertController(title: "Location Permissions Required", message: "Please allow the app the use your location.", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true)
    }
    
    func permissionsGranted() {
        map.showsUserLocation = true
    }
}
