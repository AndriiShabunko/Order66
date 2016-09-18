//  MOAInitialViewController.m
//  MovieAssistantFinal
//  Created by team on 22.08.16.
//  Copyright © 2016 lv189.ios. All rights reserved.

#import "MOAInitialViewController.h"

#import "MOADownloadManager.h"
#import "MOAMovieManager.h"
#import "MOAMovieSearchController.h"
#import "YTPlayerView.h"
#import "iCarousel.h"
#import "MOACollectionsViewController.h"

#import <AFNetworking/AFNetworking.h>

// TEST
#import "AIMovieDownloader.h"
#import "AIMovieParser.h"
// TEST

#pragma mark - Interface:

@interface MOAInitialViewController () <iCarouselDataSource, iCarouselDelegate, YTPlayerViewDelegate>

@property(weak, nonatomic) IBOutlet iCarousel *moviesCarousel;
@property(weak, nonatomic) IBOutlet UILabel *movieInfoLabel;
@property(weak, nonatomic) IBOutlet YTPlayerView *youtubeTrailerView;

// Buttons:
@property(weak, nonatomic) IBOutlet UIButton *showMapButton;
@property(weak, nonatomic) IBOutlet UIButton *shareButton;
@property(weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *mostPopular;
@property (weak, nonatomic) IBOutlet UIButton *mostRated;
@property (weak, nonatomic) IBOutlet UIButton *watchLater;

// Networking:
@property (strong, nonatomic) NSMutableArray* arrayWithDataForCollections;
@property(strong, nonatomic) NSMutableArray<MOAMovieManager *> *arrayWithMovies;

// TEST
@property(strong, nonatomic) NSMutableArray<AIMovieParser*> *movieArray;
@property(weak, nonatomic) IBOutlet UITextView *testMovieDescription;
@property(weak, nonatomic) NSString *testStringMovieDescription;
// TEST

// Button's actions:
- (IBAction)mostPopularTouch:(id)sender;
- (IBAction)mostRatedTouch:(id)sender;
- (IBAction)watchLaterTouch:(id)sender;
- (IBAction)showMapButtonTouch:(id)sender;

@end


#pragma mark - Implementation:

@implementation MOAInitialViewController

- (void)viewDidLoad {
  [super viewDidLoad];

// Set Buttons:
    [_watchLater setBackgroundImage:[UIImage imageNamed:@"3.jpg"] forState:UIControlStateNormal];
    [_mostRated setBackgroundImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
    [_mostPopular setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [_showMapButton setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [_shareButton setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [_searchButton setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    
  [self setDefaultMovies];
}

// TEST
- (void) setDefaultMovies {
    
    self.movieArray = [NSMutableArray array];
    
    [AIMovieDownloader searchMovies:^(NSArray* films) {
        
        for (AIMovieParser *film in films) {
            AIMovieParser *testTopRated = [AIMovieParser takeParsedElementsxOriginalTitle:film.movieOriginalTitle andCurrentTitle:nil andOriginalLanguage:nil andOverview:film.movieOverview andPosterPath:film.moviePosterPath andBackdropPath:nil andReleaseDate:nil andID:nil andVoteCount:nil andVoteAverage:nil andPopularity:nil andGenres:nil];
            
            [self.movieArray addObject:testTopRated];
        }
        NSLog(@"ELEMENTS + %lu", [self.movieArray count]);
        [self configureCarusels];
    }];
    
}
// TEST


// Carousel data load:
- (void)configureCarusels {

    self.moviesCarousel.delegate = self;
    self.moviesCarousel.dataSource = self;
    self.moviesCarousel.type = iCarouselTypeCoverFlow;
    [self.moviesCarousel reloadData];
    
    [self.moviesCarousel scrollToItemAtIndex:self.movieArray.count
                                    duration:5.f];
}


#pragma mark - iCarousel delegete

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {

    return self.movieArray.count;
}

// Carousel View:
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
  
    UIView *movieView = nil;
    
    //create new view if no view is available for recycling
    if (view == nil) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 340)];
        UINib *nib = [UINib nibWithNibName:@"Movie" bundle:nil];
        NSArray *a = [nib instantiateWithOwner:self options:nil];
        movieView = a.lastObject;
        movieView.frame = view.bounds;
        movieView.tag = 3;

        [view addSubview:movieView];
    }
    
    else {
        
        //get a reference to the label in the recycled view
        movieView = (UIView *)[view viewWithTag:3];
    }
    
    UIImageView *iv = [movieView viewWithTag:1];
    [AIMovieDownloader imageView:iv
                testLoadImageWithPath:[self.movieArray objectAtIndex:index]
                                      .moviePosterPath];
    UILabel *l = [movieView viewWithTag:2];
//    l.backgroundColor = [UIColor greenColor];
    
    
    
    l.text = [self.movieArray objectAtIndex:index].movieOriginalTitle;
    
    return view;
}

// Carousel View Width:
- (CGFloat)carouselItemWidth:(iCarousel *)carousel {

    return  CGRectGetHeight(carousel.frame)*0.53;
}
// докрутити афыгенну штуку////////////////////////////////////////////
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {

    self.testMovieDescription.text = [self.movieArray objectAtIndex:carousel.currentItemIndex].movieOverview;

   
  
    
}

// Current view did select:
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"this is object at index:%ld", (long)index);
}


