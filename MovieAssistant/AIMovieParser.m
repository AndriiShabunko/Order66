//  AIMovieParser.m
//  MovieAssistantFinal
//  Created by Andrii & Ihor on 9/17/16.
//  Copyright © 2016 lv189.ios. All rights reserved.

#import "AIMovieParser.h"

@implementation AIMovieParser

+ (AIMovieParser*) parseMovie:(NSDictionary*) dictionary {
    
    AIMovieParser *parsedMovie = [[AIMovieParser alloc] init];
    
    parsedMovie.movieOriginalTitle = dictionary[@"original_title"];
    parsedMovie.movieCurrentTitle = dictionary[@"title"];
    parsedMovie.movieOriginalLanguage = dictionary[@"original_language"];
    parsedMovie.movieOverview= dictionary[@"overview"];
//    parsedMovie.moviePosterPath = dictionary[@"poster_path"];
    parsedMovie.movieBackdropPath = dictionary[@"backdrop_path"];
    parsedMovie.movieReleaseDate = dictionary[@"release_date"];
    parsedMovie.movieID = dictionary[@"id"];
    parsedMovie.movieVoteCount = dictionary[@"vote_count"];
    parsedMovie.movieVoteAverage = dictionary[@"vote_average"];
    parsedMovie.moviePopularity = dictionary[@"popularity"];
    parsedMovie.movieGenres = dictionary[@"genre_ids"];

    NSString *posterPath = dictionary[@"poster_path"];
    NSString *posterURLstring = [[NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@", posterPath]stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    parsedMovie.moviePosterPath = posterURLstring;

    return parsedMovie;
}

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
                                          andGenres:(NSNumber*) genres {
    
    AIMovieParser *takedMovie = [[AIMovieParser alloc]init];
    
    takedMovie.movieOriginalTitle = originalTitle;
    takedMovie.movieCurrentTitle = currentTitle;
    takedMovie.movieOriginalLanguage = originalLanguage;
    takedMovie.movieOverview = overview;
    takedMovie.moviePosterPath = posterPath;
    takedMovie.movieBackdropPath = backdropPath;
    takedMovie.movieReleaseDate = releaseDate;
    takedMovie.movieID = iD;
    takedMovie.movieVoteCount = voteCount;
    takedMovie.movieVoteAverage = voteAverage;
    takedMovie.moviePopularity = popularity;
    takedMovie.movieGenres = genres;
    
    return takedMovie;
}

@end