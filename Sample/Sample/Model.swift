//
//  Model.swift
//  Sample
//
//  Created by Balaji  on 18/02/22.
//

import Foundation
import ObjectMapper


struct UserModel : Mappable {
    var page : Int?
    var per_page : Int?
    var total : Int?
    var total_pages : Int?
    var data : [Data]?
    var support : Support?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        page <- map["page"]
        per_page <- map["per_page"]
        total <- map["total"]
        total_pages <- map["total_pages"]
        data <- map["data"]
        support <- map["support"]
    }

}

struct Data : Mappable {
    var id : Int?
    var email : String?
    var first_name : String?
    var last_name : String?
    var avatar : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        email <- map["email"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        avatar <- map["avatar"]
    }

}

struct Support : Mappable {
    var url : String?
    var text : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        url <- map["url"]
        text <- map["text"]
    }

}