- (IBAction)showMapButtonTouch:(id)sender {
    
}


#pragma mark - Working with components

//- (void)updateMovieInfoLabel:(NSString *)movieInfo {
//  self.movieInfoLabel.text = [NSString stringWithFormat:@"%@", movieInfo];
//
//}


#pragma mark - Social network sharing

//- (IBAction)showSocialView:(id)sender {
//
//  NSString *shareText = [NSString
//      stringWithFormat:@"Nice movie: %@!",
//                       [self.arrayWithMovies
//                           objectAtIndex:self.arrayWithMovies.count / 2]
//                           .movieName];
//  NSArray *itemsToShare = @[ shareText ];
//  UIActivityViewController *activity =
//      [[UIActivityViewController alloc] initWithActivityItems:itemsToShare
//                                        applicationActivities:nil];
//  activity.popoverPresentationController.sourceView = self.shareButton;
//  activity.popoverPresentationController.sourceRect = ((UIView *)sender).bounds;
//  activity.excludedActivityTypes = @[ UIActivityTypeCopyToPasteboard ];
//  [self presentViewController:activity animated:YES completion:nil];
//}
//
//- (IBAction)mostPopularTouch:(id)sender {
//    // Call Soroka method to fill self.arrayWithData...
////    self.arrayWithMovies = [NSMutableArray array];
////    
////    [MOADownloadManager fetchAllMoviesWithCompletionUpComing:^(NSArray *films) {
////        [self.arrayWithMovies addObjectsFromArray:films];
////        NSArray *posterPathUpComing = [_arrayWithMovies valueForKeyPath:@"@distinctUnionOfObjects.posterPath"];
////        [self.arrayWithMovies removeAllObjects];
////        [self.arrayWithMovies addObjectsFromArray:posterPathUpComing];
////        NSLog(@"");
////    }];
//    
//    self.arrayWithDataForCollections = [NSMutableArray array];
//    
//    [MOADownloadManager fetchAllMoviesWithCompletionMostPopular:^(NSArray *films) {
//        
//        for (MOAFilm *film in films) {
//            MOAMovieManager *mostPopular = [MOAMovieManager
//                                         newMoviewWithName:film.title//@"Deadpool"
//                                         andYear:@"2016"
//                                         andGenres:@"Adventure"
//                                         andRating:@"7.2"
//                                         andDescription:@"This is Deadpool"
//                                         andPoster:film.posterPath//@"http://cdn.traileraddict.com/content/"
//                                         //@"20th-century-fox/"
//                                         //@"deadpool-poster-10.jpg"
//                                         andTrailer:@"ZIM1HydF9UA"];
//            
//            [self.arrayWithDataForCollections addObject:mostPopular];
//        }
//    [self performSegueWithIdentifier:@"toCollections" sender:self];
//    }];
//}
//
//- (IBAction)mostRatedTouch:(id)sender {
//    
//    self.arrayWithDataForCollections = [NSMutableArray array];
//    
//    [MOADownloadManager fetchAllMoviesWithCompletionTopRated:^(NSArray *films) {
//        
//        for (MOAFilm *film in films) {
//            MOAMovieManager *topRated = [MOAMovieManager
//                                            newMoviewWithName:film.title//@"Deadpool"
//                                            andYear:@"2016"
//                                            andGenres:@"Adventure"
//                                            andRating:@"7.2"
//                                            andDescription:@"This is Deadpool"
//                                            andPoster:film.posterPath//@"http://cdn.traileraddict.com/content/"
//                                            //@"20th-century-fox/"
//                                            //@"deadpool-poster-10.jpg"
//                                            andTrailer:@"ZIM1HydF9UA"];
//            
//            [self.arrayWithDataForCollections addObject:topRated];
//        }
//    [self performSegueWithIdentifier:@"toCollections" sender:self];
//    }];
//}
//
//
//- (IBAction)watchLaterTouch:(id)sender {
//    [self performSegueWithIdentifier:@"toCollections" sender:self];
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
// // Make sure your segue name in storyboard is the same as this line
//    if ([[segue identifier] isEqualToString:@"toCollections"])
//    {
//        // Get reference to the destination view controller
//        MOACollectionsViewController *vc = [segue destinationViewController];
//        
//        // Pass any objects to the view controller here, like...
//        vc.dataFromInitial = self.arrayWithDataForCollections;
//    }
//}

@end