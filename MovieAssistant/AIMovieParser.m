//  AIMovieParser.m
//  MovieAssistantFinal
//  Created by Andrii & Ihor on 9/17/16.
//  Copyright © 2016 lv189.ios. All rights reserved.

#import "AIMovieParser.h"

@implementation AIMovieParser

+ (AIMovieParser*) parseMovie:(NSDictionary*) dictionary {
    
    AIMovieParser *film = [[AIMovieParser alloc] init];
    
    film.movieOriginalTitle = [dictionary objectForKey:@"title"];
    
    NSString *posterPath = dictionary[@"poster_path"];
    NSString *posterURLstring = [[NSString stringWithFormat:@"https://image.tmdb.org/t/p/original%@", posterPath]stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    film.moviePosterPath = posterURLstring;
    film.movieOverview = dictionary[@"overview"];
    
    return film;
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
    
    AIMovieParser *newParsedMovie = [[AIMovieParser alloc]init];
    
    newParsedMovie.movieOriginalTitle = originalTitle;
    newParsedMovie.movieCurrentTitle = currentTitle;
    newParsedMovie.movieOriginalLanguage = originalLanguage;
    newParsedMovie.movieOverview = overview;
    newParsedMovie.moviePosterPath = posterPath;
    newParsedMovie.movieBackdropPath = backdropPath;
    newParsedMovie.movieReleaseDate = releaseDate;
    newParsedMovie.movieID = iD;
    newParsedMovie.movieVoteCount = voteCount;
    newParsedMovie.movieVoteAverage = voteAverage;
    newParsedMovie.moviePopularity = popularity;
    newParsedMovie.movieGenres = genres;
    
    return newParsedMovie;
}

@end