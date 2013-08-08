$(function () {
	// Refresh every (ms)
	var refreshId = 0;
	
	var successHandler = function (response) {
		$("#value").val(response.value);
		var tms = new Date().getTime() / 1000;
		$("#time").val(tms);
		var valueExport = $("#valueExport").text();
		$("#valueExport").text(valueExport + response.value + ";" + tms + ";\n");
	};
	
	var errorHandler = function (jqxhr, status, errorThrown) {
		console.log(status + " - " + errorThrown);
		$("#value").val("## NO VALUE ##");		
	};

	var checkValue = function() {
		
		var appId = $("#appId").val();
		var ctxId = $("#ctxId").val();
		var natId = $("#natId").val();		
		var url = "http://localhost:4568/server/" + appId + "/" + ctxId + "/" + natId;
				
		$.ajax({
			url: url,
			type: "GET",
            dataType: "jsonp",
            jsonp: 'jsonp_callback', 			
		  	success: successHandler,
			error: errorHandler		  
		});	
	}
	
	var startCheck = function() {
		if (refreshId == 0) {
			$("#checkLbl").show();
        	refreshId = setInterval(checkValue, $("#rateSel").val());
        }
	};
	
	var stopCheck = function() {
		if (refreshId != 0) {
			clearInterval(refreshId);	
			refreshId = 0;	
			$("#checkLbl").hide();
		}
	};
	
	var clearValues = function() {
		$("#value").val("");
		$("#time").val("");
		$("#valueExport").text("");	
	}
			
 	$("#checkOneBtn").on("click", checkValue);
 	$("#checkBtn").on("click", startCheck);
 	$("#stopBtn").on("click", stopCheck); 	
 	$("#clearBtn").on("click", clearValues); 	
});