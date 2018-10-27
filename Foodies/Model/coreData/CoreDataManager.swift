//
//  CoreDataManager.swift
//  Foodies
//
//  Created by mohamed fawzy on 10/26/18.
//  Copyright © 2018 mohamed fawzy. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    let container: NSPersistentContainer
    
    override init() {
        container = NSPersistentContainer(name: "FoodiesModel")
        container.loadPersistentStores { (storeDesc, error) in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
        super.init()
    }
    
   
    
    fileprivate func save() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
}

// MARK:- reviews helper methods
extension CoreDataManager{
    
    func fetchReviews(by id:Int) -> [ReviewItem]{
        var reviews:[ReviewItem] = []
        let context = container.viewContext
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i",Int32(id))
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            for review in try context.fetch(request) {
                reviews.append(ReviewItem(data: review))
            }
            return reviews
        } catch  {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
    
    func saveReview(_ reviewItem: ReviewItem){
        let review = Review(context: container.viewContext)
        review.title = reviewItem.title
        review.name = reviewItem.name
        review.date = Date()
        review.customerReview = reviewItem.customerReview
        review.uuid = reviewItem.uuid
        if let rating = reviewItem.rating {
            review.rating = rating
        }
        if let id = reviewItem.restaurantID {
            review.restaurantID = Int32(id)
            print("restaurant id \(id)")
            save()
        }
    }
    
    func fetchRestaurantRating(by identifier:Int) -> Float {
        let reviews = fetchReviews(by: identifier)
        //print(reviews)
        let sum = reviews.reduce(0, {$0 + ($1.rating ?? 0)}) / Float(reviews.count)
        return sum
    }
}


// MARK:- photos helper methods
extension CoreDataManager{
    
    func fetchPhotos(by id: Int) -> [RestaurantPhotoItem] {
        var photos:[RestaurantPhotoItem] = []
        let context = container.viewContext
        let request:NSFetchRequest<RestaurantPhoto> = RestaurantPhoto.fetchRequest()
        let predicate = NSPredicate(format:"restaurantID = %i",Int32(id))
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            for photo  in try context.fetch(request) {
                photos.append(RestaurantPhotoItem(data: photo))
            }
            return photos
        } catch  {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
    
    func savePhoto(_ item:RestaurantPhotoItem) {
        let photo = RestaurantPhoto(context: container.viewContext)
        photo.date = Date()
        photo.photo = item.photoData as Data
        photo.uuid = item.uuid
        if let id = item.restaurantID {
            photo.restaurantID = Int32(id)
            print("restaurant id \(id)")
            save()
        }
    }
    
}
