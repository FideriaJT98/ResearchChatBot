$(document).ready(function() {

	//---------------------------------- Add dynamic html bot content(Widget style) ----------------------------
	// You can also add the html content in html page and still it will work!
	
	// ------------------------------------------ Toggle chatbot -----------------------------------------------
	$('.profile_div').click(function() {
		$('.profile_div').toggle();
		$('.chatCont').toggle();
		$('.bot_profile').toggle();
		$('.chatForm').toggle();
		document.getElementById('chat-input').focus();
	});

	$('.close').click(function() {
		$('.profile_div').toggle();
		$('.chatCont').toggle();
		$('.bot_profile').toggle();
		$('.chatForm').toggle();
	});


	// Session Init (is important so that each user interaction is unique)--------------------------------------
	var session = function() {
		// Retrieve the object from storage
		if(sessionStorage.getItem('session')) {
			var retrievedSession = sessionStorage.getItem('session');
		} else {
			// Random Number Generator
			var randomNo = Math.floor((Math.random() * 1000) + 1);
			// get Timestamp
			var timestamp = Date.now();
			// get Day
			var date = new Date();
			var weekday = new Array(7);
			weekday[0] = "Sunday";
			weekday[1] = "Monday";
			weekday[2] = "Tuesday";
			weekday[3] = "Wednesday";
			weekday[4] = "Thursday";
			weekday[5] = "Friday";
			weekday[6] = "Saturday";
			var day = weekday[date.getDay()];
			// Join random number+day+timestamp
			var session_id = randomNo+day+timestamp;
			// Put the object into storage
			sessionStorage.setItem('session', session_id);
			var retrievedSession = sessionStorage.getItem('session');
		}
		return retrievedSession;
		// console.log('session: ', retrievedSession);
	}

	// Call Session init
	var mysession = session();


	// on input/text enter--------------------------------------------------------------------------------------
	$('#chat-input').on('keyup keypress', function(e) {		
		var keyCode = e.keyCode || e.which;
		var text = $("#chat-input").val();		
		if (keyCode === 13) {
			if(text == "" ||  $.trim(text) == '') {
				e.preventDefault();
				return false;
			} else {
				$("#chat-input").blur();
				setUserResponse(text);
				var entered_text = text.split(' ').join('_');
				console.log(entered_text);
				send(entered_text, '/pass_val');
				e.preventDefault();
				return false;
			}
		}
	});

	//------------------------------------------- Send request to API.AI ---------------------------------------
	function send(text, url) {
		$.post(url, { human: text }, function(reply) {
			var json = JSON.parse(reply);
			console.log(json);
			var speech = json["info"]
			var alt = json["alt"]
			var type = json["type"]
			setBotResponse(speech, alt, type);
        });
	}

	function jsonp_callback(json){
		alert(json.reply);
	}


//'<img alt="Hilya H Shivute picture" src="' + val+ '" title="Hilya H Shivute picture" typeof="foaf:Image"></img>'

	//------------------------------------ Set bot response in result_div -------------------------------------
	function setBotResponse(val, alt, type) {
		setTimeout(function(){
			
			if (type === "mood"){						
				var BotResponse = '<p class="botResult">'+val+'</p><div class="clearfix"></div>';
				$(BotResponse).appendTo('#result_div');
			}
			else if (type === "image"){
				var BotResponse = '<img class="botResult" alt="' + alt + '" src="' + val+ '" title="' + alt + '" width="250" height="250" typeof="foaf:Image"></img><div class="clearfix"></div>';
				$(BotResponse).appendTo('#result_div');
				
				var imageFrom = '<a class="botResult" href="' + val + '" onclick="window.print();return false;">' + alt + '\'image found here </a><div class="clearfix"></div>'
				$(imageFrom).appendTo('#result_div');
				
				probe = "Anything you would like to know about NUST?"			
				var BotResponse = '<p class="botResult">'+probe+'</p><div class="clearfix"></div>';
				$(BotResponse).appendTo('#result_div');				
			}	
						
			scrollToBottomOfResults();
			hideSpinner();
		}, 500);
	}

	//------------------------------------- Set user response in result_div ------------------------------------
	function setUserResponse(val) {
		var UserResponse = '<p class="userEnteredText">'+val+'</p><div class="clearfix"></div>';
		$(UserResponse).appendTo('#result_div');
		$("#chat-input").val('');
		scrollToBottomOfResults();
		showSpinner();
		$('.suggestion').remove();
	}


	//---------------------------------- Scroll to the bottom of the results div -------------------------------
	function scrollToBottomOfResults() {
		var terminalResultsDiv = document.getElementById('result_div');
		terminalResultsDiv.scrollTop = terminalResultsDiv.scrollHeight;
	}


	//---------------------------------------- Ascii Spinner ---------------------------------------------------
	function showSpinner() {
		$('.spinner').show();
	}
	function hideSpinner() {
		$('.spinner').hide();
	}


	//------------------------------------------- Suggestions --------------------------------------------------
	function addSuggestion(textToAdd) {
		setTimeout(function() {
			var suggestions = textToAdd.replies;
			var suggLength = textToAdd.replies.length;
			$('<p class="suggestion"></p>').appendTo('#result_div');
			$('<div class="sugg-title">Suggestions: </div>').appendTo('.suggestion');
			// Loop through suggestions
			for(i=0;i<suggLength;i++) {
				$('<span class="sugg-options">'+suggestions[i]+'</span>').appendTo('.suggestion');
			}
			scrollToBottomOfResults();
		}, 1000);
	}

	// on click of suggestions get value and send to API.AI
	$(document).on("click", ".suggestion span", function() {
		console.log(text);
		var text = this.innerText;
		setUserResponse(text);
		send(text);
		$('.suggestion').remove();
	});
	// Suggestions end -----------------------------------------------------------------------------------------
});
