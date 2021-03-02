var ui = __godzilla_ui_manager__
var console = {
  log: function () {
    sendMessage('ConsoleLog', JSON.stringify(['log', ...arguments]));
  },
};


var godzilla = {
	render:function(){
		var renderObject = {
			type: 'div',
			style: {
				flex: 1,
				backgroundColor: 'white',
			},
		}
		sendMessage('updateRenderObject',  JSON.stringify(['updateRenderObject', renderObject]));
	}
}