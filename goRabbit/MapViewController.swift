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
        } else {
            removeMarker()
        }
        //        let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
        //        let camera = GMSCameraPosition(target: coordinate, zoom: 17)
        //        mapView.camera = camera
    }
    
    @IBAction func toggleMarker(_ sender: Any) {
        alertAddadress(title: "Добавить", placeholder: "Введите адрес") { (text) in
            print(text)
        }
    }
    
    private func setupPlacemark() {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("") { [self] (placemark, error) in
            
            if let error = error {
                print(error)
                alertError(title: "Ошибка", message: "Сервер недоступен")
                return
            }
//            guard let placemark = placemark else { return }
//            let placemark = placemark.first
            
           
            
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
        let camera = GMSCameraPosition(target: coordinate, zoom: 17)
        mapView.camera = camera
        mapView.delegate = self
    }
    private func removeMarker() {
        marker?.map = nil
        marker = nil
    }
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
       // locationManager?.requestLocation()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
}

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

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error:
    Error) {
    print(error)
        
    }
    
}
