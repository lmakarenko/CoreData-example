//
//  AppDelegate.h
//  CoreDataCoursera
//
//  Created by Lev Makarenko on 27.02.2021.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Company+CoreDataClass.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic) NSManagedObjectContext *context;

- (void)saveContext;

@end

