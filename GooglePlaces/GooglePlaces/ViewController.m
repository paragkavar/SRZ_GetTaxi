//
//  ViewController.m
//  GooglePlaces
//
//  Created by van Lint Jason on 1/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString* CurrentAddress;
}
@end

@implementation ViewController
@synthesize mapView,names, vicinitys, d4,OwnAdress;

- (void)viewDidLoad
{
     [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Make this controller the delegate for the map view.
    self.mapView.delegate = self;     
    
    // Ensure that we can view our own location in the map view.
    [self.mapView setShowsUserLocation:YES];

    //Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some paramater for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //Set the first launch instance variable to allow the map to zoom on the user location when first launched.
    firstLaunch=YES;
    
    [self performSelector:@selector(getCenterCoordinates) withObject:nil afterDelay:3.0f];
       
}
-(void)getCenterCoordinates
{
    NSLog(@" center lat %f  long %f", currentCentre.latitude,currentCentre.longitude);
    CLLocation* coord = [[CLLocation alloc]initWithLatitude:currentCentre.latitude longitude:currentCentre.longitude];
    NSLog(@" cord %@", coord);
    [self getAddressFromLocation:coord];
}
-(void)getAddressFromLocation:(CLLocation *)location {
    __block NSString *address;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             
             address = [NSString stringWithFormat:@"%@ %@,%@ %@", [placemark subThoroughfare],[placemark thoroughfare],[placemark locality], [placemark administrativeArea]];
             CurrentAddress = address;
             NSLog(@"%@",address);
             OwnAdress.title = CurrentAddress;
         }
         
     }];

    
}
-(void) queryGooglePlaces: (NSString *) googleType
{
    
    
    // Build the url string we are going to sent to Google. NOTE: The kGOOGLE_API_KEY is a constant which should contain your own API key that you can obtain from Google. See this link for more info:
    // https://developers.google.com/maps/documentation/places/#Authentication
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%@&types=%@&sensor=false&key=%@", currentCentre.latitude, currentCentre.longitude, [NSString stringWithFormat:@"%i", currenDist], googleType, kGOOGLE_API_KEY];
    
  //  NSLog(@" request %@", url);
    //Formulate the string as URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData 
                          
                          options:kNilOptions 
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"];
    NSLog(@" jason response %@", json);
       
    names = [NSMutableArray array];
    vicinitys = [NSMutableArray array];
    for (NSDictionary* elements in places){
        NSString * name = [elements objectForKey:@"name"];
        NSString * vicinity = [elements objectForKey:@"vicinity"];
        [names addObject:name];
        [vicinitys addObject:vicinity];
    }
    d4 = [NSDictionary dictionaryWithObjects:vicinitys forKeys:names];
   NSLog(@" objects %@", names);
    
    
   // [self ConvertFromUC:names];
    
    
    
    //NSDictionary *fe =[places objectAtIndex:0];
   // NSArray* na = [NSArray arrayWithObjects:@"name",@"vicinity", nil];
    //NSLog(@" allKyes %@", fe.allKeys);
    //NSLog(@" names %@", [fe objectsForKeys:na notFoundMarker:[NSNull null]]);
  //  NSLog(@" results %@", fe);
  //  for (names in places) {
        
   // }
    //Write out the data to the console.
    
    
    //Plot the data in the places array onto the map with the plotPostions method.
     
      [self plotPositions:places];
    
    
}
/*
-(void)ConvertFromUC:(NSMutableArray*)namesArr
{
    NSLog(@" rabotaet");
    for (NSString* element in namesArr) {
        NSString * firstLetter = [element substringWithRange:NSMakeRange(1, 3)];
         NSLog(@" element %@", firstLetter);
        if ([firstLetter isEqualToString:@"\\"]) {
            NSLog(@" element %@", firstLetter);
        }
    }
 NSString *input = @"\\u5404\\u500b\\u90fd";
 NSString *convertedString = [input mutableCopy];
 
 CFStringRef transform = CFSTR("Any-Hex/Java");
 CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
 
 NSLog(@"convertedString: %@", convertedString);
}
 */
