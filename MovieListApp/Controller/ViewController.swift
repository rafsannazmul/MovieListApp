//
//  ViewController.swift
//  MovieListApp
//
//  Created by odysseyMacPro1 on 5/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var moviesData = [Movie]()
    
    let url = "https://api.themoviedb.org/3/search/movie?api_key=45bf6592c14a965b33549f4cc7e6c664&query=marvel"
    
    struct Response : Codable {
        let page : Int
        let results : [Movie]
        let total_pages : Int
        let total_results : Int
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        DispatchQueue.global(qos: .background).async {
            self.getData(from: self.url)

        }
        
        
    }
    
    func CallForTableViewReload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func getData(from url : String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {
            data, response, error in
            guard let data = data, error == nil else{
                print("Something went wrong")
                return
            }
            
            //have data
            
            var result : Response?
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print("failed to convert \(error) for \(String(data: data, encoding: .utf8))")
            }
            
            guard let json = result else{
                return
            }
            
            print(json.page)
            print(json.results.count)
            self.moviesData = json.results
            self.CallForTableViewReload()

            
            
        })
        
        task.resume()
        
        
        
    }

    

}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MovieTableViewCell", owner: self, options: nil)?.first as! MovieTableViewCell
        
                
        cell.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        cell.updateUI()
        
        let string : String = moviesData[indexPath.row].poster_path ?? ""
        let url = "http://image.tmdb.org/t/p/w500"
        let fullUrl = url+string
            
            print("--->> \(fullUrl)")
            
        cell.setData(posterImage: fullUrl, titleText: moviesData[indexPath.row].original_title!, descriptionText: moviesData[indexPath.row].overview!)

        
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 200
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
