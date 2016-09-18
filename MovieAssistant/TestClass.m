//  TestClass.m
//  MovieAssistantFinal
//  Created by Andrew Shabunko on 9/17/16.
//  Copyright © 2016 lv189.ios. All rights reserved.

#import "TestClass.h"
//#import <AFNetworking/AFNetworking.h>
//#import "MOAFilm.h"

NSString *const testLatest = @"http://api.themoviedb.org/3/movie/latest";
NSString *const apiKey2 = @"5e1809003aa40c436c5632289269da65";

@interface TestClass ()

@property (weak, nonatomic) NSMutableArray *arrayWithMovies;

@end

@implementation TestClass
//
//- (void) initDefaultMovies {
//    
//    self.arrayWithMovies = [NSMutableArray array];
//    NSLog(@"my1st ARRAY COUNT = %lu", [self.arrayWithMovies count]);
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//    [manager GET:testLatest
//      parameters:apiKey2
//        progress:nil
//         success:^(NSURLSessionDataTask *task, id responseObject) {
//
//                 NSArray *results = responseObject[@"results"];
//                 
//                 NSMutableArray *films = [NSMutableArray array];
//                 for (NSDictionary *firstResult in results) {
//                     MOAFilm *film = [MOAFilm initWithDictionary:firstResult];
//                     [films addObject:film];
//                 }
//         }
//            failure:^(NSURLSessionDataTask *task, NSError *error) {
//             // TODO: Show Allert on error!
//             NSLog(@"Error : %@", error.description);
//         }
//     ];
//    
//     NSLog(@"my2nd RRAY COUNT = %lu", [self.arrayWithMovies count]);
//}

@end