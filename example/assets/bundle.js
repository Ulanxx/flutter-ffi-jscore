global.vdom = {};

function buildvdom() {
   vdom = {
    type: 'div',
    style: {
      flex: 1,
      backgroundColor: 'white',
    },
    children: [
      {
        type: 'img',
        source: 'assets/flutter.png',
        style: {
          width: 100,
          height: 100,
        },
      },
      {
        type: 'p',
        style: {
          width: 100,
          height: 100,
        },
      },
    ],
  };
}


function getvdom(){
	return JSON.stringify(vdom);
}