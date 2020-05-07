

#import "RSKImageScrollView.h"

SpecBegin(RSKImageScrollView)

__block RSKImageScrollView *imageScrollView = nil;
__block UIImage *image = nil;

dispatch_block_t sharedIt = ^{
    [imageScrollView displayImage:image];
    
    [imageScrollView setNeedsLayout];
    [imageScrollView layoutIfNeeded];
};

before(^{
    imageScrollView = [[RSKImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    imageScrollView.clipsToBounds = NO;
    image = [UIImage imageNamed:@"photo"];
});

describe(@"visuals", ^{
    it(@"looks right by default", ^{
        sharedIt();
        
        expect(imageScrollView).haveValidSnapshot();
    });
    
    it(@"looks right with minimum zoom scale", ^{
        sharedIt();
        imageScrollView.zoomScale = imageScrollView.minimumZoomScale;
        
        expect(imageScrollView).haveValidSnapshot();
    });
    
    it(@"looks right with minimum zoom scale and when `aspectFill` is `YES`", ^{
        imageScrollView.aspectFill = YES;
        sharedIt();
        imageScrollView.zoomScale = imageScrollView.minimumZoomScale;
        
        expect(imageScrollView).haveValidSnapshot();
    });
});

after(^{
    imageScrollView = nil;
    image = nil;
});

SpecEnd
