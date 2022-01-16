$('#menuImage').click(function() {
	console.log("Been clicked, y'all");

	if ($("#navDiv").css('visibility') == 'hidden') {

		$('#navDiv').css('visibility', 'visible');

	} else {

		$('#navDiv').css('visibility', 'hidden');

	}
});
