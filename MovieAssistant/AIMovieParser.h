//  AIMovieParser.h
//  MovieAssistantFinal
//  Created by Andrii & Ihor on 9/17/16.
//  Copyright © 2016 lv189.ios. All rights reserved.

#import <Foundation/Foundation.h>

@interface AIMovieParser : NSObject

// properties with parsed elements from each object in json array:
@property(strong, nonatomic) NSString *movieOriginalTitle;
@property(strong, nonatomic) NSString *movieCurrentTitle;
@property(strong, nonatomic) NSString *movieOriginalLanguage;
@property(strong, nonatomic) NSString *movieOverview;
@property(strong, nonatomic) NSString *moviePosterPath;
@property(strong, nonatomic) NSString *movieBackdropPath;

@property(strong, nonatomic) NSDate *movieReleaseDate;

@property(strong, nonatomic) NSNumber *movieID;
@property(strong, nonatomic) NSNumber *movieVoteCount;
@property(strong, nonatomic) NSNumber *movieVoteAverage;
@property(strong, nonatomic) NSNumber *moviePopularity;
@property(strong, nonatomic) NSNumber *movieGenres;

// class method to parse a json array objects:
+ (AIMovieParser*) parseMovie: (NSDictionary*)dictionary;

// class method to take elements from parsed properties:
+ (AIMovieParser*) takeParsedElementsxOriginalTitle:(NSString*) originalTitle
                                    andCurrentTitle:(NSString*) currentTitle
                                andOriginalLanguage:(NSString*) originalLanguage
                                        andOverview:(NSString*) overview
                                      andPosterPath:(NSString*) posterPath
                                    andBackdropPath:(NSString*) backdropPath
                                     andReleaseDate:(NSDate*) releaseDate
                                              andID:(NSNumber*) iD
                                       andVoteCount:(NSNumber*) voteCount
                                     andVoteAverage:(NSNumber*) voteAverage
                                      andPopularity:(NSNumber*) popularity
                                          andGenres:(NSNumber*) genres;

@end