//
//  Section.swift
//  Alumni
//
//  Created by alumnos on 12/3/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import Foundation


struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies: [String], expanded: Bool) {
    self.genre = genre
    self.movies = movies
    self.expanded = expanded
    }
}
