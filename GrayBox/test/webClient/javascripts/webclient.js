$(function () {
	var refreshId = 0;
	var appId;
	var ctxId;
	var natId;		
		
	var successHandler = function (response) {
		var tms = new Date().getTime() / 1000;
		$("#value").val(response.value);
		$("#time").val(tms);
		var valueExport = $("#valueExport").text();
		$("#valueExport").text(valueExport + response.value + ";" + tms + ";\n");
	};
	
	var errorHandler = function (jqxhr, status, errorThrown) {
		console.log(status + " - " + errorThrown);
		$("#value").val("## NO VALUE ##");		
		$("#time").val(tms);
		var valueExport = $("#valueExport").text();
		$("#valueExport").text(valueExport + "## NO VALUE ##;" + tms + ";\n");
	};

	var checkValue = function() {		
		$.ajax({
			url: "http://localhost:4568/server/" + appId + "/" + ctxId + "/" + natId,
			type: "GET",
            dataType: "jsonp",
            jsonp: 'jsonp_callback', 			
		  	success: successHandler,
			error: errorHandler		  
		});	
	}
	
	var startCheck = function() {
		if (refreshId == 0) {
			appId = $("#appId").val();
			ctxId = $("#ctxId").val();
			natId = $("#natId").val();				
        	refreshId = setInterval(checkValue, $("#rateSel").val());
			$("#checkLbl").show();
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