- (void)plotPositions:(NSArray *)data
{
    //Remove any existing custom annotations but not the user location blue dot.
    for (id<MKAnnotation> annotation in mapView.annotations) 
    {
        if ([annotation isKindOfClass:[MapPoint class]]) 
        {
            //[mapView removeAnnotation:annotation];
        }
    }
    
    
    //Loop through the array of places returned from the Google API.
    for (int i=0; i<[data count]; i++)
    {
        
        //Retrieve the NSDictionary object in each index of the array.
        NSDictionary* place = [data objectAtIndex:i];
        
        //There is a specific NSDictionary object that gives us location info.
        NSDictionary *geo = [place objectForKey:@"geometry"];
        
        
        //Get our name and address info for adding to a pin.
        NSString *name=[place objectForKey:@"name"];
              NSString *vicinity=[place objectForKey:@"vicinity"];
              
              //Get the lat and long for the location.
        NSDictionary *loc = [geo objectForKey:@"location"];
        
        //Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord;
        
        //Set the lat and long.
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        
        //Create a new annotiation.
        MapPoint *placeObject = [[MapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        
        
        [mapView addAnnotation:placeObject];
    }
  }
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"gotolist"])
    {
        DetailViewController* dvc = [segue destinationViewController];
        dvc.namesArr = d4;
    }
    if ([[segue identifier] isEqualToString:@"gettaxi"]) {
        SRZ_TaxiCallViewController *srz = [segue destinationViewController];
        srz.name = @"Current Position";
        srz.vicinity = CurrentAddress;
    }
}
- (IBAction)toolBarButtonPress:(id)sender {
   // UIBarButtonItem *button = (UIBarButtonItem *)sender;
   
    
    //Use this title text to build the URL query and get the data from Google. Change the radius value to increase the size of the search area in meters. The max is 50,000.
   
    //for (NSString*element in fullListOfPlaces) {
        //[self queryGooglePlaces:element];
   // }
    NSString *fullStrings = @"accounting%7Cairport%7Camusement_park%7Caquarium%7Cart_gallery%7Catm%7Cbakery%7Cbank%7Cbar%7Cbeauty_salon%7Cbicycle_sto%7Cbook_store%7Cbowling_alley%7Cbus_station%7Ccafe%7Ccampground%7Ccar_dealer%7Ccar_rental%7Ccar_repair%7Ccar_wash%7Ccasino%7Ccemetery%7Cchurc%7Ccity_hall%7Cclothing_store%7Cconvenience_store%7Ccourthouse%7Cdentist%7Cdepartment_store%7Cdoctor%7Celectrician%7Celectronics_store%7Cembassy%7Cestablishment%7Cfinance%7Cfire_station%7Cflorist%7Cfood%7Cfuneral_home%7Cfurniture_store%7Cgas_station%7Cgeneral_contractor%7Cgrocery_or_supermarket%7Cgym%7Chair_care%7Chardware_store%7Chealth%7Chindu_temple%7Chome_goods_store%7Chospital%7Cinsurance_agency%7Cjewelry_store%7Claundry%7Clawyer%7Clibrary%7Cliquor_store%7Clocal_government_office%7Clocksmith%7Clodging%7Cmeal_delivery%7Cmeal_takeaway%7Cmosque%7Cmovie_rental%7Cmovie_theater%7Cmoving_company%7Cmuseum%7Cnight_club%7Cpainter%7Cpark%7Cparking%7Cpet_store%7Cpharmacy%7Cphysiotherapist%7Cplace_of_worship%7Cplumber%7Cpolice%7Cpost_office%7Creal_estate_agency%7Crestaurant%7Croofing_contractor%7Crv_park%7Cschool%7Cshoe_store%7Cshopping_mall%7Cspa%7Cstadium%7Cstorage%7Cstore%7Csubway_station%7Csynagogue%7Ctaxi_stand%7Ctrain_station%7Ctravel_agency%7Cuniversity%7Cveterinary_care%7Czoo";
    /*
    NSString* fs = @"accounting%7Cairport%7Camusement_park%7Caquarium%7Cart_gallery%7Catm%7Cbakery%7Cbank%7Cbar%7Cbeauty_salon%7Cbicycle_sto%7Cbeauty_salon%7Cbicycle_sto%7Cbook_store%7Cbowling_alley%7Cbus_station%7Ccafe%7Ccampground%7Ccar_dealer%7Ccar_rental%7Ccar_repair%7Ccar_wash%7Ccasino%7Ccemetery%7Cchurc%7Ccity_hall%7Cclothing_store%7Cconvenience_store%7Ccourthouse%7Cdentist%7Cdepartment_store%7Cdoctor%7Celectrician%7Celectronics_store%7Cembassy%7Cestablishment%7Cfinance%7Cfire_station%7Cflorist%7Cfood%7Cfuneral_home%7Cfurniture_store%7Cgas_station%7Cgeneral_contractor%7Cgrocery_or_supermarket%7Cgym%7Chair_care%7Chardware_store%7Chealth%7Chindu_temple%7Chome_goods_store%7Chospital%7Cinsurance_agency%7Cjewelry_store%7Claundry%7Clawyer%7Clibrary%7Cliquor_store%7Clocal_government_office%7Clocksmith%7Clodging%7Cmeal_delivery%7Cmeal_takeaway%7Cmosque%7Cmovie_rental%7Cmovie_theater%7Cmoving_company%7Cmuseum%7Cnight_club%7Cpainter%7Cpark%7Cparking%7Cpet_store%7Cpharmacy%7Cphysiotherapist%7Cplace_of_worship%7Cplumber%7Cpolice%7Cpost_office%7Creal_estate_agency%7Crestaurant%7Croofing_contractor%7Crv_park%7Cschool%7Cshoe_store%7Cshopping_mall%7Cspa%7Cstadium%7Cstorage%7Cstore%7Csubway_station%7Csynagogue%7Ctaxi_stand%7Ctrain_station%7Ctravel_agency%7Cuniversity%7Cveterinary_care%7Czoo";
     */
    [self queryGooglePlaces:fullStrings];
                            }
