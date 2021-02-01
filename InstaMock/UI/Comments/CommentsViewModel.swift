//
//  CommentsViewModel.swift
//  InstaMock
//
//  Created by Susana on 1/18/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

class CommentsViewModel {
    
    var commentItems: [CommentItem] = []
       
       func commentItem(at index: Int) -> CommentItem? {
           guard commentItems.count > index else {
               return nil
           }
           
           return commentItems[index]
       }
    
}
