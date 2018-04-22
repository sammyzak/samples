<script language="javascript">
// Set slideShowSpeed (milliseconds)
var slideShowSpeed = 3500;

// Duration of crossfade (seconds)
var crossFadeDuration = 6;

// Specify the image files
var Pic = new Array(); // don't touch this

// to add more images, just continue the pattern, adding to the array below
Pic[0] = 'http://www.discountsnhs.com/site/images/cobella.jpg';                 //Cobella
Pic[1] = 'http://www.discountsnhs.com/site/images/awardpanel_12.jpg';			//Toni &amp; Guy		
Pic[2] = 'http://www.discountsnhs.com/site/images/Banner_NORTHER_MOTORS.jpg';	//Northern MOT
Pic[3] = 'http://www.discountsnhs.com/site/images/Dental Arts Banner.JPG';		//Dental Art
Pic[4] = 'http://www.discountsnhs.com/site/images/awardpanel_14.jpg';			//CO-OP	
Pic[5] = 'http://www.discountsnhs.com/site/images/Banner_GAYLORD.jpg';			//Gaylord	
Pic[6] = 'http://www.discountsnhs.com/site/images/awardpanel_20.jpg';			//Tatra
Pic[7] = 'http://www.discountsnhs.com/site/images/awardpanel_5.jpg';			//k Furniture
Pic[8] = 'http://www.discountsnhs.com/site/images/awardpanel_2.jpg';			//Rush
Pic[9] = 'http://www.discountsnhs.com/site/images/awardpanel_6.jpg';			//Blue elephant
Pic[10] = 'http://www.discountsnhs.com/site/images/Dimple_panel.jpg';			//Dimple Group
Pic[11] = 'http://www.discountsnhs.com/site/images/awardpanel_9.jpg';			//La Porte
Pic[12] = 'http://www.discountsnhs.com/site/images/awardpanel_4.jpg';			//Hob
Pic[13] = 'http://www.discountsnhs.com/site/images/Giftos_panel.jpg';			//giftos
Pic[14] = 'http://www.discountsnhs.com/site/images/MMS_panel.jpg';				//MMS
Pic[15] = 'http://www.discountsnhs.com/site/images/awardpanel_8.jpg';			//Brides by Losners
Pic[16] = 'http://www.discountsnhs.com/site/images/awardpanel_1.jpg';			//Enterprise
Pic[17] = 'http://www.discountsnhs.com/site/images/awardpanel_3.jpg';			//Indian Zing
Pic[18] = 'http://www.discountsnhs.com/site/images/awardpanel_10.jpg';			//Concrete
Pic[19] = 'http://www.discountsnhs.com/site/images/awardpanel_13.jpg';			//Old Firehouse
Pic[20] = 'http://www.discountsnhs.com/site/images/awardpanel_15.jpg';			//Lucketts
Pic[21] = 'http://www.discountsnhs.com/site/images/awardpanel_16.jpg';			//Bangkok Lounge

// do not edit anything below this line
// =======================================
var t;
var j = 0;
var p = Pic.length;
var preLoad = new Array();

for (i = 0; i < p; i++){
	preLoad[i] = new Image();
	preLoad[i].src = Pic[i];
}

function runSlideShow(){
	if (document.all){
		document.images.SlideShow.style.filter="blendTrans(duration=2)";
		document.images.SlideShow.style.filter="blendTrans(duration=crossFadeDuration)";
		document.images.SlideShow.filters.blendTrans.Apply();
	}

	document.images.SlideShow.src = preLoad[j].src;

	if (document.all){
		document.images.SlideShow.filters.blendTrans.Play();
	}

	j = j + 1;

	if (j > (p-1)) j = 0

	t = setTimeout('runSlideShow()', slideShowSpeed);
}
</script>