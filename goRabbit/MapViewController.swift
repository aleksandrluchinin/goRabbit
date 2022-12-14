//
//  ViewController.swift
//  goRabbit
//
//  Created by Aleksandr  on 13.12.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    
    private let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    private var locationManager: CLLocationManager?
    
    private var marker: GMSMarker?
    private var manualMarker: GMSMarker?
    
    //    private var mapView: GMSMapView = {
    //        let mapView = GMSMapView()
    //        mapView.translatesAutoresizingMaskIntoConstraints = false
    //        return mapView
    //    }()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  setConstraints()
        
        configure()

    }
    
    @IBAction func homeButton(_ sender: Any) {
        
        mapView.animate(toLocation: coordinate)
        
        if marker == nil {
            addMarker()
//        } else {
//            removeMarker()
       }
    }
    
    @IBAction func toggleMarker(_ sender: Any) {
        alertAddadress(title: "Добавить", placeholder: "Введите адрес") { (text) in
            print(text)
        }
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines!
                self.addressLabel.text = lines.joined(separator: "String")
                let labelHeight = self.addressLabel.intrinsicContentSize.height
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @IBAction func myPozitionButton(_ sender: Any) {
        configureLocationManager()
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        
    }
    
    
    func addMarker() {
        let marker = GMSMarker(position: coordinate)
        marker.icon = UIImage(named: "rabbit")
        marker.map = mapView
        self.marker = marker
    }
    
    private func configure() {
        let camera = GMSCameraPosition(target: coordinate, zoom: 15)
        mapView.camera = camera
        mapView.delegate = self
    }
//    private func removeMarker() {
//        marker?.map = nil
//        marker = nil
//    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        // locationManager?.requestLocation()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
}

//MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate:
                 CLLocationCoordinate2D) {
        
        if let manualMarker = manualMarker {
            manualMarker.position = coordinate
        } else {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            self.manualMarker = marker
            marker.icon = UIImage(named: "rabbit")
        }
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(coordinate: position.target)
    }
    
}

//extension MapViewController {
//
//    func setConstraints() {
//        view.addSubview(mapView)
//        NSLayoutConstraint.activate([
//            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//        ])
//    }
//}

//MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error:
                         Error) {
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager?.stopUpdatingLocation()
        }
    }
}


    