- (IBAction)ListButton:(id)sender {
    NSLog(@" Show LIst ");
    [self performSegueWithIdentifier:@"gotolist" sender:self];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setOwnAdress:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - MKMapViewDelegate methods.
    
- (IBAction)GetTaxiButton:(id)sender {
    
    [self performSegueWithIdentifier:@"gettaxi" sender:self];
    
}
    
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{    
    
    //Zoom back to the user location after adding a new set of annotations.
    
    //Get the center point of the visible map.
    CLLocationCoordinate2D centre = [mv centerCoordinate];
    
    MKCoordinateRegion region;
    
    //If this is the first launch of the app then set the center point of the map to the user's location.
    if (firstLaunch) {
        region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,1000,1000);
        firstLaunch=NO;
    }else {
        //Set the center point to the visible region of the map and change the radius to match the search radius passed to the Google query string.
        region = MKCoordinateRegionMakeWithDistance(centre,currenDist,currenDist);
    }
    
    //Set the visible region of the map.
    [mv setRegion:region animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //Define our reuse indentifier.
    static NSString *identifier = @"MapPoint";   
    
    
    if ([annotation isKindOfClass:[MapPoint class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }

        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    
    return nil;    
}
    
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    //Get the east and west points on the map so we calculate the distance (zoom level) of the current map view.
    /*
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    */
    //Set our current distance instance variable.
    currenDist = 200;
    
    //Set our current centre point on the map instance variable.
    currentCentre = self.mapView.centerCoordinate;
   }    

@end
