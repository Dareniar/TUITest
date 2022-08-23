//
//  MapView.swift
//  TUITest
//
//  Created by Danil on 23.08.2022.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  let route: [City]
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    
    route.forEach {
      let pin = MKPointAnnotation()
      pin.title = $0.name
      pin.coordinate = CLLocationCoordinate2D(latitude: $0.coordinates.lat, longitude: $0.coordinates.long)
      mapView.addAnnotation(pin)
    }
    
    let polyline = MKPolyline(
      coordinates: route.compactMap {
        CLLocationCoordinate2D(latitude: $0.coordinates.lat, longitude: $0.coordinates.long)
      },
      count: route.count
    )
    mapView.addOverlay(polyline)
    mapView.visibleMapRect = polyline.boundingMapRect
    return mapView
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {}
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  final class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
      self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let routePolyline = overlay as? MKPolyline {
        let renderer = MKPolylineRenderer(polyline: routePolyline)
        renderer.strokeColor = .red
        renderer.lineWidth = 3
        return renderer
      }
      return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      if annotation is MKUserLocation {
        return nil
      } else {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
          annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
          annotationView?.annotation = annotation
        }
        return nil
      }
    }
  }
}
