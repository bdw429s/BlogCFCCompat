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
			{class="#moduleMapping#.interceptors.BlogCFCCompat"}
		];

	}

	function onLoad(){
		var interceptorService = wirebox.getInstance(dsl="coldbox:interceptorService");
		var SES = interceptorService.getInterceptor("SES");
		
		// Order is important
		SES.addRoute(pattern=":year-numeric{4}",										handler="contentbox-ui:blog", action="archives", append=false);
		SES.addRoute(pattern=":year-numeric{4}/:month-numeric{1,2}",					handler="contentbox-ui:blog", action="archives", append=false);
		SES.addRoute(pattern=":year-numeric{4}/:month-numeric{1,2}/:day-numeric{1,2}",	handler="contentbox-ui:blog", action="archives", append=false);
		
		SES.addRoute(pattern=":year-numeric{4}/:month-numeric{1,2}/:day-numeric{1,2}/:entrySlug", handler="contentbox-ui:blog", action="entry", append=false);
	}

}