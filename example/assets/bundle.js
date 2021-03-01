global.vdom = {};

function buildVDom() {
  return (vdom = {
    type: 'div',
    style: {
      flex: 1,
      backgroundColor: 'white',
    },
    children: [
      {
        type: 'img',
        source: 'assets/js.ico',
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
  });
}
