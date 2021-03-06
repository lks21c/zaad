<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>


<!--==================================
=            START MAIN WRAPPER      =
===================================-->
<section class="main-wrapper">
	<div class="container">
		<div class="row">
			<div class="col-sm-9">
				
				<div class="newedge-latest-videos mtb10">
					<div class="z-section-title">
						<div class="row">
							<div class="col-sm-6">
								<h2 class="pull-left"> 
									#${text}
								</h2>
							</div>
							<div class="col-sm-6">
								<div id="sort-btn" class="btn-group pull-right" role="group">
									<button type="button" class="btn btn-xs btn-default btn-trending active">Trending</button>
								  	<button type="button" class="btn btn-xs btn-default btn-popular">Popular</button>
								</div>
							</div>
						</div>
					</div>
					
					<div id="search-video-div">
					</div>
					
					<div class="row">
						<div class="z-see-all">
							<a id="search-video-div-more" href="#search-video-div-1">
								<input type="button" class="btn btn-default zaad-more" value="Load More">
							</a>
						</div>
					</div>
				</div>
			</div> <!-- //col-sm-9 -->	


			<!--  col-sm-3 -->
			<div class="col-sm-3">
				<div class="row">
					<div class="col-sm-12">
						<h4>Related Tags</h4>
						<ul id="related-tags" class="z-list-related-tags-text">
							<li>#tag1(15)</li>
							<li>#tag2(15)</li>
							<li>#tag3(15)</li>
						</ul>
					</div>
				</div>
			</div> <!-- //col-sm-3 -->
		</div> <!-- //row -->
	</div> <!-- //container -->
</section>
<!--====  End of MAIN WRAPPER  ====-->


<script>
var sortType = "R";

$(document).ready(function() {
	getData("init");
	
	$('#sort-btn button').click(function() {
	    $('#sort-btn button').addClass('active').not(this).removeClass('active');
	    if ( $(this).hasClass('btn-trending') ) {
		    sortType = "R";
	    } else {
	    	sortType = "P";
	    }
	    
	    getData("");
	});
});
</script>

<script>
var getData = function(type) {
	var firstPageNo = 1;
	listSearchVideo(firstPageNo);
	
	if ( "init" == type ) {
		bindMorePage();
		
		$.ajax({
			type : "GET",
			url : "${pageContext.servletContext.contextPath}" + "/tag/related?size=5&text=${text}",
			success : function(data) {
				var html = "";
				for ( var i = 0; i < data.length; i++ ) {
					html += "<li>" + $z.link.getTagCountAnchor("${pageContext.servletContext.contextPath}", data[i].text, data[i].count) + "</li>";
				}
				
				
				$('#related-tags').html(html);
			},
			dataType : "json"
		});
	}
};

var bindMorePage = function() {
	$('#search-video-div-more').bind('click', function() {
		$z.ajax.listVideoCol4("${pageContext.servletContext.contextPath}", "/search/list", $(this).data('page'), $z.C.paging.list.search, "search-video-div", "next", sortType, "${text}");
	});
};
</script>

<script>
var listSearchVideo = function(firstPageNo) {
	$z.ajax.listVideoCol4("${pageContext.servletContext.contextPath}", "/search/list", firstPageNo, $z.C.paging.list.search, "search-video-div", "first", sortType, "${text}");
};
</script>
