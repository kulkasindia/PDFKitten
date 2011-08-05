#import "Page.h"


@implementation PageContentView

//- (void)drawRect:(CGRect)rect
//{
//	
//}

@end

@implementation Page

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		UIView *view = [self contentView];
		view.frame = frame;
//		view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.contentView = view;
		[self addSubview:view];
		
        self.maximumZoomScale = 5.0;
        
		self.delegate = self;
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        [doubleTap release];
    }
    return self;
}

/* Double tap zooms the content to fill the container view */
- (void)didDoubleTap:(UITapGestureRecognizer *)recognizer
{
    CGFloat hScale = CGRectGetWidth(self.bounds) / CGRectGetWidth(contentView.bounds);
    CGFloat vScale = CGRectGetHeight(self.bounds) / CGRectGetHeight(contentView.bounds);
    [self setZoomScale:MIN(hScale, vScale) animated:YES];
}

- (UIView *)contentView
{
	if (!contentView)
	{
		contentView = [[UIView alloc] initWithFrame:CGRectZero];
	}
	return contentView;
}

#pragma mark - UIScrollView delegate

/* Zoom the content view when user pinches the scroll view */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return contentView;
}

/* Make the content view center on screen when zoomed out */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	CGRect frame = self.contentView.frame;
    frame.origin = CGPointZero;
	// Calculate how much of the content view is outside the screen
	CGSize totalInset = CGSizeMake(CGRectGetWidth(contentView.frame) - CGRectGetWidth(self.bounds), 
								   CGRectGetHeight(contentView.frame) - CGRectGetHeight(self.bounds));
	if (totalInset.width < 0)
	{
		frame.origin.x = - totalInset.width / 2;
	}
	if (totalInset.height < 0)
	{
		frame.origin.y = - totalInset.height / 2;
	}
	self.contentView.frame = frame;
}


@synthesize pageNumber, contentView;
@end
