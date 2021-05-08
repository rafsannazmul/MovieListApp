//
//  MovieTableViewCell.swift
//  MovieListApp
//
//  Created by odysseyMacPro1 on 5/6/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var descriptionLabelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func updateUI(){
        posterImageView.frame = CGRect(x: 0, y: 0, width: 60, height: 100)
        posterImageView.center = CGPoint(x: 5 + 30, y: self.frame.height/2)
        
        titleLabelView.frame = CGRect(x: posterImageView.frame.maxX + 5, y: 5, width: self.frame.width - (posterImageView.frame.width + 20), height: 30)
        descriptionLabelView.frame = CGRect(x: posterImageView.frame.maxX + 5, y: titleLabelView.frame.maxY + 5, width: self.frame.width - (posterImageView.frame.width + 20), height: self.frame.height - (5 + 30))
    }
    
    func setData(posterImage : String, titleText : String, descriptionText : String){
        //posterImageView.downloaded(from: posterImage)
        posterImageView.imageFromUrl(urlString: posterImage)
        titleLabelView.text = titleText
        descriptionLabelView.text = descriptionText
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}


extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
}
