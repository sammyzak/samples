<div id="nav">
	<a href="default.aspx">Home</a>
	<a href="about.aspx">About Us</a>
	<a href="london.aspx">London Discounts</a>
	<a href="home-county.aspx">Home County Discounts</a>
	<a href="newsletters.aspx">Newsletters</a>
    <a href="refer.aspx">Refer a Business</a>
    <span class="search-nav"></span>
</div>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="./Scripts/jquery.autocomplete.min.js"></script>
<script type="text/javascript" src="./Scripts/jquery.watermark.js"></script>
<script type="text/javascript">
	var searchBoxText = "business, business type, tube station or county";

	String.prototype.toProperCase = function(){
		return this.toLowerCase().replace(/^(.)|\s(.)|-(.)/g, 
		function($1) { return $1.toUpperCase(); });
	}
	$(document).ready(function(){
		$("div#search input").val("");
		$("div#search input").watermark(searchBoxText);
		$("div#search input").parent().children("label").removeAttr("style").addClass("watermark");
		$("div#search").prepend("Search:");
		/*$("div#search").width("200px");*/
		$.get('./Scripts/getAutocomplete.aspx', function(data) {
			$("#SearchBox").autocomplete(data.split("|"),{
				width:'auto',
				matchContains:'word',
				formatItem:function(item, index, total){
					//what is displayed in drop down
					var icon = "";
					var txt = "";
					switch (item[0].split(";")[2]){
					case '1': //company logo
						icon = "<img style='width: 12px; height: 12px' src='./images/logos/"+item[0].split(";")[1]+".jpg' />&nbsp;";
						txt = item[0].split(";")[0];
						break;
					case '2': //business type logo
						icon = "<img style='width: 12px; height: 12px' src='./images/buildings.png' />&nbsp;";
						txt = item[0].split(";")[0]+"s";
						break;
					case '3': //tube station logo
						icon = "<img style='width: 12px; height: 12px' src='./images/tube.png' />&nbsp;";
						txt = item[0].split(";")[0].toProperCase();
						break;
                    case '4': //county logo
						icon = "<img style='width: 12px; height: 12px' src='./images/county.png' />&nbsp;";
						txt = item[0].split(";")[0].toProperCase();
						break;    
					default:
						break;
					}
					
					return icon + txt; /* + (item[0].split(";")[2]=='2'?'s':'');*/
				},
				formatMatch:function(item){
					//words that are searched
					return item[0].split(";")[0];
				},
				formatResult:function(item){
					//what to display
					/*alert(item);*/
					return item[0].split(";")[0];
				}
			});
		});

		$("#SearchBox").result(function(event, data, formatted) {
			var url = "";
			switch(String(data).split(";")[2]){
			case '1': //company
				url = "./business.aspx?BID="+String(data).split(";")[1];
				break;
			case '2': //business type
				url = "./businesstype.aspx?BTID="+String(data).split(";")[1];
				/*alert("Cannot search 'Business Types'");*/
				break;
			case '3': //tube station
				url = "./station.aspx?TID="+String(data).split(";")[1];
				break;
            case '4': //county
				url = "./county.aspx?HCID="+String(data).split(";")[1];
				break;
			default:
				break;
			}
			if(url!="")  window.location = url;
		});
	});
</script>
