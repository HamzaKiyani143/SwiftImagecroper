
#import <XCTest/XCTest.h>
#import "RSKImageCropViewController.h"

@interface RSKImageCropViewController (Testing)

- (void)cropImage;
- (void)setRotationAngle:(CGFloat)rotationAngle;

@end

@interface RSKImageCropperPerformanceTests : XCTestCase

@property (strong, nonatomic) RSKImageCropViewController *imageCropViewController;

@end

@implementation RSKImageCropperPerformanceTests

- (void)setUp
{
    [super setUp];
    
    self.imageCropViewController = [[RSKImageCropViewController alloc] initWithImage:[UIImage imageNamed:@"photo"]];
    [self.imageCropViewController view];
    [self.imageCropViewController.view setNeedsUpdateConstraints];
    [self.imageCropViewController.view updateConstraintsIfNeeded];
    [self.imageCropViewController.view setNeedsLayout];
    [self.imageCropViewController.view layoutIfNeeded];
    [self.imageCropViewController viewWillAppear:NO];
    [self.imageCropViewController viewDidAppear:NO];
}

- (void)tearDown
{
    self.imageCropViewController = nil;
    
    [super tearDown];
}

- (void)testCropImagePerformanceWithDefaultSettings
{
    [self measureBlock:^{
        [self.imageCropViewController cropImage];
    }];
}

- (void)testCropImagePerformanceWithCustomRotationAngle
{
    [self.imageCropViewController setRotationAngle:M_PI_4];
    [self measureBlock:^{
        [self.imageCropViewController cropImage];
    }];
}

- (void)testCropImagePerformanceWhenApplyMaskToCroppedImage
{
    self.imageCropViewController.applyMaskToCroppedImage = YES;
    [self measureBlock:^{
        [self.imageCropViewController cropImage];
    }];
}

- (void)testCropImagePerformanceWithCustomRotationAngleAndWhenApplyMaskToCroppedImage
{
    [self.imageCropViewController setRotationAngle:M_PI_4];
    self.imageCropViewController.applyMaskToCroppedImage = YES;
    [self measureBlock:^{
        [self.imageCropViewController cropImage];
    }];
}

@end
