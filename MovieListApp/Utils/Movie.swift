//
//  Movie.swift
//  MovieListApp
//
//  Created by odysseyMacPro1 on 5/6/21.
//

import Foundation

struct Movie : Codable{
    var adult : Bool?
    var backdrop_path : String?
    var genre_ids : [Int]?
    var id : Int?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Float?
    var poster_path : String?
    var release_date : String?
    var title : String?
    var video : Bool?
    var vote_average : Float?
    var vote_count : Int?

    
}

//{"adult":false,"backdrop_path":"/w2PMyoyLU22YvrGK3smVM9fW1jj.jpg","genre_ids":[28,12,878],"id":299537,"original_language":"en","original_title":"Captain Marvel","overview":"The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races. Set in the 1990s, Captain Marvel is an all-new adventure from a previously unseen period in the history of the Marvel Cinematic Universe.","popularity":192.943,"poster_path":"/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg","release_date":"2019-03-06","title":"Captain Marvel","video":false,"vote_average":7,"vote_count":11307}

var movieList : [Movie]!
