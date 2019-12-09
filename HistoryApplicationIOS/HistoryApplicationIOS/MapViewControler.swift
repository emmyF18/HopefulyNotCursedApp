//
//  MapViewController.swift
//  HistoryApplicationIOS
//
//  Created by Sam Adeniyi on 11/11/19.
//  Copyright © 2019 Sam Adeniyi. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
class MapViewController: UIViewController,CLLocationManagerDelegate
{

    
    private let locationManager = CLLocationManager()
    
    @IBOutlet var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: -33.8683,
        longitude: 151.2086, zoom: 17)
        let mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
       


        // GOOGLE MAPS SDK: USER'S LOCATION
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last

        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)

        let downwards = GMSCameraUpdate.setCamera(camera)
        mapView.animate(with: downwards)

        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension MapViewController: GMSMapViewDelegate {
//
//}
//extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .denied:
//            print("User denied location permission") // Bail out of switch statement. Consider showing an alert that your app will need location to work.
//            return
//        case .authorizedWhenInUse:
//            print("App is authorized to use location while in use")
//            break
//        case .authorizedAlways:
//            print("App is authorized to always use this device's location")
//            break
//        default:
//            print("User has not yet determined location permission")
//            return
//        }
//        locationManager.startUpdatingLocation()
//
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//         print("Location Manager failed to get user's location. \(String(describing: error))")
//     }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let userLocation = locations.first else {
//            assertionFailure("Failed to get user's location")
//            return
//        }
//
//        locationManager.stopUpdatingLocation()
//        mapView.camera = GMSCameraPosition.camera(withTarget: userLocation.coordinate, zoom: 15)
//}
//}

