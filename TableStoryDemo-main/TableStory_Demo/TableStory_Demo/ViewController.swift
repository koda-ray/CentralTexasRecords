//
//  ViewController.swift
//  TableStory_Demo
//
//  Created by Royal, Cindy L on 3/28/23.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Sundance Records and Tapes", neighborhood: "San Marcos", desc: "Sundance records has served the Austin/ San Marcos areas since 1977. They have thousands of posters, records, and rare collectibles for browsing in an authentic 70s rock and roll style shop.", lat: 29.883970, long: -97.940320, imageName: "p1"),
    Item(name: "Alchemy Records", neighborhood: "San Marcos", desc: "Alchemy Records is a self-proclaimed weird record shop for weird people! Records, clothing, crystals, and more - you never know what you'll find. ", lat: 29.88143214306098, long: -97.93955806931568, imageName: "p2"),
    Item(name: "Studio 1916", neighborhood: "Kyle", desc: "Studio 1916 is a recording studio out of Kyle, TX. This studio hosts most local artists and offers a complete collection of recording tech. Anything you'd like to record, from audiobooks to albums, Studio 1916 has you covered.", lat: 29.999040487416327, long: -97.86104207149017, imageName: "p3"),
    Item(name: "Plum Creek Records & Tapes", neighborhood: "Lockhart", desc: "A superstore of classic posters and vinyls, even offering online order pick-ups. This groovy little record shop has earned itself a loyal community and frequently hosts live music events with food trucks and drinks.", lat: 29.881940, long: -97.671560, imageName: "p4"),
    Item(name: "Stingray Records", neighborhood: "New Braunfels", desc: "Stingray records is a happy little record store out of New Braunfels, TX. They have a seemigly endless collection of record and vinyl for purchase and browsing. Stingray records also has state of the art recording studios avaliable to artists.", lat: 29.711030, long: -98.120890 , imageName: "p5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       //Add image references
                    let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       return cell!
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DeatilViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 29.88143214306098, longitude: -97.93955806931568)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }

              }


}


//Demo created on March 28 for GitHub

