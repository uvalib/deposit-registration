(function() {
	"use strict";
	function initPage() {
		$('.data-table.six-col').DataTable({
			"aoColumns": [
				null,
				null,
				null,
				null,
                null,
				{"bSortable": false}
			],
            "aaSorting": [ [ 0, "asc" ], [ 2, "desc" ] ]
		});

	}

	document.addEventListener("turbolinks:load", function() {
		initPage();
	});
})();
