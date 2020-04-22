//
//  NSManagedObjectContext+ReactiveExtensions.swift
//
//
//  Created by Luca Gobbo on 21/04/2020.
//

import CoreData
import Foundation
import ReactiveKit

public extension ReactiveExtensions where Base: NSManagedObjectContext {
    /**
     Executes a fetch request and returns the fetched objects as an `Signal` array of `NSManagedObjects`.
     - parameter fetchRequest: an instance of `NSFetchRequest` to describe the search criteria used to retrieve data from a persistent store
     - parameter sectionNameKeyPath: the key path on the fetched objects used to determine the section they belong to; defaults to `nil`
     - parameter cacheName: the name of the file used to cache section information; defaults to `nil`
     - returns: An `Signal` array of `NSManagedObjects` objects that can be bound to a table view.
     */
    func entities<T: NSManagedObject>(fetchRequest: NSFetchRequest<T>,
                                      sectionNameKeyPath: String? = nil,
                                      cacheName: String? = nil) -> Signal<[T], ReactiveKitCoreData.Error> {
        return Signal<[T], ReactiveKitCoreData.Error> { observer in

            let observerAdapter = FetchedResultsControllerEntityObserver(
                observer: observer,
                fetchRequest: fetchRequest,
                managedObjectContext: self.base,
                sectionNameKeyPath: sectionNameKeyPath,
                cacheName: cacheName
            )
            return BlockDisposable {
                observerAdapter.dispose()
            }
        }
    }

    /**
     Executes a fetch request and returns the fetched section objects as an `Signal` array of `NSFetchedResultsSectionInfo`.
     - parameter fetchRequest: an instance of `NSFetchRequest` to describe the search criteria used to retrieve data from a persistent store
     - parameter sectionNameKeyPath: the key path on the fetched objects used to determine the section they belong to; defaults to `nil`
     - parameter cacheName: the name of the file used to cache section information; defaults to `nil`
     - returns: An `Signal` array of `NSFetchedResultsSectionInfo` objects that can be bound to a table view.
     */
    func sections<T: NSManagedObject>(fetchRequest: NSFetchRequest<T>,
                                      sectionNameKeyPath: String? = nil,
                                      cacheName: String? = nil) -> Signal<[NSFetchedResultsSectionInfo], ReactiveKitCoreData.Error> {
        return Signal<[NSFetchedResultsSectionInfo], ReactiveKitCoreData.Error> { observer in
            let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                        managedObjectContext: self.base,
                                                        sectionNameKeyPath: sectionNameKeyPath,
                                                        cacheName: cacheName)

            let observerAdapter = FetchedResultsControllerSectionObserver(
                observer: observer,
                fetchedResultsController: controller
            )

            return BlockDisposable {
                observerAdapter.dispose()
            }
        }
    }
}
