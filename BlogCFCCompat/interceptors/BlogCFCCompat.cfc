component {
	property name="categoryService" inject="categoryService@cb";
	property name="CBHelper" inject="CBHelper@cb";

	function cbui_onPageNotFound() {
		var slug = arguments.interceptData.missingPage;
		var category = categoryService.findBySlug(slug);
		
		if( !isnull( category ) ) {
			event.setHTTPHeader("200","OK");
			
			setNextEvent( URL=CBHelper.linkCategory( category ) );
		}
	} 

}