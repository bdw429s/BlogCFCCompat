component {
	property name="categoryService" inject="categoryService@cb";
	property name="CBHelper" inject="CBHelper@cb";

	function cbui_onPageNotFound() {
		// This is the slug that wasn't found.  Let's check and see if it's a BlogCFC page or category.
		var slug = arguments.interceptData.missingPage;
				
		// It's a page
		// http://www.example.com/page.cfm/pageSlug
		if( left(slug,9) == 'page.cfm/' && len(slug) > 9) {
			// 404 already set prior to interception announcement
			event.setHTTPHeader("200","OK");
			slug = mid(slug,10,len(slug));
			setNextEvent( URL=CBHelper.linkPageWithSlug( slug ), statusCode="301" );
		}
		
		// Perhaps it's a category.
		// http://www.example.com/index.cfm/categorySlug
		var category = categoryService.findBySlug(slug);
		
		// Yep, it is. I'm using setNextEvent instead of runEvent, because cb.isIndexView() uses event.getCurrentEvent() 
		// and it gets confused and thinks it's showing a page since that's the route that was matched originally.
		if( !isnull( category ) ) {
			// 404 already set prior to interception announcement
			event.setHTTPHeader("200","OK");
			setNextEvent( URL=CBHelper.linkCategory( category ), statusCode="301" );
		}
		
		// If we make it here, it isn't a page or a category-- just let the page not 
		// found bubble up and take over.  You gave it your best shot, chap.
	} 

}