component {


	// Module Properties
	this.title 				= "BlogCFCCompat";
	this.author 			= "Brad Wood";
	this.webURL 			= "http://www.codersrevolution.com";
	this.description 		= "Makes ContentBox compatible with BlogCFC-style SES routes to old links to your site will still work after you convert your blog over.";
	this.version			= "1.0";
	this.entryPoint			= "";
	
	function configure(){


		interceptors = [
			// This interceptor will look for missing pages and see if they're legacy URLs.
			{class="#moduleMapping#.interceptors.BlogCFCCompat"}
		];

	}

	function onLoad(){
		// When the module loads, add its routes to the SES interceptor
		var interceptorService = wirebox.getInstance(dsl="coldbox:interceptorService");
		var SES = interceptorService.getInterceptor("SES");
		
		// Order is important!!
		
		// http://www.example.com/2013
		SES.addRoute(pattern=":year-numeric{4}",										handler="contentbox-ui:blog", action="archives", append=false);
		//http://www.example.com/2013/7
		SES.addRoute(pattern=":year-numeric{4}/:month-numeric{1,2}",					handler="contentbox-ui:blog", action="archives", append=false);
		// http://www.example.com/2013/7/4
		SES.addRoute(pattern=":year-numeric{4}/:month-numeric{1,2}/:day-numeric{1,2}",	handler="contentbox-ui:blog", action="archives", append=false);
		// http://www.example.com/2013/7/4/why-i-love-independance-day
		SES.addRoute(pattern=":year-numeric{4}/:month-numeric{1,2}/:day-numeric{1,2}/:entrySlug", handler="contentbox-ui:blog", action="entry", append=false);
	}

}