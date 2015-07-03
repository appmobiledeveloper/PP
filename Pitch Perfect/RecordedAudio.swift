//
//  RecordSound.swift
//  Pitch Perfect
//
//  Created by Mobile Developer on 7/1/15 w [27.1].
//  Copyright (c) 2015 Mobile Developer. All rights reserved.
//

import Foundation

class RecordedAudio{

    var filePathUrl: NSURL!
    var title:       String!

    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl   = filePathUrl
        self.title = title

    }
}
