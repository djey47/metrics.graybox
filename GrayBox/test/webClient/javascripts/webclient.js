$(function () {
	// Refresh every (ms)
	var DELAY = 5000;
	
	var refreshId;
	
	var successHandler = function (response) {
		$("#value").val(response);
	};
	
	var errorHandler = function (jqxhr, status, errorThrown) {
		console.log(status + " - " + errorThrown);
	};

	var checkValue = function() {
		
		var appId = $("#appId").val();
		var ctxId = $("#ctxId").val();
		var natId = $("#natId").val();		
		var url = "http://localhost:4568/server/" + appId + "/" + ctxId + "/" + natId;
				
		$.ajax({
			url: url,
			type : "GET",
            dataType : "text/json",			
		  	success: successHandler,
			error: errorHandler		  
		});				
	}
	
	var startCheck = function() {
        refreshId = setInterval(checkValue, DELAY);
	};
	
	var stopCheck = function() {
		clearInterval(refreshId);		
	};
	
	
	
 	$("#checkBtn").on("click", startCheck);
 	$("#stopBtn").on("click", stopCheck); 	
});