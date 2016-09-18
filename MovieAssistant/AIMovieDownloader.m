//  AIMovieDownloader.m
//  MovieAssistantFinal
//  Created by Andrii & Ihor on 9/17/16.
//  Copyright © 2016 lv189.ios. All rights reserved.

#import "AIMovieDownloader.h"
#import "AIMovieParser.h"
#import <AFNetworking/AFNetworking.h>
#import "MOADownloadManager.h"
#import "UIImageView+AFNetworking.h"

@implementation AIMovieDownloader

+ (void)searchMovies:(void(^)(NSArray<AIMovieParser*>*))handler {
    
    if (!handler)
        return;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:@"http://api.themoviedb.org/3/movie/top_rated?"
      parameters:@{@"api_key" : @"5e1809003aa40c436c5632289269da65"}
        progress:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 
                 NSArray *results = responseObject[@"results"];
                 
                 NSMutableArray *films = [NSMutableArray array];
                 
                 for (NSDictionary *firstResult in results) {
                     AIMovieParser *film = [AIMovieParser parseMovie:firstResult];
                     [films addObject:film];
                     
                     
                 }
                 
                 handler(films);
             }
             
             else {
                 // TODO: Handle response error!
                 NSLog(@"Response Error");
                 
                 handler(nil);
             }
         }
     
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             // TODO: Show Allert on error!
             NSLog(@"Error : %@", error.description);
             handler(nil);
         }];
}

+ (void)imageView:(UIImageView *)imageView testLoadImageWithPath:(NSString *)path {
    
    NSURL *url = [NSURL URLWithString:path];
    if (url) {
        [imageView setImageWithURL:url];
    }
    
    
   
}


@end